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
    @Published var selectedImageID: Int? = nil
    
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
    
    func deselectImage() {
        selectedImageID = nil
    }
    
    func isImageSelected(_ image: LoadedImage) -> Bool {
        selectedImageID == image.id
    }
    
    func insertImage(_ selectedImage: LoadedImage) {
        var newImage = selectedImage
        newImage.id = Int.random(in: 1...9999)
        insertedImages.append(newImage)
        displayingSheet = false
    }
    
    static var lastScrolledPosition: CGFloat = 0
    
    func onDragImage(image: inout LoadedImage, _ location: CGPoint) {
        var newPosition = location
        let imageHalfHeight = (image.frameHeight / 2)
        let imageHalfWidth = (image.frameWidth / 2)
        
        // Snap Top
        snapVertically(towardsTop: true, imageHalfHeight: imageHalfHeight, location: &newPosition, y: 0)
        
        // Snap Bottom
        snapVertically(towardsTop: false, imageHalfHeight: imageHalfHeight, location: &newPosition, y: canvasSize.height)
        
        // Snap Left
        snapHorizontally(towardsLeft: true, imageHalfWidth: imageHalfWidth, location: &newPosition, x: 0)
        
        // Snap Right
        snapHorizontally(towardsLeft: false, imageHalfWidth: imageHalfWidth, location: &newPosition, x: canvasSize.width)
        
        image.position = newPosition
    }
    
    func snapVertically(towardsTop: Bool, imageHalfHeight: CGFloat, location: inout CGPoint, y: CGFloat) {
        let snapLocation = towardsTop ? (y + imageHalfHeight) : (y - imageHalfHeight)
        let leftSnapZone =  snapLocation - 25
        let rightSnapZone = snapLocation + 25
        
        if location.y >= leftSnapZone && location.y <= rightSnapZone {
            location.y = snapLocation
        }
    }
    
    func snapHorizontally(towardsLeft: Bool, imageHalfWidth: CGFloat, location: inout CGPoint, x: CGFloat) {
        let snapLocation = towardsLeft ? (x + imageHalfWidth) :  (x - imageHalfWidth)
        let leftSnapZone =  snapLocation - 25
        let rightSnapZone = snapLocation + 25
        
        if location.x >= leftSnapZone && location.x <= rightSnapZone {
            location.x = snapLocation
        }
    }
}
