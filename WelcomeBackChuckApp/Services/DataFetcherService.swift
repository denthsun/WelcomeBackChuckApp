//
//  DataFetcherService.swift
//  GradientNewApp
//
//  Created by Denis Velikanov on 17.02.2021.
//

import Foundation

class DataFetcherService {
    
    var networkDataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = dataFetcher
    }
    
    func fetchChuckJoke(completion: @escaping (NorrisJoke?) -> Void) {
        dispatchGroup.enter()
        networkDataFetcher.fetchMutableGenericData(response: completion)
    }
    
    func fetchTranslate(quote: String, completion: @escaping (Translated?) -> Void) {
        translateDispatchGroup.enter()
        networkDataFetcher.fetchQuoteData(quote: quote, response: completion)
    }
}

