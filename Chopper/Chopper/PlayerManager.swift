//
//  PlayerManager.swift
//  Chopper
//
//  Created by 김동현 on 2023/05/05.
//

import Foundation
import AVFoundation
import MediaPlayer

protocol PlayerManagerDelegate: AnyObject {
    func deviceVolumeButttonTapped()
    func playerTimeDidChange(percentage: Float64)
}

final class PlayerManager {
    
    // MARK: - Properties
    static let shared = PlayerManager()
    private let commonTimeOneSeconds = CMTimeMake(value: 1, timescale: 1)
    private let player = AVPlayer()
    private let audioSession = AVAudioSession.sharedInstance()
    private var outputVolumeObserve: NSKeyValueObservation?
    private var timeObserver: Any?
    var currentVolume: Float { audioSession.outputVolume }
    var currentItemDuration: Float64 {
        CMTimeGetSeconds(
            player.currentItem?.duration ?? commonTimeOneSeconds
        )
    }
    var currentTime: CMTime {
        return player.currentTime()
    }
    var isSliderVolumeMoving: Bool = false
    var isSliderProgressMoving: Bool = false
    weak var delegate: PlayerManagerDelegate?
    
    private init() {
        listenVolumeButton()
    }
    
    // MARK: - Functions
    func setPlayerItem(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        player.volume = currentVolume
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
    }
    
    func playOrPause() {
        if player.timeControlStatus == .paused {
            player.play()
            startTimeObserve()
        } else {
            player.pause()
            removeTimeObserve()
        }
    }
    
    func setVolume(_ value: Float) {
        player.volume = value
        MPVolumeView.setVolume(value)
    }
    
    func seekWithSlider(value sliderPosition: Float, completion: @escaping (Bool) -> ()) {
        guard !currentItemDuration.isNaN else {
            completion(false)
            return
        }
        let value = Float64(sliderPosition) * currentItemDuration
        let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
        player.seek(to: seekTime) { success in
            completion(success)
        }
    }

    private func listenVolumeButton() {
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback)
            try audioSession.setActive(true)
        } catch {
            print("AVAudioSession set active fail")
        }
        outputVolumeObserve = audioSession.observe(\.outputVolume) { [weak self] (audioSession, changes) in
            guard let self = self, !self.isSliderVolumeMoving else {
                return
            }
            self.player.volume = audioSession.outputVolume
            self.delegate?.deviceVolumeButttonTapped()
        }
    }
    
    private func startTimeObserve() {
        self.timeObserver = player.addPeriodicTimeObserver(forInterval: commonTimeOneSeconds, queue: .main) { [weak self] time in
            guard let self else {
                return
            }
            let current = CMTimeGetSeconds(time)
            let percentage = current / self.currentItemDuration
            self.delegate?.playerTimeDidChange(percentage: percentage)
        }
    }
    
    private func removeTimeObserve() {
        if let observer = self.timeObserver {
            self.player.removeTimeObserver(observer)
            self.timeObserver = nil
        }
    }
}
