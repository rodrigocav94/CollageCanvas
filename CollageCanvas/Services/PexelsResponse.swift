//
//  PexelsResponse.swift
//  CollageCanvas
//
//  Created by Rodrigo Cavalcanti on 08/09/24.
//

import Foundation

// Model for the Pexels API response
struct PexelsResponse: Codable {
    let photos: [Photo]
}

struct Photo: Codable, Identifiable {
    let id: Int
    let width: Int
    let height: Int
    let url: URL
    let src: PhotoSrc
}

struct PhotoSrc: Codable {
    let medium: URL
    let small: URL
}
