//
//  NetworkService.swift
//  GradientApp
//
//  Created by Denis Velikanov on 16.02.2021.
//

import Foundation

protocol Networking {
    func mutableRequest(completion: @escaping (Data?, Error?) -> Void)
    func translateRequest(quote: String, completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: Networking {
    
    func mutableRequest(completion: @escaping (Data?, Error?) -> Void) {
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
        
        let task = createMutableDataTask(from: request, completion: completion)
        task.resume()
    }
    
    func translateRequest(quote: String, completion: @escaping (Data?, Error?) -> Void) {
        
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
        
        let task = createMutableDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createMutableDataTask(from request: NSMutableURLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
