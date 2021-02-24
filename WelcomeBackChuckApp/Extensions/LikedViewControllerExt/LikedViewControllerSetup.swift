//
//  LikedViewControllerSetup.swift
//  WelcomeBackChuckApp
//
//  Created by Denis Velikanov on 25.02.2021.
//

import Foundation
import UIKit
import CoreData

extension LikedViewController {

    func setup() {
        [label, tableView].forEach { view.addSubview($0) }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.enableCornerRadius(radius: 15)
        tableView.backgroundColor = .systemIndigo
        
        label.text = "You liked: "
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.textAlignment = .center
    }
    
    func constraint() {
        label.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: tableView.topAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 30, left: 10, bottom: 30, right: 10))
        tableView.anchor(top: label.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    func register() {
        tableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
    }
}
