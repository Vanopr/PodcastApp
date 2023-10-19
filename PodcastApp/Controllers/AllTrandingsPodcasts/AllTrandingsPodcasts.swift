//
//  AllTrandingsPodcasts.swift
//  PodcastApp
//
//  Created by Vanopr on 29.09.2023.
//

import UIKit
import PodcastIndexKit
class AllTrandingsPodcasts: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let podcastIndexKit = PodcastIndexKit()
    private var podcasts: PodcastArrayResponse? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var name: String?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataForSelected(name: name ?? "")
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.register(PodcastCell.self, forCellWithReuseIdentifier: "PodcastCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        navigationController?.navigationBar.isHidden = false
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    private func fetchDataForSelected(name: String) {
        Task {
            do {
                let data = try await podcastIndexKit.podcastsService.trendingPodcasts(cat: name)
                podcasts = data
            } catch {
                print("Произошла ошибка: \(error)")
            }
        }
    }
    
    @objc private func liked(sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: point) {
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
        return podcasts?.count ?? 1
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

