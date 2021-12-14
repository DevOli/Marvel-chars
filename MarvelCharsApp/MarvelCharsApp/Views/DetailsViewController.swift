//
//  DetailsViewController.swift
//  MarvelCharsApp
//
//  Created by admin on 11/23/21.
//

import UIKit
import SwiftUI

class DetailsViewController: UIViewController {
  
    @IBOutlet weak var basicInfoView: UIView!
    @IBOutlet weak var abilitiesView: UIView!    
    @IBOutlet weak var stackView: UIStackView!
    
    var character: CharacterModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureNavBar()
        
        if let safeCharacter = character {
            let contentView2 = BasicInfoView(character: safeCharacter)
            let childView2 = UIHostingController(rootView: contentView2)
            addChild(childView2)
            childView2.view.frame = basicInfoView.bounds
            basicInfoView.addSubview(childView2.view)
            basicInfoView.addConstrained(subview: childView2.view)
            childView2.didMove(toParent: self)
            
            let contentView = AbilitiesView(character: safeCharacter)
            let childView = UIHostingController(rootView: contentView)
            addChild(childView)
            childView.view.frame = abilitiesView.bounds
            abilitiesView.addSubview(childView.view)
            abilitiesView.addConstrained(subview: childView.view)
            childView.didMove(toParent: self)
        }
        
        let movieCustomView = MovieSectionView(character: character, frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        movieCustomView.delegate = self
        
        stackView.addArrangedSubview(movieCustomView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func configureNavBar() {
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isTranslucent = true
        let action = UIAction { UIAction in
            self.navigationController?.navigationBar.barStyle = .default
            self.navigationController?.popViewController(animated: true)
        }
        let button = UIBarButtonItem(title: "", image: UIImage(named: "back"), primaryAction: action, menu: nil)
        button.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = button
    }
}

extension DetailsViewController: MoviePortraitDelegate {
    func onTappedMovie(movieName: String) {
        let vc = MovieViewController(nibName: ResourceName.movieViewControllerNibName, bundle: nil)
        vc.movieKey = movieName
        self.navigationController?.pushViewController(vc, animated: true)
    }
        
}
