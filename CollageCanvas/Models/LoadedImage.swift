//
//  LoadedImage.swift
//  CollageCanvas
//
//  Created by Rodrigo Cavalcanti on 08/09/24.
//

import SwiftUI

struct LoadedImage: Identifiable {
    var id: Int
    var image: Image
    var position: CGPoint = CGPoint(x: HomeViewModel.lastScrolledPosition + (UIScreen.main.bounds.size.width / 2), y: 150)
    var size: CGSize
    var scale: CGFloat = 1.0
    var lastScale = 1.0
}

extension LoadedImage {
    var frameHeight: CGFloat {
        size.height * scale
    }
    
    var frameWidth: CGFloat {
        size.width * scale
    }
}
