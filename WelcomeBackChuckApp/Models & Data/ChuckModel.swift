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
