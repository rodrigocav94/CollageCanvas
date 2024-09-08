//
//  PexelsService.swift
//  CollageCanvas
//
//  Created by Rodrigo Cavalcanti on 08/09/24.
//

import Foundation

// Service class for fetching curated photos from Pexels
final class PexelsService {
    
    private enum Params: String {
        case page, per_page
    }
    
    static func fetchCuratedPhotos(page: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        
        var components = URLComponents(string: "https://api.pexels.com/v1/curated")!

        components.queryItems = [
            URLQueryItem(name: Params.page.rawValue, value: String(page)),
            URLQueryItem(name: Params.per_page.rawValue, value: "15")
        ]

        guard let url = components.url else {
            print("Invalid URL")
            return
        }
        
        // Create the request and add the API key in the header
        var request = URLRequest(url: url)
        request.addValue(SchemeEnvironment.getValue(forKey: .pexelsKey), forHTTPHeaderField: "Authorization")
        
        // Use URLSession to make the API call
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                // Handle the error
                completion(.failure(error))
                return
            }
            
            // Ensure we have data
            guard let data = data else {
                print("No data returned")
                return
            }
            
            // Decode the JSON data
            do {
                let decodedResponse = try JSONDecoder().decode(PexelsResponse.self, from: data)
                completion(.success(decodedResponse.photos))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    private init() { }
}
