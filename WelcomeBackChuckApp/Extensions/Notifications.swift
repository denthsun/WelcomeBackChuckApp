//
//  Notifications.swift
//  WelcomeBackChuckApp
//
//  Created by Denis Velikanov on 16.12.2020.
//

import Foundation
import UserNotifications


class Notifications: NSObject, UNUserNotificationCenterDelegate {
        
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAutorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            print("Permission granted \(granted) ")
            guard granted else { return }
            self.getNotificationSettings()
        }
    }

    func getNotificationSettings() {
        notificationCenter.getNotificationSettings { (settings) in
            print("Notification settings \(settings)")
        }
    }
    
    func scheduleNotification(notificationType: String) {
        let content = UNMutableNotificationContent()
        let userAction = "User Action"
        
        content.title = notificationType
        content.body = "You liked: \(currentChuckJoke?.value ?? "hey ho lets go")" 
        content.sound = .default
        content.badge = 1
        content.categoryIdentifier = userAction
        guard let path = Bundle.main.path(forResource: "chuckNotification", ofType: "jpg") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            let attachment = try UNNotificationAttachment(identifier: "ChuckIsBack", url: url, options: nil)
            content.attachments = [attachment]
        } catch {
            print("Attachment cant be loaded")
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
        let identifier = "ChuckIsBack"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("error - \(error.localizedDescription)")
            }
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}
