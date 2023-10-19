//
//  CustomTabbarController.swift
//  PodcastApp
//
//  Created by Sergey on 25.09.2023.
//

import UIKit
import PodcastIndexKit

class CustomTabBarController: UITabBarController {
    
    let miniPayer = MiniPlayerView()
    
    override func viewDidAppear(_ animated: Bool) {
        miniPayer.togglePlayButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
        setupMiniPlayer()
        AudioService.shared.delegateMiniPlayer = self
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: MainViewController(),
                title: "Home",
                image: UIImage(named: "Home"),
                selectedImage: UIImage(named: "HomeFill")
            ),
            generateVC(
                viewController: SearchViewController(),
                title: "Search",
                image: UIImage(named: "Search"),
                selectedImage: UIImage(named: "SearchFill")
            ),
            generateVC(
                viewController: FavoritesViewController(),
                title: "Favorites",
                image: UIImage(named: "Bookmark"),
                selectedImage: UIImage(named: "BookmarkFill")
            ),
            generateVC(
                viewController: ProfileViewController(),
                title: "Profile",
                image: UIImage(named: "Profile"),
                selectedImage: UIImage(named: "ProfileFill")
            )
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        let vc = UINavigationController(rootViewController: viewController)
//        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        vc.tabBarItem.selectedImage = selectedImage
        return vc
    }
    
    private func setTabBarAppearance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionOnX,
                y: tabBar.bounds.minY - positionOnY,
                width: width,
                height: height
            ),
            cornerRadius: height / 4
        )
        
        roundLayer.path = bezierPath.cgPath
        
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.white.cgColor
        
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        tabBar.layer.shadowOffset = CGSize(width: -4, height: -6)
        tabBar.layer.shadowOpacity = 0.9
        tabBar.layer.shadowRadius = 20
    }
    
     func setupMiniPlayer() {
        view.addSubview(miniPayer)
        miniPayer.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.bottom.equalTo(tabBar.snp.top).offset(-20)
            make.height.equalTo(68)
        }
         miniPayer.isHidden = true
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
         miniPayer.backView.addGestureRecognizer(tapGesture)
         let swipeUpGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipeUp(_:)))
         miniPayer.addGestureRecognizer(swipeUpGesture)
         miniPayer.backButton.addTarget(self, action: #selector(backButtonTaped), for: .touchUpInside)
         miniPayer.playButton.addTarget(self, action: #selector(playButtonTaped), for: .touchUpInside)
         miniPayer.forwardButton.addTarget(self, action: #selector(forwardButtonTaped), for: .touchUpInside)

    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let vc = PlayerViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc func handleSwipeUp(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)
        let deltaY = translation.y
        let viewHeight: CGFloat = 100 // Измените это значение на желаемую высоту
        switch gesture.state {
        case .changed:
            if deltaY > 0 {
                miniPayer.transform = CGAffineTransform(translationX: 0, y: -deltaY)
            }
        case .ended:
            if deltaY > viewHeight {
                UIView.animate(withDuration: 0.3) {
                    self.miniPayer.alpha = 0
                    self.miniPayer.transform = CGAffineTransform(translationX: 0, y: -self.miniPayer.frame.height)
                } completion: { _ in
                    self.miniPayer.isHidden = true
                    AudioService.shared.stop()
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.miniPayer.transform = .identity
                }
            }
        default:
            break
        }
    }
    
    @objc func backButtonTaped() {
        AudioService.shared.previousSong()
        miniPayer.togglePlayButton()
    }
    
    @objc func playButtonTaped() {
        AudioService.shared.playOrStop()
        miniPayer.togglePlayButton()
    }
    
    @objc func forwardButtonTaped() {
        AudioService.shared.nextSong()
        miniPayer.togglePlayButton()
    }
}

extension CustomTabBarController: MiniPlayerDelegate {
    func didSelectCell() {
        let currentId = AudioService.shared.currentId()
        let episode = AudioService.shared.allEps?.items?[currentId]
        FetchImage.shared.loadImageFromURL(urlString: episode?.image ?? "") { image in
            let resizedImage = FetchImage.resizeImage(image: image, targetSize: CGSize(width: 279, height: 326))
            DispatchQueue.main.async {
                self.miniPayer.setupMiniPlayer(image: resizedImage, title: episode?.title ?? "")
            }
        }
        AudioService.shared.playAudio()
        miniPayer.togglePlayButton()
        miniPayer.isHidden = false
        miniPayer.alpha = 1.0
        miniPayer.transform = .identity
    }
}

extension CustomTabBarController: PlayerViewControllerDelegate {
    func updateMiniPlayer() {
        print("UPDATE MINI Player")
        let currentId = AudioService.shared.currentId()
        let episode = AudioService.shared.allEps?.items?[currentId]
        FetchImage.shared.loadImageFromURL(urlString: episode?.image ?? "") { image in
            let resizedImage = FetchImage.resizeImage(image: image, targetSize: CGSize(width: 279, height: 326))
            DispatchQueue.main.async {
                self.miniPayer.setupMiniPlayer(image: resizedImage, title: episode?.title ?? "")
            }
        }
    }
}

