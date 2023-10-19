//
//  AllCategoriesController.swift
//  PodcastApp
//
//  Created by Sergey on 28.09.2023.
//

import UIKit
import PodcastIndexKit

class AllCategoriesController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    private let searchBar = UISearchBar()
    
    var categoriesArray: CategoriesResponse?
    private var categories: [String]?
    {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        categories = makeCategoryArray()
        collectionView.register(PodcastCell.self, forCellWithReuseIdentifier: "PodcastCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        navigationController?.navigationBar.isHidden = false

        searchBar.delegate = self
        searchBar.placeholder = "Поиск"
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.borderStyle = .roundedRect
            textField.layer.borderWidth = 1.0
            textField.clipsToBounds = true
            textField.layer.cornerRadius = 10
            textField.layer.borderColor = UIColor.lightBlue.cgColor
        }

    }
    private func makeCategoryArray() -> [String]  {
        var array: [String] = []
        for i in 0...(categoriesArray?.feeds?.count ?? 2) - 1 {
            array.append(categoriesArray?.feeds?[i].name ?? "")
        }
        return array
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PodcastCell", for: indexPath) as! PodcastCell
        cell.setupPodcastCell(titleLeft: categories?[indexPath.row] ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 72)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            categories = makeCategoryArray()
        } else {
        categories = makeCategoryArray().filter { $0.localizedCaseInsensitiveContains(searchText) }
               }
           }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = AllTrandingsPodcasts()
        viewController.name = categories?[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

