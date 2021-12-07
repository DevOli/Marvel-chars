//
//  DetailsViewController.swift
//  MarvelCharsApp
//
//  Created by admin on 11/23/21.
//

import UIKit
import SwiftUI

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var abilitiesView: UIView!
    @IBOutlet var generalView: UIView!
    
    var character: CharacterModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        
        let contentView = GeneralView(character: character!)
        let childView = UIHostingController(rootView: contentView)
        addChild(childView)
        childView.view.frame = generalView.bounds
        generalView.addSubview(childView.view)
        generalView.addConstrained(subview: childView.view)
        childView.didMove(toParent: self)
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
