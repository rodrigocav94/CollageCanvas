//
//  CuratedPhotosViewModel.swift
//  CollageCanvas
//
//  Created by Rodrigo Cavalcanti on 08/09/24.
//

import Foundation
import SwiftUI

class CuratedPhotosViewModel: ObservableObject {
    var nextPage = 1
    @Published var loadedPhotoData: [PhotoData] = []
    @Published var loadedImages: [LoadedImage] = []
    
    func loadPhotos() {
        PexelsService.fetchCuratedPhotos(page: nextPage) { [weak self] result in
            switch result {
            case .success(let photos):
                DispatchQueue.main.async {
                    self?.loadedPhotoData.append(contentsOf: photos)
                    self?.nextPage += 1
                    self?.loadImages()
                }
            case .failure(let error):
                print("Error fetching photos: \(error)")
            }
        }
    }
    
    func loadImages() {
        for photo in loadedPhotoData {
            if loadedImages.contains(where: {
                $0.id == photo.id
            }) {
                continue
            }
            
            URLSession.shared.dataTask(with: photo.src.medium) { [weak self] data, response, error in
                if let data,
                   let loadedImage = UIImage(data: data) {
                    let swiftUIImage = Image(uiImage: loadedImage)
                    
                    DispatchQueue.main.async() {
                        guard let self else { return }
                        if !self.loadedImages.contains(where: {
                            $0.id == photo.id
                        }) {
                            self.loadedImages.append(LoadedImage(id: photo.id, image: swiftUIImage))
                        }
                    }
                }
                
                if error != nil && self?.loadedPhotoData.last?.id == photo.id {
                    self?.loadPhotos()
                }
            }.resume()
        }
    }
}

struct LoadedImage: Identifiable {
    var id: Int
    var image: Image
}
