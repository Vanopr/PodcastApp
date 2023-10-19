//
//  UICollectionView + CenterCell.swift
//  PodcastApp
//
//  Created by Sergey on 08.10.2023.
//

import Foundation
import UIKit

extension UICollectionView {

var centerPoint : CGPoint {

    get {
        return CGPoint(x: self.center.x + self.contentOffset.x, y: self.center.y + self.contentOffset.y);
    }
}

var centerCellIndexPath: IndexPath? {

    if let centerIndexPath: IndexPath  = self.indexPathForItem(at: self.centerPoint) {
        return centerIndexPath
    }
    return nil
}
}
