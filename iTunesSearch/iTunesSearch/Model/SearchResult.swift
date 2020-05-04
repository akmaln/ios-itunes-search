//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Akmal Nurmatov on 5/4/20.
//  Copyright © 2020 Akmal Nurmatov. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
