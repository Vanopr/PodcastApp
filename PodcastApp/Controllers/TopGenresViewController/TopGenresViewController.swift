//
//  TopGenresViewController.swift
//  PodcastApp
//
//  Created by Vanopr on 03.10.2023.
//

import Foundation
import UIKit

class TopGenresViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let genres = TopGenresModel.topGenres
    
    let topGenresCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        setupBackgroundColor()
        setupCollectionView()
    }
    
    private func setupBackgroundColor() {
        view.backgroundColor = .white
        let gradientLayer = CAGradientLayer()
        let colors = [UIColor.redSearch, UIColor.hexadecimal]
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupCollectionView() {
        view.addSubview(topGenresCollectionView)
        topGenresCollectionView.dataSource = self
        topGenresCollectionView.delegate = self
        topGenresCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.equalTo(view).offset(32)
            make.trailing.equalTo(view).inset(32)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        cell.configure(with: genres[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 64 - 10)/2
        let height = 0.57 * width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = GenreResultViewController()
        vc.genre = TopGenresModel.topGenres[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    } 
}
