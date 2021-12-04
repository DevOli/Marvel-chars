//
//  UIFontHelper.swift
//  MarvelCharsApp
//
//  Created by User on 4/12/21.
//

import Foundation
import UIKit

extension UIFont {

    static func profileTitle() -> UIFont {
        let font = UIFont(name: "gilroy-heavy", size: 40)
        return font ?? UIFont.systemFont(ofSize: 16)
    }
    
    static func homeTitle() -> UIFont {
        let font = UIFont(name: "gilroy-heavy", size: 32)
        return font ?? UIFont.systemFont(ofSize: 16)
    }
    
    static func cardTitle() -> UIFont {
        let font = UIFont(name: "gilroy-heavy", size: 20)
        return font ?? UIFont.systemFont(ofSize: 16)
    }
    
    static func sectionTitle() -> UIFont {
        let font = UIFont(name: "gilroy-bold", size: 18)
        return font ?? UIFont.systemFont(ofSize: 16)
    }
    
    static func profileSubtitle() -> UIFont {
        let font = UIFont(name: "gilroy-medium", size: 16)
        return font ?? UIFont.systemFont(ofSize: 16)
    }
    
    static func homeSubtitle() -> UIFont {
        let font = UIFont(name: "gilroy-semibold", size: 14)
        return font ?? UIFont.systemFont(ofSize: 16)
    }
    
    static func description() -> UIFont {
        let font = UIFont(name: "gilroy-medium", size: 14)
        return font ?? UIFont.systemFont(ofSize: 16)
    }
    
    static func characteristics() -> UIFont {
        let font = UIFont(name: "gilroy-medium", size: 12)
        return font ?? UIFont.systemFont(ofSize: 16)
    }
    
    static func ability() -> UIFont {
        let font = UIFont(name: "gilroy-regular", size: 12)
        return font ?? UIFont.systemFont(ofSize: 16)
    }
    
    static func cardSubtitle() -> UIFont {
        let font = UIFont(name: "gilroy-medium", size: 10)
        return font ?? UIFont.systemFont(ofSize: 16)
    }
}
