//
//  PlayerView.swift
//  PodcastApp
//
//  Created by Sergey on 06.10.2023.
//

import Foundation
import UIKit
import SnapKit

protocol PlayerViewDelegate: AnyObject {
    
    func button(didButtonTapped button: UIButton)
    func slider(sliderChange slider: UISlider)
    
}

class PlayerViewClass: CustomView {
    
    // MARK: Variables
    weak var delegate: PlayerViewDelegate?
    private var timer: Timer?

    // MARK: - --- UI ---
    
    let episodeCollectionView = EpisodeCollectionView()
    
    // MARK: - - Make labels:
    
    private lazy var episodeTitle = UILabel.makeLabel(font: .manropeExtraBold(size: 16.0), textColor: .purplyGrey)
    private lazy var podcastTitle = UILabel.makeLabel(font: .manropeRegular(size: 16.0), textColor: .purplyGrey)
    private lazy var timePassedLabel = UILabel.makeLabel(font: .manropeRegular(size: 14.0), textColor: .santaGray)
    private lazy var timeLeftLabel = UILabel.makeLabel(font: .manropeRegular(size: 14.0), textColor: .santaGray)
    
    //MARK: - - Make buttons:
    
    private lazy var shuffleButton: UIButton = {
        let button = UIButton(type: .system)
        let iconConfiguration = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "shuffle", withConfiguration: iconConfiguration)
        button.setImage(image, for: .normal)
        button.tintColor = .purplyGrey
        return button
    }()
    
    private lazy var previousTrackButton: UIButton = {
        let button = UIButton()
        let iconConfiguration = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "arrowtriangle.left.fill", withConfiguration: iconConfiguration)
        button.setImage(image, for: .normal)
        button.tintColor = .skyBlue
        return button
    }()
    
    private lazy var nextTrackButton: UIButton = {
        let button = UIButton()
        let iconConfiguration = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "arrowtriangle.right.fill", withConfiguration: iconConfiguration)
        button.setImage(image, for: .normal)
        button.tintColor = .skyBlue
        return button
    }()
    
    private lazy var playTrackButton: UIButton = {
        let button = UIButton()
        let iconConfiguration = UIImage.SymbolConfiguration(pointSize: 64, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "pause.circle.fill", withConfiguration: iconConfiguration)
        button.setImage(image, for: .normal)
        button.tintColor = .skyBlue
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var repeatTrackButton: UIButton = {
        let button = UIButton()
        let iconConfiguration = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "repeat", withConfiguration: iconConfiguration)
        button.setImage(image, for: .normal)
        button.tintColor = .purplyGrey
        return button
    }()
    
    //MARK: - - Make progress bar:
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.thumbTintColor = .skyBlue
        slider.tintColor = .skyBlue
        slider.addTarget(self, action: #selector(audioSliderValueChanged(_:)), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderTouchDown), for: .touchDown)
        return slider
    }()
    
    private lazy var backButton: UIButton = {
         let button = UIButton(type: .system)
         let iconConfiguration = UIImage.SymbolConfiguration(pointSize: 48, weight: .medium, scale: .medium)
         let image = UIImage(systemName: "arrow.backward.circle", withConfiguration: iconConfiguration)
         button.setImage(image, for: .normal)
         button.tintColor = .purplyGrey
         return button
     }()

    
    // MARK: setViews
    
    override func setViews() {
        super.setViews()
        
        shuffleButton.tag = 1
        previousTrackButton.tag = 2
        playTrackButton.tag = 3
        nextTrackButton.tag = 4
        repeatTrackButton.tag = 5
        backButton.tag = 6

        
        shuffleButton.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
        previousTrackButton.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
        playTrackButton.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
        nextTrackButton.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
        repeatTrackButton.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)

        
        episodeTitle.numberOfLines = 0
        episodeTitle.textAlignment = .center
        podcastTitle.numberOfLines = 0
        podcastTitle.textAlignment = .center
        
        addSubview(backButton)
        addSubview(episodeCollectionView)
        addSubview(episodeTitle)
        addSubview(podcastTitle)
        addSubview(timePassedLabel)
        addSubview(slider)
        addSubview(timeLeftLabel)
        addSubview(shuffleButton)
        addSubview(previousTrackButton)
        addSubview(playTrackButton)
        addSubview(nextTrackButton)
        addSubview(repeatTrackButton)
        startUpdatingSlider()
        changePlayStopButton()
        changeShuffleButton()
        changeRepeatTrackButton()
    }
    
    // MARK: layoutViews
    
    override func layoutViews() {
        super.layoutViews()
        
        backButton.snp.makeConstraints { make in
                   make.height.equalTo(48)
                   make.width.equalTo(48)
                   make.top.equalToSuperview().offset(40)
                   make.leading.equalToSuperview().offset(15)
               }

        episodeCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(129)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(330)
        }
        
        episodeTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(episodeCollectionView.snp.bottom).offset(36)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        podcastTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(episodeTitle.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        slider.snp.makeConstraints { make in
            make.width.equalTo(191)
            make.centerX.equalToSuperview()
            make.top.equalTo(podcastTitle.snp.bottom).offset(58.5)
        }
        
        timePassedLabel.snp.makeConstraints { make in
            make.trailing.equalTo(slider.snp.leading).offset(-7)
            make.centerY.equalTo(slider.snp.centerY)
        }
        
        timeLeftLabel.snp.makeConstraints { make in
            make.leading.equalTo(slider.snp.trailing).offset(7)
            make.centerY.equalTo(slider.snp.centerY)
        }
        
        playTrackButton.snp.makeConstraints { make in
            make.height.equalTo(64.0)
            make.width.equalTo(64.0)
            make.width.equalTo(64.0)
            make.centerX.equalToSuperview()
            make.top.equalTo(slider.snp.bottom).offset(88.5)
        }
        
        previousTrackButton.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(16)
            make.centerY.equalTo(playTrackButton.snp.centerY)
            make.trailing.equalTo(playTrackButton.snp.leading).offset(-32)
        }
        
        shuffleButton.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(16)
            make.centerY.equalTo(playTrackButton.snp.centerY)
            make.trailing.equalTo(previousTrackButton.snp.leading).offset(-32)
        }
        
        nextTrackButton.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(16)
            make.centerY.equalTo(playTrackButton.snp.centerY)
            make.leading.equalTo(playTrackButton.snp.trailing).offset(32)
        }
        
        repeatTrackButton.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(16)
            make.centerY.equalTo(playTrackButton.snp.centerY)
            make.leading.equalTo(nextTrackButton.snp.trailing).offset(32)
        }
        
    }
    

      func startUpdatingSlider() {
          timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
              self?.slider.value = AudioService.shared.second()
              self?.timePassedLabel.text = SecondsToTime.secondsToTime(seconds: Int(self?.slider.value ?? 0))
          }
      }

      func stopUpdatingSlider() {
          timer?.invalidate()
          timer = nil
      }
    
    public func changePlayStopButton() {
        let iconConfiguration = UIImage.SymbolConfiguration(pointSize: 64, weight: .medium, scale: .medium)
        let stopImage = UIImage(systemName: "pause.circle.fill", withConfiguration: iconConfiguration)
        let playImage = UIImage(systemName: "play.circle.fill", withConfiguration: iconConfiguration)
        
        if AudioService.shared.isEpsPlaying {
            playTrackButton.setImage(stopImage, for: .normal)
        } else {
            playTrackButton.setImage(playImage, for: .normal)
        }
    }
    
    public func changeShuffleButton() {
        if  AudioService.shared.isShuffleActive {
            shuffleButton.tintColor = .skyBlue
        } else {
            shuffleButton.tintColor = .purplyGrey
        }
    }
    
    public func changeRepeatTrackButton() {
        if   AudioService.shared.isRepeatActive {
            repeatTrackButton.tintColor = .skyBlue
        } else {
            repeatTrackButton.tintColor = .purplyGrey
        }
    }
    }
    


// MARK: Extensions

extension PlayerViewClass {
    
    @objc func didButtonTapped(_ button: UIButton) {
        delegate?.button(didButtonTapped: button)
    }
    
    @objc func audioSliderValueChanged(_ slider: UISlider) {
        delegate?.slider(sliderChange: slider)
        startUpdatingSlider()
    }
    
    @objc func sliderTouchDown() {
        stopUpdatingSlider()
    }
    
    func configureScreen(episodeName: String, podcastName: String, length: Int?) {
        episodeTitle.text = episodeName
        podcastTitle.text = podcastName
        timeLeftLabel.text = SecondsToTime.secondsToTime(seconds: length ?? 0)
        timePassedLabel.text = "00:00:00"
        slider.maximumValue = Float(length ?? 0)
        
    }
    
}
