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
    var position: CGPoint = CGPoint(x: HomeViewModel.lastScrolledPosition + (UIScreen.main.bounds.size.width / 2), y: UIScreen.main.bounds.size.height / 2.5)
    var size: CGSize
    var scale: CGFloat = 1.0
    var lastScale = 1.0
}
