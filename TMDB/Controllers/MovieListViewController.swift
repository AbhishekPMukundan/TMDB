//
//  MovieListViewController.swift
//  TMDB
//
//  Created by Abhishek on 29/10/20.
//

import UIKit
import SDWebImage

class MovieListViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet weak var movieListTableView: UITableView!
    private var movieListVM: MovieListViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //UI setup
        setupUI()
        
        //Initialise and Fetch data from the API
        movieListVM = MovieListViewModel(self)
        movieListVM.fetchPopularMovies()
    }
    
    //MARK: - Functions
    private func setupUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

//MARK: - UITableView DataSource
extension MovieListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.movieListVM.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieListVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as? MovieListTableViewCell else {
            fatalError("MovieListTableViewCell not found")
        }
        
        if !self.movieListVM.isLoadingCell(for: indexPath) {
            let movie = self.movieListVM.movieAtIndex(indexPath.row)
            
            cell.posterImageView.sd_setImage(with: URL(string: movie.posterImage)!, placeholderImage:nil)
            cell.movieTitleLabel.text = movie.movieTitle
            cell.releaseDateLabel.text = movie.releaseDate
            cell.votingAverageLabel.text = "\(movie.votingAverage)%"
            
            cell.favButton.tag = indexPath.row
            cell.favButton.addTarget(self, action: #selector(addTofav(sender:)), for: .touchUpInside)
        }
        
        return cell
    }
    
    @objc func addTofav(sender: UIButton) {
        sender.isSelected.toggle()
        // TODO this is incomplete
    }
}

//MARK: - UITableView DataSource Prefetching
extension MovieListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: self.movieListVM.isLoadingCell) {
            movieListVM.fetchPopularMovies()
        }
    }
}

//MARK: - MovieList ViewModel Delegate
extension MovieListViewController: MovieListViewModelDelegate {
    func fetchMovieFailure(_ error: String) {
        //TODO
        print(error)
    }
    
    func fetchMovieSuccessfull() {
        //Reload table view on main thread
        DispatchQueue.main.async {
            self.movieListTableView.reloadData()
        }
    }
}
