//
//  File.swift
//  PodcastApp
//
//  Created by Vanopr on 02.10.2023.
//

import Foundation
final class LikedPodcast {
    static let shared = LikedPodcast()
    var likedPodcasts: [Int] = []
    init(){}
}
