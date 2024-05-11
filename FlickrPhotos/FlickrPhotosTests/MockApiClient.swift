//
//  MockApiClient.swift
//  FlickrPhotosTests
//
//  Created by Srinivas Gadda on 11/05/24.
//

import Foundation
@testable import FlickrPhotos

class MockApiClient: ApiClient {
    var result: Result<[FeedItem], APIError> = .failure(.invalidRequest)
    
    override func fetchPublicPhotosFeed(searchText: String) async throws -> Result<[FeedItem], APIError> {
        return result
    }
    
    func fetchSuccessFeed() -> [FeedItem] {
        let url = URL(fileURLWithPath: "MockPhotos.json")
        do {
            let data = try Data(contentsOf: url)
            let responseObj = try JSONDecoder().decode(FlickrFeed.self, from: data)
            return responseObj.items
        } catch {
            return []
        }
    }
}
