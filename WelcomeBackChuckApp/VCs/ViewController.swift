//
//  ViewController.swift
//  WelcomeBackChuckApp
//
//  Created by Denis Velikanov on 12.12.2020.
//

import UIKit
import CoreData
import UserNotifications

class ViewController: UIViewController {
    
    let label = UILabel()
    let button = UIButton()
    var image = UIImageView()
    let stackView = UIStackView()
    let likeButton = UIButton()
    var iconImage = UIImage()
    let notifications = Notifications()
    let dataFetcherService = DataFetcherService()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        constraint()
        title = "Chuck Jokes"
        view.backgroundColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Liked", style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "translate", style: .plain, target: self, action: #selector(rightButtonFunc))
    }
}
