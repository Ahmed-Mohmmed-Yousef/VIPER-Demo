//
//  Interactor.swift
//  VIPER-Demo
//
//  Created by Ahmed on 01/08/2022.
//

import Foundation

protocol AnyInteractor: AnyObject {
    var presenter: AnyPresenter? { get set }
    
    func getUsers()
}

class UserInteractor: AnyInteractor {
   
    
    var presenter: AnyPresenter?
    
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/8") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let data = data, error == nil else {
                self.presenter?.interactorDidFinished(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                self.presenter?.interactorDidFinished(with: .success(users))
            } catch let error {
                self.presenter?.interactorDidFinished(with: .failure(error))
            }

        }
        task.resume()
    }
}
