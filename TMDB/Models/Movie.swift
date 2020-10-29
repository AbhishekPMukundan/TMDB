//
//  Movies.swift
//  TMDB
//
//  Created by Abhishek on 29/10/20.
//

import Foundation

struct MovieList: Decodable {
    let results: [Movie]
    let page: Int
    let total_results: Int
    let total_pages: Int
}

struct Movie: Decodable {
    let poster_path: String
    let title: String
    let vote_average: Double
    let release_date: String
}
