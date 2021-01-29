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
    
    @objc func clearCoreData() {
        
        removeCoreData()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<JokeModel>(entityName: "JokeModel")

        do {
            chuckJokes = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        tableView.reloadData()
    }
    
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
    
    func fetchImage() {
        guard let urlString = URL(string: "\(currentChuckJoke?.icon_url ?? "")") else { return }
        let dataImageTask = URLSession.shared.dataTask(with: urlString) { (data, _, err) in
            guard let data = data, err == nil else { return }
            let image: UIImage = {
                let image = UIImage(data: data)
                return image!
            }()
            self.imageForPass = image
        }
        dataImageTask.resume()
    }
    
    func updateTableView() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<JokeModel>(entityName: "JokeModel")
        
        do {
            chuckJokes = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        tableView.reloadData()
    }
}

extension LikedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chuckJokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.setLabel(textLabel: chuckJokes[indexPath.row].value ?? "")
        cell.setImage(settedImage: imageForPass)
        return cell
    }
}
