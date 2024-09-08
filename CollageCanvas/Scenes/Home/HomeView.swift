//
//  ContentView.swift
//  CollageCanvas
//
//  Created by Rodrigo Cavalcanti on 08/09/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        ZStack {
            ScrollableCanvas
            AddImageButton
        }
        .sheet(isPresented: $vm.displayingSheet) {
            CuratedPhotosView(homeVM: vm)
        }
    }
}


// MARK: - Add Image Button
extension HomeView {
    var AddImageButton: some View {
        Button {
            vm.displayingSheet.toggle()
        } label: {
            Image(systemName: "plus.circle.fill")
                .font(.largeTitle)
                .padding(.bottom)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

// MARK: - Canvas
extension HomeView {
    var ScrollableCanvas: some View {
        ScrollView(.horizontal) {
            ZStack {
                Color.white
                    .frame(width: vm.canvasSize.width, height: vm.canvasSize.height)
                    .frame(maxHeight: .infinity)
                
                ForEach($vm.insertedImages) { $draggableImage in
                    draggableImage.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(draggableImage.scale)
                        .position(draggableImage.position)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    draggableImage.position = value.location
                                }
                        )
                        .gesture(
                            MagnificationGesture()
                                .onChanged { val in
                                    vm.onMagnificationGestureChanged(val: val, draggableImage: &draggableImage)
                                }
                                .onEnded {_ in 
                                    vm.onMagnificationGestureEnded(draggableImage: &draggableImage)
                                }
                        )
                }
            }
        }
        .clipShape(Rectangle())
    }
}

#Preview {
    HomeView()
}
