//
//  MovieViewController.swift
//  MarvelCharsApp
//
//  Created by User on 12/13/21.
//

import UIKit

class MovieViewController: UIViewController {

    var movieKey: String?
    let movieViewModel = MoviesViewModel()
    
    @IBOutlet weak var trailerLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var mainImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        contentView.backgroundColor = .black
        addGradientLayer()
        configureNavBar()
        
        if let key = movieKey {
            movieViewModel.getMovie(byKey: key)
            movieViewModel.refreshData = loadMovieInfo
        }

    }
    
    private func loadMovieInfo(movie: MovieModel) {
            DispatchQueue.main.async { [weak self] in
                self?.mainImage.image = UIImage(named: movie.image)
                self?.titleLabel.text = movie.name
                self?.synopsisLabel.text = movie.synopsis
                
                self?.titleLabel.isHidden = false
                self?.synopsisLabel.isHidden = false
                self?.trailerLabel.isHidden = false
            }
    }
    
    func configureNavBar() {
        let action = UIAction { UIAction in
            self.navigationController?.popViewController(animated: true)
        }
        let button = UIBarButtonItem(title: "", image: UIImage(named: "back"), primaryAction: action, menu: nil)
        button.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = button
    }
    
    func addGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.frame = mainImage.bounds
        let startColor = UIColor.clear.cgColor
        let endColor = UIColor.black.cgColor
        gradient.colors = [startColor, endColor]
        gradient.locations = [0, 0.7]
        mainImage.layer.insertSublayer(gradient, at: 0)
    }
}
