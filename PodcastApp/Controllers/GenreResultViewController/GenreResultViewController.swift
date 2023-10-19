//
//  TopG.swift
//  PodcastApp
//
//  Created by Vanopr on 04.10.2023.
//

import Foundation
import UIKit
import PodcastIndexKit

class GenreResultViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let searchResultView = SearchResultView()
    private let podcastIndexKit = PodcastIndexKit()
    private var podcasts: PodcastArrayResponse? 
    var genre: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataForSearch(genre: genre ?? "")
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(searchResultView)
        searchResultView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        searchResultView.collectionView.delegate = self
        searchResultView.collectionView.dataSource = self
        searchResultView.collectionView.register(PodcastCell.self, forCellWithReuseIdentifier: "PodcastCell")
        navigationController?.navigationBar.isHidden = false
    }
    
    private func fetchDataForSearch(genre: String) {
        Task {
            do {
                let data = try await podcastIndexKit.searchService.search(byTerm: genre)
                podcasts = data
                searchResultView.collectionView.reloadData()
            } catch {
                print("Произошла ошибка: \(error)")
            }
        }
    }
    
    
    @objc private func liked(sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: searchResultView.collectionView)
        if let indexPath = searchResultView.collectionView.indexPathForItem(at: point) {
            guard let id = podcasts?.feeds?[indexPath.row].id else { return }
            if  sender.tintColor == UIColor.gray {
                sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                sender.tintColor = UIColor.red
                LikedPodcast.shared.likedPodcasts.append(id)
                print(LikedPodcast.shared.likedPodcasts)
            } else {
                sender.setImage(UIImage(systemName: "heart"), for: .normal)
                sender.tintColor = UIColor.gray
                LikedPodcast.shared.likedPodcasts.removeAll{$0 == id}
                print(LikedPodcast.shared.likedPodcasts)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return podcasts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PodcastCell", for: indexPath) as! PodcastCell
        let podcast = podcasts?.feeds?[indexPath.row]
        FetchImage.shared.loadImageFromURL(urlString: podcast?.image ?? "") { image in
            let resizedImage = FetchImage.resizeImage(image: image, targetSize: CGSize(width: 50, height: 50))
            DispatchQueue.main.async {
                cell.setupPodcastCell(
                    titleLeft: podcast?.title ?? "",
                    titleRight: podcast?.author ?? "",
                    descriptionLeft: podcast?.categories?.values.joined(separator: " & ") ?? "",
                    descriptionRight: "Right",
                    image: resizedImage,
                    cellType: .podcast)
                cell.checkmarkButton.addTarget(self, action: #selector(self.liked(sender:)), for: .touchUpInside)
                cell.ifLiked(id: podcast?.id ?? 0)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 72)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let podcast = self.podcasts?.feeds?[indexPath.row]
        let vc = ChannelViewController()
        vc.podcast = podcast
        navigationController?.pushViewController(vc, animated: true)
    }
}
