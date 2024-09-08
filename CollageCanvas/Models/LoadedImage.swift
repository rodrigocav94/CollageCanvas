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
    var position: CGPoint = CGPoint(x: 100, y: 100)
    var scale: CGFloat = 0.3
    var lastScale = 1.0
}
