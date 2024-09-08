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
        VStack(spacing: 20) {
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
    }
}

// MARK: - Canvas
extension HomeView {
    var ScrollableCanvas: some View {
        Color.clear
            .background {
                ScrollView(.horizontal) {
                    Color.white
                        .frame(width: vm.canvasWidth, height: vm.canvasHeight)
                        .frame(maxHeight: .infinity)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { val in
                                vm.onMagnificationGestureChanged(val: val)
                            }.onEnded { val in
                                vm.onMagnificationGestureEnded()
                            }
                    )
                }
            }
            .clipShape(Rectangle())

    }
}

#Preview {
    HomeView()
}
