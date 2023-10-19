//
//  MainView.swift
//  PodcastApp
//
//  Created by Sergey on 25.09.2023.
//

import Foundation
import UIKit
import SnapKit



import UIKit

class MainCollection: UIView  {

    
     let topHorizontalCollectionView1: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

     let topHorizontalCollectionView2: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

     let bottomVerticalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
        setupCollectionView()
        addSubview(topHorizontalCollectionView1)
        addSubview(topHorizontalCollectionView2)
        addSubview(bottomVerticalCollectionView)
        layoutCollectionViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutCollectionViews() {
        let padding: CGFloat = 10
        topHorizontalCollectionView1.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(200)
        }
        topHorizontalCollectionView2.snp.makeConstraints { make in
            make.top.equalTo(topHorizontalCollectionView1.snp.bottom).offset(padding)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(44)
        }
        bottomVerticalCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topHorizontalCollectionView2.snp.bottom).offset(padding)
            make.trailing.equalTo(self)
            make.leading.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
   private func setupCollectionView() {
       topHorizontalCollectionView1.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        topHorizontalCollectionView2.register(CategoryNameCell.self, forCellWithReuseIdentifier: "CategoryNameCell")
        bottomVerticalCollectionView.register(PodcastCell.self, forCellWithReuseIdentifier: "PodcastCell")
    }
}


