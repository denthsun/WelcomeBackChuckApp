//
//  Requeest.swift
//  WelcomeBackChuckApp
//
//  Created by Denis Velikanov on 13.12.2020.
//

import Foundation
import CoreData
import UIKit

extension ViewController {
    
    func jokeRequest() {
        
        dispatchGroup.enter()
        print("ENTER")
        
        let headers = [
            "accept": "application/json",
            "x-rapidapi-key": "4ff24a2fdcmshf37b8f91dcb973ep1b89fajsn1be9d534c581",
            "x-rapidapi-host": "matchilling-chuck-norris-jokes-v1.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://matchilling-chuck-norris-jokes-v1.p.rapidapi.com/jokes/random")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { [weak self] (data, response, error) -> Void in
            if data != nil {
                
                let decoder = JSONDecoder()
                do {
                    let newJoke: NorrisJoke = try decoder.decode(NorrisJoke.self, from: data!)
                    
                    currentChuckJoke = newJoke
                    print("\(newJoke.value)")
            
                    self?.dispatchGroup.leave()
                    print("LEAVE")
                } catch {
                    print("Error: \(error)")
                }
            }
            
        }
        dataTask.resume()
    }
}
