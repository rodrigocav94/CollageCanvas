//
//  CuratedPhotosViewModel.swift
//  CollageCanvas
//
//  Created by Rodrigo Cavalcanti on 08/09/24.
//

import Foundation

class CuratedPhotosViewModel: ObservableObject {
    var nextPage = 1
    @Published var loadedPhotos: [Photo] = []
    
    func loadPhotos() {
        PexelsService.fetchCuratedPhotos(page: nextPage) { [weak self] result in
            switch result {
            case .success(let photos):
                DispatchQueue.main.async {
                    self?.loadedPhotos.append(contentsOf: photos)
                    self?.nextPage += 1
                }
            case .failure(let error):
                print("Error fetching photos: \(error)")
            }
        }
    }
}
