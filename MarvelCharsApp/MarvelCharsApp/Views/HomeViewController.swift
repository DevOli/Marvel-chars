//
//  ViewController.swift
//  MarvelCharsApp
//
//  Created by admin on 11/23/21.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {
    
    var menu: SideMenuNavigationController?
    // Quick Example to see if it works. Not final
    let marvelLogo = UIImageView(image: UIImage(named: "marvel")?.tintedWithLinearGradientColors(colorsArr: [UIColor(named: "gradient-red-b")!.cgColor, UIColor(named: "gradient-red-a")!.cgColor]))
    //let manager = MarvelAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        menu = SideMenuNavigationController(rootViewController: SideMenuController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: true)
        
        navigationItem.titleView = marvelLogo
        
        //self.manager.delegate = self
        //self.manager.fetchData()
    }
    
    @IBAction func didTapMenu() {
        present(menu!, animated: true)
    }
}

/*
extension HomeViewController: MarvelAPIDelegate {
    func didFetchData(categories: [CategoryModel]) {
        //print (categories)
    }
}
*/
