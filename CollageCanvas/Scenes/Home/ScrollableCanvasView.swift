//
//  ScrollableCanvasView.swift
//  CollageCanvas
//
//  Created by Rodrigo Cavalcanti on 08/09/24.
//

import SwiftUI

struct ScrollableCanvasView: View {
    @ObservedObject var vm: HomeViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            ZStack {
                CanvasBackground
                DeselectionOverlay
                InsertedImages
            }
        }
    }
}

// MARK: - Canvas Background
extension ScrollableCanvasView {
    var CanvasBackground: some View {
        Color.white
            .frame(width: vm.canvasSize.width, height: vm.canvasSize.height)
            .frame(maxHeight: .infinity)
    }
}

// MARK: - Deselection Overlay
extension ScrollableCanvasView {
    var DeselectionOverlay: some View {
        Color.white.opacity(0.1)
            .onTapGesture {
                vm.deselectImage()
            }
    }
}

// MARK: - Inserted Images Label and Gestures
extension ScrollableCanvasView {
    var InsertedImages: some View {
        ForEach($vm.insertedImages) { $draggableImage in
            Button {
                vm.selectedImageID = draggableImage.id
            } label: {
                draggableImage.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: draggableImage.size.width * draggableImage.scale, height: draggableImage.size.height * draggableImage.scale)
                    .overlay {
                        if vm.isImageSelected(draggableImage) {
                            Color.blue.opacity(0.2)
                        }
                    }
                    .position(draggableImage.position)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                draggableImage.position = value.location
                            },
                        including: vm.isImageSelected(draggableImage) ? .all : .none
                    )
                    .gesture(
                        MagnificationGesture()
                            .onChanged { val in
                                vm.onMagnificationGestureChanged(val: val, draggableImage: &draggableImage)
                            }
                            .onEnded {_ in
                                vm.onMagnificationGestureEnded(draggableImage: &draggableImage)
                            },
                        including: vm.isImageSelected(draggableImage) ? .all : .none
                    )
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    ScrollableCanvasView(vm: HomeViewModel())
}
