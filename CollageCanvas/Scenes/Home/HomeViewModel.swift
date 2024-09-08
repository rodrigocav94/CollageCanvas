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
    @Published var lastCanvasScaleValue: CGFloat = 1.0
    @Published var canvasScale: CGFloat = 1.0
    
    var canvasHeight: CGFloat {
        canvasSize.height * canvasScale
    }
    var canvasWidth: CGFloat {
        canvasSize.width * canvasScale
    }
    
    func onMagnificationGestureChanged(val: CGFloat) {
        let delta = val / lastCanvasScaleValue
        lastCanvasScaleValue = val
        let newScale = canvasScale * delta
        
        if newScale > 0.3 && newScale < 2.5 {
            canvasScale = newScale
        }
    }
    
    func onMagnificationGestureEnded() {
        lastCanvasScaleValue = 1.0
    }
}
