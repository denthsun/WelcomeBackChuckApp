//
//  Model.swift
//  WelcomeBackChuckApp
//
//  Created by Denis Velikanov on 13.12.2020.
//

import Foundation


struct NorrisJoke: Decodable {
    var icon_url: String
    var id: String
    var url: String
    var value: String
}

var currentChuckJoke: NorrisJoke?

var likedJokes: [NorrisJoke] = []

var chuckJokes: [JokeModel] = []

let notificationType = "ChuckIsBack"


struct Translated: Decodable {
    var status: Int
    var from: String
    var to: String
    var original_text: String
    var translated_text: [String : String]
    var translated_characters: Int
    

}


var translated: Translated?
