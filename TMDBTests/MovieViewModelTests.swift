//
//  MovieViewModelTests.swift
//  TMDBTests
//
//  Created by Abhishek on 29/10/20.
//

import XCTest
@testable import TMDB

class MovieViewModelTests: XCTestCase, MovieListViewModelDelegate {
    func fetchMovieSuccessfull() {
        //TODO
    }
    
    func fetchMovieFailure(_ error: String) {
        //TODO
    }
    
    override class func setUp() {
        super.setUp()
        
    }
    
    func test_should_return_currentCount() {
        let vm = MovieListViewModel(self)
        
        let movie1 = Movie(poster_path: "/.jpg",
                          title: "Test Movie title",
                          vote_average: 100,
                          release_date: "10/10/2020")
        
        let movie2 = Movie(poster_path: "/.jpg",
                          title: "Test Movie title",
                          vote_average: 100,
                          release_date: "10/10/2020")
        
        let movie3 = Movie(poster_path: "/.jpg",
                          title: "Test Movie title",
                          vote_average: 100,
                          release_date: "10/10/2020")
        
        let movieList = MovieList(results: [movie1, movie2, movie3],
                                  page: 1,
                                  total_results: 3,
                                  total_pages: 100)
        XCTAssertEqual(vm.numberOfSections, 1)
    }
    
    func test_should_return_movieAtIndex() {
        let vm = MovieListViewModel(self)
        
        let movie1 = Movie(poster_path: "/.jpg",
                          title: "Test Movie title",
                          vote_average: 100,
                          release_date: "10/10/2020")
        
        let movie2 = Movie(poster_path: "/.jpg",
                          title: "Test Movie title",
                          vote_average: 100,
                          release_date: "10/10/2020")
        
        let movie3 = Movie(poster_path: "/.jpg",
                          title: "Test Movie title",
                          vote_average: 100,
                          release_date: "10/10/2020")
        
        let movieList = MovieList(results: [movie1, movie2, movie3],
                                  page: 1,
                                  total_results: 3,
                                  total_pages: 100)
        vm.movies = movieList.results
        let indexPath = IndexPath(row: 0, section: 0)
        
        let result = vm.isLoadingCell(for: indexPath)
        
        XCTAssertFalse(result, "Return true on lower index path")
    }
    
    override class func tearDown() {
        super.tearDown()
    }
}
