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
    
    let dispatchGroup = DispatchGroup()
    let label = UILabel()
    let button = UIButton()
    var image = UIImageView()
    let stackView = UIStackView()
    let likeButton = UIButton()
    var iconImage = UIImage()
    let notifications = Notifications()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        constraint()
        title = "Chuck Jokes"
        view.backgroundColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Liked", style: .plain, target: self, action: #selector(leftBarButtonTapped))
    }
    
    @objc func leftBarButtonTapped() {
        let vc = LikedViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
      
    func setup() {
        [stackView].forEach { view.addSubview($0) }
        [image, label, likeButton, button].forEach { stackView.addSubview($0) }
        
        label.textColor = .systemRed
        label.font = UIFont(name: "Palatino-Bold", size: 30)
        label.backgroundColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.enableCornerRadius(radius: 10)
        label.text = "Hi, tap Get Joke and find new Chuck Norris)"
        label.textAlignment = .center
        label.numberOfLines = 0
        
        button.setTitle("Get Joke", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemOrange
        button.addTarget(self, action: #selector(getData), for: .touchUpInside)
        button.enableCornerRadius(radius: 10)
        
        likeButton.setImage(UIImage(named: "emptyHeart"), for: .normal)
        likeButton.enableCornerRadius(radius: 10)
        likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        likeButton.alpha = 0.5
        likeButton.backgroundColor = .white
        
        image.image = UIImage(named: "chuck")
        image.contentMode = .scaleAspectFill
        
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 50
        stackView.backgroundColor = .black
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.enableCornerRadius(radius: 20)
    }
    
    func constraint() {
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 30, right: 30))
        
        image.anchor(top: stackView.topAnchor, leading: stackView.leadingAnchor, bottom: nil, trailing: stackView.trailingAnchor)
        image.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        label.anchor(top: image.bottomAnchor, leading: stackView.leadingAnchor, bottom: button.topAnchor, trailing: stackView.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 20, right: 20))
        
        likeButton.anchor(top: nil, leading: nil, bottom: label.bottomAnchor, trailing: stackView.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 20, right: 20))
        likeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        likeButton.heightAnchor.constraint(equalTo: likeButton.widthAnchor).isActive = true
        button.anchor(top: label.bottomAnchor, leading: stackView.leadingAnchor, bottom: stackView.bottomAnchor, trailing: stackView.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 20, right: 20))
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
