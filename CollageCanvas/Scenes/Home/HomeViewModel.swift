//
//  HomeViewModel.swift
//  CollageCanvas
//
//  Created by Rodrigo Cavalcanti on 08/09/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var displayingSheet = false
    @Published var insertedImages = [LoadedImage]()
    
    @Published var canvasSize = CGSize(width: 1200, height: 300)
    
    func onMagnificationGestureChanged(val: CGFloat, draggableImage: inout LoadedImage) {
        let delta = val / draggableImage.lastScale
        draggableImage.lastScale = val
        let newScale = draggableImage.scale * delta
        draggableImage.scale = newScale
    }
    
    func onMagnificationGestureEnded(draggableImage: inout LoadedImage) {
        draggableImage.lastScale = 1.0
    }
}
