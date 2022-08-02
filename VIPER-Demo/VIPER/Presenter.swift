//
//  Presenter.swift
//  VIPER-Demo
//
//  Created by Ahmed on 01/08/2022.
//

import Foundation

enum FetchError: Error {
    case failed
    case emptyData
}

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidFinished(with result: Result<[User], Error>)
}

class UserPresenter: AnyPresenter {
    
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet { interactor?.getUsers() }
    }
    
    var view: AnyView?

    
    func interactorDidFinished(with result: Result<[User], Error>) {
        switch result {
            
        case .success(let users):
            view?.update(with: users)
        case .failure(_):
            view?.update(with: "Somthing went wrong")
        }
    }
        
    
}
