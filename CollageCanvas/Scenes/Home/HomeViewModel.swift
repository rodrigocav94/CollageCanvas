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
    
    var verticalBoundaries: [CGFloat]  {
        var boundaries: [CGFloat] = [0, canvasSize.height]
        
        let insertedImagesBoundaries = insertedImages.filter {
            $0.id != selectedImageID
        }.map {
            let bottom = $0.position.y + ($0.frameHeight / 2)
            let top = $0.position.y - ($0.frameHeight / 2)
            
            return [bottom, top]
        }.joined()
        
        boundaries.append(contentsOf: Array(insertedImagesBoundaries))
        
        return boundaries
    }
    
    var horizontalBoundaries: [CGFloat]  {
        var boundaries: [CGFloat] = [0, canvasSize.width]
        
        let insertedImagesBoundaries = insertedImages.filter {
            $0.id != selectedImageID
        }.map {
            let right = $0.position.x + ($0.frameWidth / 2)
            let left = $0.position.x - ($0.frameWidth / 2)
            
            return [right, left]
        }.joined()
        
        boundaries.append(contentsOf: Array(insertedImagesBoundaries))
        
        return boundaries
    }
    
    func onDragImage(image: inout LoadedImage, _ location: CGPoint) {
        var newPosition = location
        let imageHalfHeight = (image.frameHeight / 2)
        let imageHalfWidth = (image.frameWidth / 2)
        
        // Snap Top
        for boundary in verticalBoundaries {
            snapVertically(towardsTop: true, imageHalfHeight: imageHalfHeight, location: &newPosition, y: boundary)
        }
        
        // Snap Bottom
        for boundary in verticalBoundaries {
            snapVertically(towardsTop: false, imageHalfHeight: imageHalfHeight, location: &newPosition, y: boundary)
        }
        
        // Snap Left
        for boundary in horizontalBoundaries {
            snapHorizontally(towardsLeft: true, imageHalfWidth: imageHalfWidth, location: &newPosition, x: boundary)
        }
        
        // Snap Right
        for boundary in horizontalBoundaries {
            snapHorizontally(towardsLeft: false, imageHalfWidth: imageHalfWidth, location: &newPosition, x: boundary)
        }
        
        image.position = newPosition
    }
    
    func snapVertically(towardsTop: Bool, imageHalfHeight: CGFloat, location: inout CGPoint, y: CGFloat) {
        let snapLocation = towardsTop ? (y + imageHalfHeight) : (y - imageHalfHeight)
        let leftSnapZone =  snapLocation - 10
        let rightSnapZone = snapLocation + 10
        
        if location.y >= leftSnapZone && location.y <= rightSnapZone {
            location.y = snapLocation
        }
    }
    
    func snapHorizontally(towardsLeft: Bool, imageHalfWidth: CGFloat, location: inout CGPoint, x: CGFloat) {
        let snapLocation = towardsLeft ? (x + imageHalfWidth) :  (x - imageHalfWidth)
        let leftSnapZone =  snapLocation - 10
        let rightSnapZone = snapLocation + 10
        
        if location.x >= leftSnapZone && location.x <= rightSnapZone {
            location.x = snapLocation
        }
    }
}
