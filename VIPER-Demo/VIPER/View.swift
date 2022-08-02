//
//  View.swift
//  VIPER-Demo
//
//  Created by Ahmed on 01/08/2022.
//

import Foundation
import UIKit

protocol AnyView {
    var presenter: AnyPresenter? { get  set }
    
    func update(with users: [User])
    func update(with error: String)
}

class UserViewController: UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource {
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "userCell")
        tableView.isHidden = true
        return tableView
    }()
    
    private let errorLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.isHidden = true
        return lbl
    }()
    
    var presenter: AnyPresenter?
    
    var users: [User] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(tableView)
        view.addSubview(errorLbl)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        errorLbl.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        errorLbl.center = view.center
    }
    
    func update(with users: [User]) {
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        print(error)
        DispatchQueue.main.async {
            self.errorLbl.text = error
            self.errorLbl.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        cell.textLabel?.textColor = .white
        cell.backgroundColor = indexPath.row.quotientAndRemainder(dividingBy: 2).remainder == 0 ? .systemBlue : .systemRed
        return cell
    }
    
}
