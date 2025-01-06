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
- 개발과정을 담은 포스팅 시리즈 : https://velog.io/@emilyj4482/series/PictorialBookApp

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
