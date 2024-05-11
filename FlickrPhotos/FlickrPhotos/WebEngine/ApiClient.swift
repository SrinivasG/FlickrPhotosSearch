//
//  ApiClient.swift
//  FlickrPhotos
//
//  Created by Srinivas Gadda on 11/05/24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidRequest
    case serverError
    case unknowResponse
}

class ApiClient {
    private let publicPhotosURLString: String = "https://www.flickr.com/services/feeds/photos_public.gne?nojsoncallback=1&format=json&tags="
    
    func fetchPublicPhotosFeed(searchText: String) async throws -> Result<[FeedItem], APIError> {
        guard let url = URL(string: "\(publicPhotosURLString)\(searchText)") else {
            return .failure(.invalidURL)
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let urlResponse = response as? HTTPURLResponse {
                switch urlResponse.statusCode {
                case 200...299:
                    let responseObj = try JSONDecoder().decode(FlickrFeed.self, from: data)
                    return .success(responseObj.items)
                case 400...499:
                    return .failure(.invalidRequest)
                case 500...599:
                    return .failure(.serverError)
                default:
                    return .failure(.unknowResponse)
                }
            }
        } catch {
            return .failure(.unknowResponse)
        }
        return .failure(.unknowResponse)
    }
}
