//
//  Search.swift
//  PodcastApp
//
//  Created by Vanopr on 03.10.2023.
//

import Foundation
import UIKit

class SearchView: UIView {
    let searchBar: UISearchBar = {
           let searchBar = UISearchBar()
           searchBar.placeholder = "Podcast, channel, artist"
           searchBar.backgroundImage = UIImage()
           searchBar.barTintColor = .white
           searchBar.layer.cornerRadius = 12
           searchBar.clipsToBounds = true
           searchBar.translatesAutoresizingMaskIntoConstraints = false
           return searchBar
       }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().inset(32)
            make.height.equalTo(48)
        }
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor.white
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
