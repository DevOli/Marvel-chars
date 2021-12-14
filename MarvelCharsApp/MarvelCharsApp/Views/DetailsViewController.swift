//
//  DetailsViewController.swift
//  MarvelCharsApp
//
//  Created by admin on 11/23/21.
//

import SwiftUI
import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet var abilitiesView: UIView!
    @IBOutlet var stackView: UIStackView!
    var character: CharacterModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Make the top and bottom bar black
        view.backgroundColor = .black

        if let safeCharacter = character {
            let contentView = AbilitiesView(character: safeCharacter)
            let childView = UIHostingController(rootView: contentView)
            addChild(childView)
            childView.view.frame = abilitiesView.bounds
            abilitiesView.addSubview(childView.view)
            abilitiesView.addConstrained(subview: childView.view)
            childView.didMove(toParent: self)
        }

        let movieCustomView = MovieSectionView(character: character, frame: CGRect(x: 0, y: 0, width: 0, height: 0))

        stackView.addArrangedSubview(movieCustomView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }

    // Set the status bar to black style with white icons
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.barStyle = .black
    }
}
