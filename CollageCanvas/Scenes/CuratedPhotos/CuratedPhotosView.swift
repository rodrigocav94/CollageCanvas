//
//  CuratedPhotosView.swift
//  CollageCanvas
//
//  Created by Rodrigo Cavalcanti on 08/09/24.
//

import SwiftUI

struct CuratedPhotosView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = CuratedPhotosViewModel()
    @ObservedObject var homeVM: HomeViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VerticalGrid
            }
            .navigationTitle(Localization.CuratedPhotos.overlays.localized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                CloseButton
            }
        }
        .onAppear {
            vm.loadPhotos()
        }
    }
}

// MARK: - Vertical Grid
extension CuratedPhotosView {
    var VerticalGrid: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 100))],
            spacing: 5
        ) {
            LoadedPhotos
        }
        .padding()
    }
}

// MARK: - Loaded Photos
extension CuratedPhotosView {
    var LoadedPhotos: some View {
        ForEach(vm.loadedImages) { loadedImage in
            Button {
                dismiss()
            } label: {
                loadedImage.image
                    .resizable()
                    .scaledToFit()
                    .onAppear {
                        if vm.loadedPhotoData.last?.id == loadedImage.id {
                            vm.loadPhotos()
                        }
                    }
            }
        }
        .frame(maxWidth: 150, maxHeight: 150)
    }
}

// MARK: - Navigation Bar's Close Button
extension CuratedPhotosView {
    var CloseButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .font(.title2)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CuratedPhotosView(homeVM: HomeViewModel())
}
