//
//  LikedViewController.swift
//  WelcomeBackChuckApp
//
//  Created by Denis Velikanov on 14.12.2020.
//

import UIKit
import CoreData

class LikedViewController: UIViewController {
    
    let label = UILabel()
    let tableView = UITableView()
    var imageForPass = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(clearCoreData))
        updateTableView()
        register()
        setup()
        constraint()
        fetchImage()
    }

}

