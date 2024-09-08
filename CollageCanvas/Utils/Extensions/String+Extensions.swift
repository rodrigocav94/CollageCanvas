//
//  String+Extensions.swift
//  CollageCanvas
//
//  Created by Rodrigo Cavalcanti on 08/09/24.
//

import Foundation

extension String {
    // Return the string from Localizable.strings
    var localized: String {
        let langCode = Locale.current.language.languageCode?.identifier
        
        guard let path = Bundle.main.path(forResource: langCode, ofType: "lproj"), let bundle = Bundle(path: path) else {
            // Fallback to English
            guard let basePath = Bundle.main.path(forResource: "en", ofType: "lproj"),
                  let localizedEnglishString = Bundle(path: basePath)?.localizedString(forKey: self, value: "", table: nil) else {
                return self
            }
            return localizedEnglishString
        }
        return  bundle.localizedString(forKey: self, value: "", table: nil)
    }
}
