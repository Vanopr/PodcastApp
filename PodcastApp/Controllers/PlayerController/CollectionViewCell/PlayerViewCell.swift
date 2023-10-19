//
//  PlayerViewCell.swift
//  PodcastApp
//
//  Created by Sergey on 06.10.2023.
//

import Foundation
import UIKit
import SnapKit

class PlayerCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "PlayerCollectionViewCell"
    
    let spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray4
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setViews() {
        addSubview(mainImageView)
    }
    
    func layoutViews() {
        
        mainImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
    }
    
    func configureCell(for image: UIImage?) {
        // Setting up spinner if image didn't load yet
        if let image = image {
            spinner.removeFromSuperview()
            self.mainImageView.alpha = 0.5
            UIView.animate(withDuration: 0.55) {
                self.mainImageView.image = image
                self.mainImageView.alpha = 1
            }
        } else {
            addSubview(spinner)
            spinner.setUpSpinner(loadingImageView: mainImageView)
        }
    }
    
}


