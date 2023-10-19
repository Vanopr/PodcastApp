//
//  PageViewDelegate.swift
//  PodcastApp
//
//  Created by Aleksandr Garipov on 28.09.2023.
//

import Foundation

protocol PageViewDelegate: AnyObject {
    func skipButtonPressed()
    func nextButtonPressed()
}
