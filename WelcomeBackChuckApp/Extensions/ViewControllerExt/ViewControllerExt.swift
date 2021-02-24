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
        dataFetcherService.fetchChuckJoke { (newJoke) in
            currentChuckJoke = newJoke
            dispatchGroup.leave()
            print("Joke is here")
        }
        
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseIn) { [weak self] in
            self?.label.center.y = (self?.label.center.y)! + 700
            self?.likeButton.center.y = (self?.likeButton.center.y)! + 700
            self?.label.textColor = .black
            self?.label.text = "wait for it"
            self?.view.backgroundColor = .orange
        }
        dispatchGroup.notify(queue: .main) {
            self.moveBack()
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
    
    func setTranslatedText() {
        let text = translated?.translated_text
        self.view.backgroundColor = .systemGray2
        self.label.text = text?["ru"]
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
    
    @objc func rightButtonFunc() {
        dataFetcherService.fetchTranslate(quote: currentChuckJoke?.value ?? "fly me to the moon") { (translatedJoke) in
            translated = translatedJoke
            print("Translated is here")
            translateDispatchGroup.leave()
        }
        
        translateDispatchGroup.notify(queue: .main) {
            self.setTranslatedText()
        }
    }
    
    @objc func leftBarButtonTapped() {
        let vc = LikedViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

