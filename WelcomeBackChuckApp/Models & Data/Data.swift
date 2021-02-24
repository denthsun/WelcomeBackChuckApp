//
//  Data.swift
//  WelcomeBackChuckApp
//
//  Created by Denis Velikanov on 24.02.2021.
//

import Foundation

var currentChuckJoke: NorrisJoke?

var likedJokes: [NorrisJoke] = []

var chuckJokes: [JokeModel] = []

let notificationType = "ChuckIsBack"

var translated: Translated?

let dispatchGroup = DispatchGroup()
let translateDispatchGroup = DispatchGroup()

