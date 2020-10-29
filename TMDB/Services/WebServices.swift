//
//  WebServices.swift
//  TMDB
//
//  Created by Abhishek on 29/10/20.
//

import Foundation

class WebService {
    
    private lazy var baseURL: URLComponents = {
        return URLComponents(string: Constants.baseUrl)!
    }()
    
    func fetchPopularMovies(page: Int, completions: @escaping (Result<MovieList, Error>) -> ()) {
        
        baseURL.queryItems = [URLQueryItem(name: "api_key", value: Constants.apiKey),
                              URLQueryItem(name: "page", value: "\(page)")]
        
        let finalURL = baseURL.url!
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completions(Result.failure(error))
            } else if let data = data {
                let movieList = try? JSONDecoder().decode(MovieList.self, from: data)
                if let movieList = movieList {
                    completions(Result.success(movieList))
                }
            }
        }.resume()
    }
}
