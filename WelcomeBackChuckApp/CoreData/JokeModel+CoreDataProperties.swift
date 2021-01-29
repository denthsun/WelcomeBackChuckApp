//
//  JokeModel+CoreDataProperties.swift
//  WelcomeBackChuckApp
//
//  Created by Denis Velikanov on 16.12.2020.
//
//

import Foundation
import CoreData


extension JokeModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JokeModel> {
        return NSFetchRequest<JokeModel>(entityName: "JokeModel")
    }

    @NSManaged public var value: String?

}

extension JokeModel : Identifiable {

}
