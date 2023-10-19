//
//  MiniPlayerView.swift
//  PodcastApp
//
//  Created by Vanopr on 06.10.2023.
//

import Foundation
import UIKit
class MiniPlayerView : UIView {
    
    private var imageViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 21.5
        imageView.backgroundColor = .palePink
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var titleLbl: UILabel = {
        let label = UILabel()
        label.font = .manropeBold(size: 16)
        label.text = "Pop Star Eps 49"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     var backView: UIView = {
        let viewCardView = UIView()
        viewCardView.backgroundColor = .blueSearchCell
        viewCardView.layer.cornerRadius = 10
        viewCardView.translatesAutoresizingMaskIntoConstraints = false
     
        return viewCardView
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        button.tintColor = UIColor.black
        button.contentMode = .scaleToFill
        button.setImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        button.tintColor = UIColor.black
        button.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let forwardButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        button.tintColor = UIColor.black
        button.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
        setupView()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
      fatalError("Please use this class from code.")
    }
    
 
    
    private func setupView() {
        addSubview(backView)
        backView.addSubview(imageViewCell)
        backView.addSubview(forwardButton)
        backView.addSubview(playButton)
        backView.addSubview(backButton)
        backView.addSubview(titleLbl)

    }
    
    private func setupConstrains() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageViewCell.snp.makeConstraints { make in
            make.height.equalTo(43)
            make.width.equalTo(43)
            make.leading.equalTo(backView).offset(20)
            make.centerY.equalTo(backView)
        }

        forwardButton.snp.makeConstraints { make in
            make.trailing.equalTo(backView).inset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(15)
            make.width.equalTo(15)
        }
        
        playButton.snp.makeConstraints { make in
            make.trailing.equalTo(forwardButton.snp.leading).offset(-20)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(30)
            
        }

        backButton.snp.makeConstraints { make in
            make.trailing.equalTo(playButton.snp.leading).offset(-20)
            make.centerY.equalToSuperview()
            make.height.equalTo(15)
            make.width.equalTo(15)

        }

        titleLbl.snp.makeConstraints { make in
            make.leading.equalTo(imageViewCell.snp.trailing).offset(10)
            make.trailing.equalTo(backButton.snp.leading).inset(-10)
            make.centerY.equalToSuperview()
            make.height.equalTo(43)
        }
    }
    
    public func togglePlayButton() {
        if AudioService.shared.isEpsPlaying {
            playButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        } else {
            playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        }
    }
    
    public func setupMiniPlayer(image: UIImage? = nil, title: String) {
        imageViewCell.image = image
        titleLbl.text = title
    }
    
 
  
    
}
