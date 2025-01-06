# 포켓몬 도감 앱
> `https://pokeapi.co/` 서버에서 포켓몬 리스트를 받은 뒤 화면에 그리드 형태로 포켓몬들의 이미지를 보여줍니다. 각 셀을 탭하면 포켓몬의 상세정보를 볼 수 있습니다. 스크롤을 내리면 계속 새로운 포켓몬들의 정보를 불러옵니다.

| MainView | DetailView |
| ----- | ----- |
| <img src="https://github.com/user-attachments/assets/a1dd905e-9b9e-4316-b8b3-1f29104cb82d" width=430> | <img src="https://github.com/user-attachments/assets/73a69f6d-9fba-4d02-a959-81268a10ad78" width=430> |

## 개요
- 개인 프로젝트입니다.
- storyboard 없는 code base `UIKit`으로 구현했습니다.
- `MVVM` 아키텍처를 적용했습니다.
- `RxSwift`를 활용한 옵저버 패턴을 적용했습니다.
- `SnapKit` 라이브러리를 활용한 오토레이아웃을 적용했습니다.
- `Alamofire`와 `Moya` 라이브러리를 활용한 네트워크 통신을 구현했습니다.
> 개발과정을 담은 포스팅 시리즈 : https://velog.io/@emilyj4482/series/PictorialBookApp

## 프로젝트 구조
```
📦 PokemonPictorialBook
├── 📂 App
│   ├── AppDelegate.swift
│   ├── Assets.xcassets
│   ├── Info.plist
│   ├── LaunchScreen.storyboard
│   └── SceneDelegate.swift
├── 📂 Helper
│   ├── ImageURL.swift
│   ├── PokemonNameTranslator.swift
│   └── PokemonTypeTranslator.swift
├── 📂 Extension
│   ├── +Double.Swift
│   ├── +UIColor.swift
│   ├── +UIStackView.swift
│   └── +UIView.swift
├── 📂 Network
│   ├── NetworkError.swift
│   ├── NetworkManager.swift
│   └── PokemonAPI.swift
├── 📂 Model
│   ├── Pokemon.swift
│   └── PokemonURL.swift
├── 📂 Main
│   ├── MainView.swift
│   ├── PokemonCollectionView.swift
│   ├── PokemonCell.swift
│   ├── MainViewController.swift
│   └── MainViewModel.swift
├── 📂 Detail
│   ├── DetailView.swift
│   ├── DetailStackView.swift
│   ├── DetailViewController.swift
│   └── DetailViewModel.swift
```

## 기능 소개
### 01) 포켓몬 목록 화면
| MainView |
| ----- |
| <img src="https://github.com/user-attachments/assets/2e519567-99d7-4bea-9133-7754c0b51145" width=320> |
#### `UICollectionView`로 구현 - `UICollectionViewCompositionalLayout`, `UICollectionViewDiffableDataSource` 사용
> 이번 과제는 저에게 새로운 기술을 사용해보는 도전이 되었던 과제입니다. 늘 사용해왔던 `UICollectionViewDataSource`와 `UICollectionViewFlowLayout`이 아닌 처음 사용해보는 기술로 컬렉션 뷰를 구성하였습니다.
1. `CompositionalLayout`을 사용하여 `layout` 초기화
```swift
class PokemonCollectionView: UICollectionView {
    init() {
        let layout: UICollectionViewCompositionalLayout = {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalWidth(1/3))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/3))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
            
            let section = NSCollectionLayoutSection(group: group)
            
            return UICollectionViewCompositionalLayout(section: section)
        }()
        
        super.init(frame: .zero, collectionViewLayout: layout)
    }
```
2. `DiffableDataSource`로 셀 `provide`
```swift
class PokemonCollectionView: UICollectionView {
    private lazy var diffableDataSource: UICollectionViewDiffableDataSource<Section, PokemonResult> = {
        return UICollectionViewDiffableDataSource(collectionView: self) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.identifier, for: indexPath) as? PokemonCell else { return UICollectionViewCell() }
            
            cell.configure(itemIdentifier)
            
            return cell
        }
    }()

    init() {
        dataSource = diffableDataSource
    }
```
3. `NSDiffableDataSourceSnapshot`으로 `data` 공급
```swift
class PokemonCollectionView: UICollectionView {
    private var snapshot = NSDiffableDataSourceSnapshot<Section, PokemonResult>()

    init() {
        snapshot.appendSections([.main])
    }

    func updateDataSource(with items: [PokemonResult]) {
        snapshot.appendItems(items, toSection: .main)
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
}
```
#### `CollectionView` 데이터 바인딩 - `Moya`, `RxSwift` 사용
> 이번 프로젝트를 통해 다양한 라이브러리의 사용 경험을 키우고자 `Main` 화면에서는 `Moya`, `Detail` 화면에서는 `Alamofire`를 활용한 네트워크 통신으로 불러 온 데이터와 바인딩 했습니다.
```swift
class MainViewModel {
    private let disposeBag = DisposeBag()
    private let provider = MoyaProvider<PokemonAPI>()
    let pokemonList = PublishRelay<[PokemonResult]>()
    
    private var offset: Int = -20
    
    init() {
        fetchPokemonList()
    }
    
    func fetchPokemonList() {
        offset += 20
        
        provider.rx.request(.fetchURL(offset: offset))
            .map(PokemonURL.self)
            .subscribe(
                onSuccess: { [weak self] response in
                    self?.pokemonList.accept(response.results)
                },
                onFailure: { error in
                    print(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
}

```
```swift
class MainViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let vm: MainViewModel = .init()
    private var pokemons = [PokemonResult]()
    private lazy var containerView: MainView = .init()

    private func bind() {
        vm.pokemonList
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] pokemons in
                    self?.containerView.updateCollectionViewDataSource(with: pokemons)
                    self?.pokemons.append(contentsOf: pokemons)
                }
            )
            .disposed(by: disposeBag)
    }
}
```
#### `CollectionView` 셀 탭 동작 - `RxCocoa` 사용
> 포켓몬 이미지 셀을 탭하면 `DetailView`로 이동하게 되는데, 이때 역시 기존에 쓰던 방법인 `UICollectionViewDelegate`가 아닌 `RxCocoa`를 사용하여 구현했습니다.
```swift
class MainViewController: UIViewController {
    private var pokemons = [PokemonResult]()
    private lazy var containerView: MainView = .init()

    private func bind() {
        containerView.pokemonCollectionView.rx.itemSelected
            .subscribe(
                onNext: { [weak self] indexPath in
                    guard let self = self else { return }
                    let vc = DetailViewController(vm: .init(pokemons[indexPath.item].url))
                    navigationController?.pushViewController(vc, animated: true)
                }
            )
            .disposed(by: disposeBag)
    }
}
```
#### 무한 스크롤 구현 - `RxCocoa` 사용
> `UIScrollViewDelegate`의 `scrollViewDidEndDecelerating` 메소드에 구현했던 것을 `RxCocoa`의 `rx.didEndDecelerating`을 구독하는 방식으로 리팩토링 했습니다.
```swift
containerView.pokemonCollectionView.rx.didEndDecelerating
    .subscribe(
        onNext: { [weak self] in
            guard let scrollView = self?.containerView.pokemonCollectionView else { return }
            if scrollView.contentSize.height - scrollView.contentOffset.y == scrollView.visibleSize.height {
                self?.vm.fetchPokemonList()
            }
        }
    )
    .disposed(by: disposeBag)
```
<img src="https://github.com/user-attachments/assets/a831ad27-4e64-4356-a7ef-5f420f554fb3" width=320>

> 무한 스크롤 구현 당시 `scrollView.contentOffset.y` 값을 활용하여 디버깅을 하며 구현 방법을 고민했습니다. `scrollView`의 다양한 속성에 대해 생각하다가, `contentSize`에서 `contentOffset`을 빼면 `visibleSize`가 되는 것을 도출하여 구현에 성공했습니다.
### 02) 포켓몬 상세정보 화면
| DetailView |
| ----- |
| <img src="https://github.com/user-attachments/assets/0c07916c-a7f3-4c33-82a8-ce693642c14b" width=320> |
#### `UIStackView`로 구성

