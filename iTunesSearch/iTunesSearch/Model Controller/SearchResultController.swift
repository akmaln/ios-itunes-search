//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Akmal Nurmatov on 5/4/20.
//  Copyright © 2020 Akmal Nurmatov. All rights reserved.
//

import Foundation

class SearchResultController {
    
    var searchResults: SearchResults = SearchResults(results: [])
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: "https://itunes.apple.com/search?") else { return }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let parameters : [String : String] = ["term" : searchTerm, "entity" : resultType.rawValue]
        let queryItems = parameters.compactMap({URLQueryItem(name: $0.key, value: $0.value)})
        urlComponents?.queryItems = queryItems
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("no data returned from data task.")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults
                completion(nil) 
                
            } catch {
                print("Error decoding: \(error)")
                completion(error)
                return
            }
            
        }
        task.resume()
    }
}
