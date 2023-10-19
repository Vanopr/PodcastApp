//
//  Channel.swift
//  PodcastApp
//
//  Created by Vanopr on 02.10.2023.
//

import UIKit

class Channel: UIView {

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = .palePink
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var titleLbl: UILabel = {
        let label = UILabel()
        label.font = .manropeBold(size: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var descriptionLbl: UILabel = {
        let label = UILabel()
        label.font = .manropeRegular(size: 16)
        label.textColor = UIColor.systemGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    private var stackViewDescription: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(white: 0, alpha: 0)
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(white: 0, alpha: 0)
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var allEpisodesTitle: UILabel = {
        let label = UILabel()
        label.font = .manropeBold(size: 16)
        label.numberOfLines = 1
        label.text = "All Episodes"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .vertical
       let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
       collectionView.backgroundColor = .white
       return collectionView
   }()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
        stackViewDescription.addArrangedSubview(descriptionLbl)
        stackView.addArrangedSubview(titleLbl)
        stackView.addArrangedSubview(stackViewDescription)
        addSubview(imageView)
        addSubview(stackView)
        addSubview(allEpisodesTitle)
        addSubview(collectionView)
        setupConstrains()
        collectionView.register(PodcastCell.self, forCellWithReuseIdentifier: "PodcastCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstrains() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().inset(32)
            make.height.equalTo(44)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(84)
            make.width.equalTo(84)
        }
        
        stackViewDescription.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(2)
        }
        allEpisodesTitle.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(32)
            make.height.equalTo(22)
            make.width.equalTo(100)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(allEpisodesTitle.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    public func setupChannel(title: String, image: UIImage? = nil) {
        titleLbl.text = title
        imageView.image = image
    }
    public func setupDescription(episodes: Int, description: String) {
        descriptionLbl.text = "\(episodes) Eps | \(description)"
    }
}
