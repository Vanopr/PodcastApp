//
//  SearchView.swift
//  PodcastApp
//
//  Created by Sergey on 25.09.2023.
//

import Foundation
import UIKit
import SnapKit

class SearchCollectionView: UIView {
    
    override init(frame: CGRect) {
      super.init(frame: frame)
        addSubview(topGenresLabel)
        addSubview(seeAllButton)
        addSubview(genresCollectionView)
        addSubview(browseAll)
        addSubview(categoriesCollectionView)
        setupConstrains()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var topGenresLabel: UILabel = {
        let label = UILabel()
        label.font = .manropeBold(size: 16)
        label.numberOfLines = 1
        label.text = "Top Genres"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.imageView?.tintColor = .gray
        button.titleLabel?.font = .manropeRegular(size: 16)
        button.semanticContentAttribute = .forceRightToLeft
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
     let genresCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .horizontal
       let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionView.backgroundColor = .clear
       collectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
       return collectionView
   }()
    
    private var browseAll: UILabel = {
        let label = UILabel()
        label.font = .manropeBold(size: 16)
        label.numberOfLines = 1
        label.text = "Browse All"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let categoriesCollectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          layout.scrollDirection = .vertical
          let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
          collectionView.backgroundColor = .clear
          collectionView.translatesAutoresizingMaskIntoConstraints = false
          return collectionView
      }()
    
    private func setupConstrains() {
   
        topGenresLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.leading.equalToSuperview().offset(32)
            make.height.equalTo(22)
        }
        
        seeAllButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().inset(32)
            make.height.equalTo(22)
        }
        
        genresCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topGenresLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview()
            make.height.equalTo(90)
        }
        
        browseAll.snp.makeConstraints { make in
            make.top.equalTo(genresCollectionView.snp.bottom).offset(22)
            make.leading.equalToSuperview().offset(32)
            make.height.equalTo(22)
        }
        
        categoriesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(browseAll.snp.bottom).offset(22)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().inset(32)
            make.bottom.equalToSuperview()
        }
        
        
    }

    
}
