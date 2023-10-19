//
//  AudioService.swift
//  PodcastApp
//
//  Created by Vanopr on 07.10.2023.
//

import Foundation
import AVFoundation
import MediaPlayer
import PodcastIndexKit


protocol PlayerAudioDelegate {
    func updateView()
}

class AudioService {

    static let shared = AudioService()
    
    private var timer: Timer?
    
    var delegatePlayer: PlayerAudioDelegate?
    var delegateMiniPlayer: PlayerViewControllerDelegate?
    
    var allEps: EpisodeArrayResponse?
    var epsImages: [UIImage]?
    var id: Int?
    var podcastName: String?
    var isEpsPlaying = false
    var isRepeatActive = false
    var isShuffleActive = false
    
    private var player: AVPlayer?
    
    func setupAudioService(allEps: EpisodeArrayResponse?, id: Int?, podcastName: String? ) {
        self.allEps = allEps
        self.id = id
        self.podcastName = podcastName
    }
    
    
    func playAudio() {
        guard  let episodeURLString = allEps?.items?[id ?? 0].enclosureUrl else { return }
        guard let episodeURL = URL(string: episodeURLString) else {return}
        let playerItem = AVPlayerItem(url: episodeURL)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
        isEpsPlaying = true
        startUpdating()
    }
    
    func pause() {
        isEpsPlaying = false
        player?.pause()
    }
    
    func play() {
        player?.play()
        isEpsPlaying = true
        startUpdating()
    }
    
    func stop() {
        isEpsPlaying = false
        player?.pause()
        stopUpdating()
        player = nil
    }
    
    func playOrStop() {
        if isEpsPlaying {
            player?.pause()
            stopUpdating()
        } else {
            player?.play()
            startUpdating()
        }
        isEpsPlaying.toggle()
    }
    
    func isPlaying() -> Bool {
        player?.rate != 0
    }
    
    func playInTime(value: Float) {
        let seekTime = Double(value)
        let time = CMTime(seconds: seekTime, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player?.seek(to: time)
    }
    
    func second() -> Float {
        guard let time = player?.currentTime() else {return 0.0}
        return Float(CMTimeGetSeconds(time))
    }
    
    func previousSong() {
        guard let currentId = id else {return}
        var id = currentId
        if id > 0 {
            id -= 1
            self.id = id
            playAudio()
        }
    }
    
    func nextSong() {
        guard let numbersOfEpisodes = allEps?.items?.count else {return}
        guard let currentId = id else {return}
        var id = currentId
        if isShuffleActive {
            self.id = Int.random(in: 0..<numbersOfEpisodes - 1)
        } else if currentId < numbersOfEpisodes - 1 {
                id += 1
                self.id = id
        }
        playAudio()
    }
    
    func currentId() -> Int {
        guard let currentId = id else {return 0}
        return currentId
    }
    
    func shuffleId() {
        guard let numbersOfEpisodes = allEps?.items?.count else {return}
        id = Int.random(in: 0..<numbersOfEpisodes - 1)
    }
    
    func startUpdating() {
        guard let currentId = id else {return}
        guard let duration = allEps?.items?[currentId].duration else {return}
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] _ in
            let currentTime = self.second()
            if duration == Int(currentTime) {
                if self.isRepeatActive {
                    self.playAudio()
                    self.delegatePlayer?.updateView()
                    self.delegateMiniPlayer?.updateMiniPlayer()
                } else {
                    self.nextSong()
                    self.delegatePlayer?.updateView()
                    self.delegateMiniPlayer?.updateMiniPlayer()
                }
            }
        }
    }
    
    func stopUpdating() {
        timer?.invalidate()
        timer = nil
    }
}

