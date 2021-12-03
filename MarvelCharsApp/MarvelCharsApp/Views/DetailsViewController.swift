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
    // Testing, not final
    var character: CharacterModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //print(character)
        let contentView = AbilitiesView(character: character!)
        let childView = UIHostingController(rootView: contentView)
        addChild(childView)
        childView.view.frame = abilitiesView.bounds
        abilitiesView.addSubview(childView.view)
        abilitiesView.addConstrained(subview: childView.view)
        childView.didMove(toParent: self)
    }

}

