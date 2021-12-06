//
//  MovieSectionView.swift
//  MarvelCharsApp
//
//  Created by User on 12/6/21.
//

import UIKit

protocol MoviePortraitDelegate {
  func onTappedMovie(movieName: String)
}

class MovieSectionView: UIView {
    
    let nibName = "MovieSectionView"
    var character: CharacterModel?
    var delegate: MoviePortraitDelegate?
    
    private let collectionViewCellNibName = "CharacterPortraitCell"
    private let cellReuseIdentifier = "CharacterPortraitID"
    
    @IBOutlet weak var moviesCollection: UICollectionView!
    
    func configure(character: CharacterModel) {
        self.character = character
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
        //Load view
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        //Collection
        moviesCollection.register(UINib(nibName: self.collectionViewCellNibName, bundle: nil), forCellWithReuseIdentifier: self.cellReuseIdentifier)
        moviesCollection.dataSource = self
        moviesCollection.delegate = self
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

extension MovieSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.character?.movies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = moviesCollection.dequeueReusableCell(withReuseIdentifier: self.cellReuseIdentifier, for: indexPath) as? CharacterPortraitCell else {
            return UICollectionViewCell()
        }
        
        guard let movie = self.character?.movies[indexPath.row] else { return UICollectionViewCell() }
        let image = UIImage(named: movie)
        cell.characterImage.image = image?.roundedImage
//        cell.characterNameLabel.text = character.name
//        cell.characterAlterEgoLabel.text = character.alterEgo
        return cell
    }
    
}

extension MovieSectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = self.character?.movies[indexPath.row] {
            self.delegate?.onTappedMovie(movieName: movie)
        }
    }
}
