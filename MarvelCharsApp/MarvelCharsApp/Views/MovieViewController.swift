//
//  MovieViewController.swift
//  MarvelCharsApp
//
//  Created by User on 12/13/21.
//

import UIKit
import WebKit

class MovieViewController: UIViewController {
    var movieKey: String?
    let movieViewModel = MoviesViewModel()
    var webPlayer: WKWebView!
    let webConfiguration = WKWebViewConfiguration()

    @IBOutlet var trailerLabel: UILabel!
    @IBOutlet var synopsisLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var videoView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        contentView.backgroundColor = .black
        configureNavBar()

        if let key = movieKey {
            movieViewModel.getMovie(byKey: key)
            movieViewModel.refreshData = loadMovieInfo
        }

        webConfiguration.allowsInlineMediaPlayback = true
        webPlayer = WKWebView(frame: self.videoView.bounds, configuration: self.webConfiguration)
        webPlayer.backgroundColor = .primaryBlack
        webPlayer.isOpaque = false
        webPlayer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        videoView.addSubview(self.webPlayer)

        let gradientView = GradientView(frame: mainImage.frame)
        mainImage.addSubview(gradientView)
        mainImage.bringSubviewToFront(gradientView)
        gradientView.translatesAutoresizingMaskIntoConstraints = true
        gradientView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,
                                         UIView.AutoresizingMask.flexibleLeftMargin,
                                         UIView.AutoresizingMask.flexibleRightMargin,
                                         UIView.AutoresizingMask.flexibleTopMargin,
                                         UIView.AutoresizingMask.flexibleBottomMargin]
    }

    private func loadMovieInfo(movie: MovieModel) {
        DispatchQueue.main.async { [weak self] in
            if let url = URL(string: movie.image) {
              self?.mainImage.loadImage(at: url) {}
            } else {
              self?.mainImage.image = UIImage(systemName: "placeholdertext.fill")
            }
            self?.titleLabel.text = movie.name
            self?.synopsisLabel.text = movie.synopsis
            self?.titleLabel.isHidden = false
            self?.synopsisLabel.isHidden = false
            self?.trailerLabel.isHidden = false
        }
        playVideo(url: movie.trailer)
    }

    func configureNavBar() {
        let action = UIAction { _ in
            self.navigationController?.popViewController(animated: true)
        }
        let button = UIBarButtonItem(title: "", image: UIImage(named: "back"), primaryAction: action, menu: nil)
        button.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = button
    }

    func playVideo(url: String) {
        DispatchQueue.main.async {
            guard let videoURL = URL(string: "\(url)?playsinline=1") else { return }
            let request = URLRequest(url: videoURL)
            self.webPlayer.load(request)
        }
    }
}
