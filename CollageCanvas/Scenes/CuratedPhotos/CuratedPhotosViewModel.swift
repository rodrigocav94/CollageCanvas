//
//  CuratedPhotosViewModel.swift
//  CollageCanvas
//
//  Created by Rodrigo Cavalcanti on 08/09/24.
//

import Foundation

class CuratedPhotosViewModel: ObservableObject {
    @Published var loadedPhotos: [Photo] = []
    
    func loadPhotos() {
        PexelsService.fetchCuratedPhotos { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    self?.loadedPhotos = photos
                case .failure(let error):
                    print("Error fetching photos: \(error)")
                }
            }
        }
    }
}
