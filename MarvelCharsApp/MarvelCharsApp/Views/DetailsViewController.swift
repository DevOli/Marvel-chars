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
        
        let yourBackImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationController?.navigationBar.backItem?.title = ""
        
        let contentView = GeneralView(character: character!)
        let childView = UIHostingController(rootView: contentView)
        addChild(childView)
        childView.view.frame = generalView.bounds
        generalView.addSubview(childView.view)
        generalView.addConstrained(subview: childView.view)
        childView.didMove(toParent: self)
        
        /*
        let contentView = AbilitiesView(character: character!)
        let childView = UIHostingController(rootView: contentView)
        addChild(childView)
        childView.view.frame = abilitiesView.bounds
        abilitiesView.addSubview(childView.view)
        abilitiesView.addConstrained(subview: childView.view)
        childView.didMove(toParent: self)
        */
    }
}

