//
//  LoginView.swift
//  PodcastApp
//
//  Created by Sergey on 28.09.2023.
//

import UIKit

final class LineView: UIView {
    
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let aPath = UIBezierPath()
        aPath.move(to: CGPoint(x: center.x - 150, y: center.y))
        aPath.addLine(to: CGPoint(x: center.x + 150, y: center.y))
        UIColor.gray.set()
        aPath.lineWidth = 1.5
        aPath.stroke()
    }
}
