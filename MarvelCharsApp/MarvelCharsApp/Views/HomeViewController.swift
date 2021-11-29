//
//  ViewController.swift
//  MarvelCharsApp
//
//  Created by admin on 11/23/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    // Quick Example to see if it works. Not final
    let manager = MarvelAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.manager.delegate = self
        self.manager.fetchData()
    }
}

extension HomeViewController: MarvelAPIDelegate {
    func didFetchData(categories: [CategoryModel]) {
        print (categories)
    }
}

