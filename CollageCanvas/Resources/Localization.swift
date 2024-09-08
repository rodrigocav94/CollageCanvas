//
//  Localization.swift
//  CollageCanvas
//
//  Created by Rodrigo Cavalcanti on 08/09/24.
//

import Foundation

enum Localization {
    enum CuratedPhotos: String {
        case overlays
        
        var localized: String {
            self.rawValue.localized
        }
    }
}
