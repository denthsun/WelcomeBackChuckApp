//
//  VCExtension.swift
//  WelcomeBackChuckApp
//
//  Created by Denis Velikanov on 13.12.2020.
//

import UIKit
import CoreData

extension ViewController {
    @objc func getData() {
        jokeRequest()
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseIn) { [weak self] in
            self?.label.center.y = (self?.label.center.y)! + 700
            self?.likeButton.center.y = (self?.likeButton.center.y)! + 700
            self?.label.textColor = .systemGray6
            self?.label.text = "wait for it"
            self?.view.backgroundColor = .orange
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.moveBack()
        }
    }
    
    func moveBack() {
        UIView.animate(withDuration: 0.6, delay: 0.3, options: .curveEaseIn) { [weak self] in
            self?.label.center.y = (self?.label.center.y)! - 700
            self?.likeButton.center.y = (self?.likeButton.center.y)! - 700
            self?.stackView.backgroundColor = .black
            self?.view.backgroundColor = .black
            self?.likeButton.setImage(UIImage(named: "emptyHeart"), for: .normal)
            self?.image.image = UIImage(named: "chuck")
            self?.label.text = "\(currentChuckJoke?.value ?? "Downloading...")"
        }
    }
    
    @objc func likeTapped() {
        likeButton.setImage(UIImage(named: "fullHeart"), for: .normal)
        saveLiked()
        self.notifications.scheduleNotification(notificationType: notificationType)
    }
    
    func saveLiked() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "JokeModel", in: managedContext)
        
        let newChuckJoke = JokeModel(entity: entity!, insertInto: managedContext)
        newChuckJoke.value = currentChuckJoke!.value
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

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
}
