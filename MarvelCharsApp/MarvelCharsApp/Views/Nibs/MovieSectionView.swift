//
//  MovieSectionView.swift
//  MarvelCharsApp
//
//  Created by User on 12/6/21.
//

import UIKit

protocol MoviePortraitDelegate: AnyObject {
  func onTappedMovie(movieName: String)
}

class MovieSectionView: UIView {
    @IBOutlet var moviesCollection: UICollectionView!

    let nibName = ResourceName.moviesSectionNibName
    var character: CharacterModel?
    weak var delegate: MoviePortraitDelegate?

    private let collectionViewCellNibName = ResourceName.characterCollectionViewCellNibName
    private let cellReuseIdentifier = ResourceName.characterCellReuseIdentifier

    required init(character: CharacterModel?, frame: CGRect) {
        self.character = character
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    func commonInit() {
        if let viewXib = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView {
            viewXib.frame = self.bounds
            addSubview(viewXib)
            moviesCollection.register(UINib(nibName: self.collectionViewCellNibName, bundle: nil),
                                            forCellWithReuseIdentifier: self.cellReuseIdentifier)
            moviesCollection.dataSource = self
            moviesCollection.delegate = self
        }
    }

    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? MovieSectionView
    }
}

extension MovieSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.character?.movies.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = moviesCollection.dequeueReusableCell(withReuseIdentifier: self.cellReuseIdentifier,
                                                              for: indexPath) as? CharacterPortraitCell else {
            return UICollectionViewCell()
        }
        if let movie = self.character?.movies[indexPath.row] {
          cell.characterNameLabel.text = ""
          cell.characterAlterEgoLabel.text = ""
          guard let url = URL(string: movie) else {
            cell.characterImage.image = UIImage(systemName: "placeholdertext.fill")
            return cell
          }
          cell.characterImage.loadImage(at: url) {
            cell.characterImage.image = cell.characterImage.image?.roundedImage
          }
        }
        return cell
    }
}

extension MovieSectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieKey = self.character?.getMovieKeyFromURL(at: indexPath.row) {
            self.delegate?.onTappedMovie(movieName: movieKey)
        }
    }
}
