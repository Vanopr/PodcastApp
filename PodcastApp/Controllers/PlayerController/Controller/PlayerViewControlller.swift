//
//  PlayerViewControlller.swift
//  PodcastApp
//
//  Created by Sergey on 06.10.2023.
//

import Foundation
import UIKit
import PodcastIndexKit

protocol PlayerViewControllerDelegate {
    func updateMiniPlayer()
}

class PlayerViewController: CustomViewController<PlayerViewClass> {
    
    // MARK: Variables
    
    private var episodeVC: EpisodeCollectionView!
    
    private var episodes: EpisodeArrayResponse?
    private var podcastName: String?
    private var firstId: Int = 0
    private var centerCell: PlayerCollectionViewCell?
    private weak var audioService = AudioService.shared
    var delegate: PlayerViewControllerDelegate?
    
    // MARK: init & viewDidLoad
    
    init() {
        super.init(nibName: nil, bundle: nil)
        episodes = AudioService.shared.allEps
        firstId = AudioService.shared.id ?? 2
        podcastName = AudioService.shared.podcastName
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .crossDissolve
        navigationController?.navigationBar.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollTo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.episodeCollectionView.delegate = self
        customView.episodeCollectionView.dataSource = self
        customView.delegate = self
        audioService?.delegatePlayer = self
        episodeVC = EpisodeCollectionView()
        setupView(id: firstId)
    }
    
    private func scrollTo() {
        let id = AudioService.shared.currentId()
        let indexPathToScroll = IndexPath(row: id, section: 0)
        customView.episodeCollectionView.scrollToItem(at: indexPathToScroll, at: .centeredHorizontally, animated: false)
    }
    
    private func playSong() {
        AudioService.shared.playAudio()
        customView.changePlayStopButton()
    }
    
    private func setupView(id: Int) {
        customView.configureScreen(episodeName: episodes?.items?[id].title ?? "", podcastName: podcastName ?? "", length: episodes?.items?[id].duration)
    }
}

// MARK: - Extensions

private extension PlayerViewController {
    

}

// MARK: - - UICollectionViewDelegate:

extension PlayerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard episodes?.items?.count != 0 else {
            return
        }
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            guard scrollView is UICollectionView else { return }
            if let centerCellIndexPath: IndexPath = self.customView.episodeCollectionView.centerCellIndexPath {
                setupView(id: centerCellIndexPath.row)
                AudioService.shared.id = centerCellIndexPath.row
                playSong()
            }
    }
}





// MARK: - UICollectionViewDataSource
extension PlayerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = episodes?.items?.count {
            return count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let episodeCell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerCollectionViewCell.reuseId, for: indexPath) as! PlayerCollectionViewCell
        let episode = episodes?.items?[indexPath.row]
        FetchImage.shared.loadImageFromURL(urlString: episode?.image ?? "") { image in
            let resizedImage = FetchImage.resizeImage(image: image, targetSize: CGSize(width: 279, height: 326))
            DispatchQueue.main.async {
                episodeCell.configureCell(for: resizedImage)
            }
        }
        return episodeCell
    }
    

    
}

// MARK: - UICollectionViewDelegateFlowLayout
//extension PlayerViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: 279.0, height: 326.0)
//    }
//}

extension PlayerViewController: PlayerViewDelegate {

    func button(didButtonTapped button: UIButton) {
        let buttonTag = button.tag
        let currentId = AudioService.shared.currentId()
        switch buttonTag {
           case 1:
            AudioService.shared.isShuffleActive.toggle()
            customView.changeShuffleButton()
            setupView(id: currentId)
               break
           case 2:
               AudioService.shared.previousSong()
               scrollTo()
               setupView(id: currentId)
               customView.changePlayStopButton()
               break
           case 3:
               AudioService.shared.playOrStop()
               customView.changePlayStopButton()
               break
           case 4:
               AudioService.shared.nextSong()
               scrollTo()
               setupView(id: currentId)
               customView.changePlayStopButton()
               break
           case 5:
            AudioService.shared.isRepeatActive.toggle()
            customView.changeRepeatTrackButton()
            setupView(id: currentId)
            break
        case 6:
            delegate?.updateMiniPlayer()
            dismiss(animated: true, completion: nil)
            break
           default:
               break
           }
    }
    
    func slider(sliderChange slider: UISlider) {
        let currentId = AudioService.shared.currentId()
        guard let length = episodes?.items?[currentId].duration else { return}
        slider.maximumValue = Float(length)
        AudioService.shared.playInTime(value: slider.value)
    }
    
}

extension PlayerViewController: PlayerAudioDelegate {
    func updateView() {
        let currentId = AudioService.shared.currentId()
        scrollTo()
        setupView(id: currentId)
    }
}
