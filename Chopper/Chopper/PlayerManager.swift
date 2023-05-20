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
}

final class PlayerManager {
    
    // MARK: - Properties
    static let shared = PlayerManager()
    private let player = AVPlayer()
    private let audioSession = AVAudioSession.sharedInstance()
    private var outputVolumeObserve: NSKeyValueObservation?
    private var timeObserver: Any?
    var currentVolume: Float { audioSession.outputVolume }
    var isSliderVolumeMoving: Bool = false
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
        let interval = CMTime(seconds:1.0, preferredTimescale: Int32(NSEC_PER_SEC))
        self.timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            print(time)
        }
    }
    
    private func removeTimeObserve() {
        if let observer = self.timeObserver {
            self.player.removeTimeObserver(observer)
            self.timeObserver = nil
        }
    }
}
