//
//  Router.swift
//  VIPER-Demo
//
//  Created by Ahmed on 01/08/2022.
//

import Foundation
import UIKit

typealias EnteryPoint = AnyView & UIViewController
protocol AnyRouter: AnyObject {
    var view: EnteryPoint? { get }
    static func start() -> AnyRouter
}

class UserRouter: AnyRouter {
   
    
    var view: EnteryPoint?
    
    static func start() -> AnyRouter {
        
        let  view = UserViewController()
        let router = UserRouter(view: view)
        var presenter: AnyPresenter = UserPresenter()
        let interactor: AnyInteractor = UserInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
                
        return router
    }
    
    init(view: UIViewController & AnyView) {
        self.view = view
    }
    
     
}

