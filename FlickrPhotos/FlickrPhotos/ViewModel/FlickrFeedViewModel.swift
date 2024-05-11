//
//  FlickrFeedViewModel.swift
//  FlickrPhotos
//
//  Created by Srinivas Gadda on 11/05/24.
//

import Foundation

class FlickrFeedViewModel {
    private let apiClient: ApiClient
    var feedItems: [FeedItem]?
    var errorString: String?
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func fetchPhotos(searchTerm: String) async {
        do {
            let result = try await apiClient.fetchPublicPhotosFeed(searchText: searchTerm)
            switch result {
            case .success(let items):
                feedItems = items
            case .failure(let error):
                switch error {
                case .invalidRequest:
                    errorString = "Please check the request and try again"
                case .invalidURL:
                    errorString = "Looks like the search url is incorrect. Please do recheck!"
                case .serverError:
                    errorString = "Unable to reach the server. Please try again"
                case .unknowResponse:
                    errorString = "Unable to decode the service response."
                }
            }
        } catch {
            errorString = "Something went wrong. Please retry!"
        }
    }

    var numberOfFeedItems: Int {
        feedItems?.count ?? 0
    }
}
