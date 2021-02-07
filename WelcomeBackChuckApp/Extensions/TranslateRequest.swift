//
//  TranslateRequest.swift
//  WelcomeBackChuckApp
//
//  Created by Denis Velikanov on 07.02.2021.
//

import Foundation

extension ViewController {
    
    
    func translateRequest() {
        
        translateDispatchGroup.enter()

let headers = [
    "content-type": "application/x-www-form-urlencoded",
    "x-rapidapi-key": "4ff24a2fdcmshf37b8f91dcb973ep1b89fajsn1be9d534c581",
    "x-rapidapi-host": "nlp-translation.p.rapidapi.com"
]

let postData = NSMutableData(data: "text=\(quote)".data(using: String.Encoding.utf8)!)
postData.append("&to=ru".data(using: String.Encoding.utf8)!)
postData.append("&from=en".data(using: String.Encoding.utf8)!)

let request = NSMutableURLRequest(url: NSURL(string: "https://nlp-translation.p.rapidapi.com/v1/translate")! as URL,
                                        cachePolicy: .useProtocolCachePolicy,
                                    timeoutInterval: 10.0)
request.httpMethod = "POST"
request.allHTTPHeaderFields = headers
request.httpBody = postData as Data

let session = URLSession.shared
let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { [weak self] (data, response, error) -> Void in
    
    
    if data != nil {
        
        let decoder = JSONDecoder()
        do {
            let translatedText: Translated = try decoder.decode(Translated.self, from: data!)
            
            translated = translatedText
            self?.translateDispatchGroup.leave()
            
        } catch {
            print("Error: \(error)")
        }
        
    }
    
    
    
})

dataTask.resume()

    
    
    }
    
}
