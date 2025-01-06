//
//  +Reactive.swift
//  PokemonPictorialBook
//
//  Created by EMILY on 06/01/2025.
//

import UIKit
import RxSwift

// UIViewController의 viewWillAppear가 호출될 때 Observable<Void> 방출
extension Reactive where Base: UIViewController {
    var viewWillAppear: Observable<Void> {
        return methodInvoked(#selector(Base.viewWillAppear(_:)))
            .map { _ in }
    }
}

extension Reactive where Base: UIImageView {
    func loadImage(id: Int) -> Observable<UIImage?> {
        guard let url = URL(string: ImageURL.pokemon(id: id).urlString) else {
            return Observable.error(NSError(domain: "Invalid Image URL", code: -1, userInfo: nil))
        }
        
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    observer.onError(error)
                } else if let data = data, let image = UIImage(data: data) {
                    observer.onNext(image)
                    observer.onCompleted()
                } else {
                    observer.onNext(nil)
                    observer.onCompleted()
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
