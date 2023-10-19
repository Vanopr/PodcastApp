//
//  View.swift
//  PodcastApp
//
//  Created by Vanopr on 25.09.2023.
//

import Foundation
import UIKit

extension UIView {
  func removeAllConstraints() {
    for subview in self.subviews {
      subview.removeConstraints(subview.constraints)
    }
  }

  static func makeView(backgroundColor: UIColor, cornerRadius: CGFloat) -> UIView {
    let view = UIView()
    view.backgroundColor = backgroundColor
    view.layer.cornerRadius = cornerRadius
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }
}
