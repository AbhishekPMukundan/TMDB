//
//  MoviesViewModel.swift
//  TMDB
//
//  Created by Abhishek on 29/10/20.
//

import Foundation
protocol MovieListViewModelDelegate: class {
    func fetchMovieSuccessfull()
    func fetchMovieFailure(_ error: String)
}

//Parent View Model
class MovieListViewModel {
    
    private weak var delegate: MovieListViewModelDelegate?
    
    var movies: [Movie] = []
    
    private var isFetchInProgress = false
    private var currentPage = 1
    private var total = 0
    
    var currentCount: Int {
        return movies.count
    }
    
    var totalCount: Int {
        return total
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    init(_ delegate: MovieListViewModelDelegate) {
        self.delegate = delegate
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.totalCount
    }
    
    func movieAtIndex(_ index: Int) -> MovieViewModel {
        let movie = self.movies[index]
        return MovieViewModel(movie)
    }
    
    func fetchPopularMovies() {
        //Early exit if fetch is in progress
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        WebService().fetchPopularMovies(page: currentPage) { [weak self] result in
            switch result {
            case .failure(let error) :
                DispatchQueue.main.async {
                    self?.isFetchInProgress = false
                    self?.delegate?.fetchMovieFailure(error.localizedDescription)
                }
            case .success(let movieList):
                self?.currentPage += 1
                self?.isFetchInProgress = false
                self?.total = movieList.total_results
                
                //append View Model with the movies
                self?.movies.append(contentsOf: movieList.results)
                
                // trigger the delegate function
                self?.delegate?.fetchMovieSuccessfull()
            }
        }
    }
    
    // check if the current index is greater then the currentCount
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= self.currentCount
    }
}

//Child View Model
struct MovieViewModel {
    private let movie: Movie
}

extension MovieViewModel {
    // Creating new constructor
    init(_ movie: Movie) {
        self.movie = movie
    }
}

extension MovieViewModel {
    var posterImage: String {
        let path = "https://image.tmdb.org/t/p/w128_and_h128_face"
        return path + self.movie.poster_path
    }
    
    var movieTitle: String {
        return self.movie.title
    }
    
    var votingAverage: Double {
        return self.movie.vote_average
    }
    
    var releaseDate: String {
        return self.movie.release_date
    }
}
