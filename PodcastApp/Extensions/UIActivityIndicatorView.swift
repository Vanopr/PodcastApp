//
//  UIActivityIndicatorView.swift
//  PodcastApp
//
//  Created by Sergey on 07.10.2023.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    func setUpSpinner(loadingImageView: UIImageView) {
        let spinner = self
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.centerXAnchor.constraint(equalTo: loadingImageView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: loadingImageView.centerYAnchor).isActive = true
    }
}
