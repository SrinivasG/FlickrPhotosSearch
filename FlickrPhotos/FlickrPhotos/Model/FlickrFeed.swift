//
//  FlickrFeed.swift
//  FlickrPhotos
//
//  Created by Srinivas Gadda on 11/05/24.
//

import Foundation

struct FlickrFeed: Decodable {
    let items: [FeedItem]
}

struct FeedItem: Decodable {
    let title: String
    let description: String
    let tags: String
    let media: Media
}

struct Media: Decodable {
    let m: String
}
