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
        PositionReadableScrollView(axes: .horizontal) {
            Color.white
                .frame(width: vm.canvasSize.width, height: vm.canvasSize.height)
                .overlay {
                    DeselectionOverlay
                }
                .overlay {
                    InsertedImages
                }
                .frame(maxHeight: .infinity)
        } onScroll: {
            HomeViewModel.lastScrolledPosition = $0 * -1
        }
        .scrollDisabled(vm.selectedImageID != nil)
        .mask(
            CanvasBackground
        )
    }
}

// MARK: - Canvas Background
extension ScrollableCanvasView {
    var CanvasBackground: some View {
        VStack(spacing: 0) {
            Color.clear
            Color.black
                .frame(height: vm.canvasSize.height)
            Color.clear
        }
    }
}

// MARK: - Deselection Overlay
extension ScrollableCanvasView {
    var DeselectionOverlay: some View {
        Group {
            if vm.selectedImageID != nil {
                Color.white.opacity(0.01)
                    .frame(height: UIScreen.main.bounds.size.height)
                    .onTapGesture {
                        vm.deselectImage()
                    }

            }
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
                        DragGesture(coordinateSpace: .local)
                            .onChanged { value in
                                vm.onDragImage(image: &draggableImage, value.location)
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
