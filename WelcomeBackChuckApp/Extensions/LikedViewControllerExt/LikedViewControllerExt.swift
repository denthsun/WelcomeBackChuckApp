//
//  LikedViewControllerEXT.swift
//  WelcomeBackChuckApp
//
//  Created by Denis Velikanov on 24.02.2021.
//

import Foundation
import UIKit
import CoreData

extension LikedViewController {
    
    func removeCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "JokeModel")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
            
        } catch let error as NSError {
            
            print(error.localizedDescription)
        }
        tableView.reloadData()
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

