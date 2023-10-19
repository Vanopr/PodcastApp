
import UIKit
import PodcastIndexKit

class FavoritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let podcastIndexKit = PodcastIndexKit()
    private var podcasts: [PodcastResponse]? {
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
        fetchDataForLiked()
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        podcasts = nil
    }
    
    
    @objc private func liked(sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: point) {
            guard let id = podcasts?[indexPath.row].feed?.id else { return }
                sender.setImage(UIImage(systemName: "heart"), for: .normal)
                sender.tintColor = UIColor.gray
                LikedPodcast.shared.likedPodcasts.removeAll{$0 == id}
            podcasts?.remove(at: indexPath.row)
            collectionView.reloadData()
            
        }
    }
    
        private func fetchDataForLiked() {
            let likedPodcastsId = LikedPodcast.shared.likedPodcasts
            var array: [PodcastResponse] = []
            guard likedPodcastsId.count > 0 else {return}
            for i in 0...likedPodcastsId.count - 1 {
                Task {
                    do {
                        let id = likedPodcastsId[i]
                        let data = try await podcastIndexKit.podcastsService.podcast(byFeedId: id)
                        array.append(data)
                        podcasts = array
                    } catch {
                        print("Произошла ошибка: \(error)")
                    }
                }
            }
                collectionView.reloadData()
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return podcasts?.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PodcastCell", for: indexPath) as! PodcastCell
            let podcast = podcasts?[indexPath.row].feed
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
    }

