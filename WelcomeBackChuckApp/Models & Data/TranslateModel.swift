//
//  TranslateModel.swift
//  WelcomeBackChuckApp
//
//  Created by Denis Velikanov on 24.02.2021.
//

import Foundation

struct Translated: Decodable {
    var status: Int
    var from: String
    var to: String
    var original_text: String
    var translated_text: [String : String]
    var translated_characters: Int
}
