//
//  Localizator.swift
//  COMP2601A3-100999500
//
//  Created by Alexei Tipenko on 2017-03-11.
//  Copyright © 2017 Avery Vine. All rights reserved.
//

import Foundation

private class Localizator {
    
    static let sharedInstance = Localizator()
    
    lazy var localizableDictionary: NSDictionary! = {
        if let path = Bundle.main.path(forResource: "Localizable", ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        }
        fatalError("Localizable file NOT found")
    }()
    
    func localize(string: String) -> String {
        guard let localizedString = (localizableDictionary.value(forKey: string) as AnyObject).value(forKey:"value") else {
            assertionFailure("Missing translation for: \(string)")
            return ""
        }
        return localizedString  as! String    }
}

extension String {
    var localized: String {
        return Localizator.sharedInstance.localize(string: self)
    }
}
