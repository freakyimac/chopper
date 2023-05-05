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
    private var outputVolumeObserve: NSKeyValueObservation?
    var currentVolume: Float { AVAudioSession.sharedInstance().outputVolume }
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
        } else {
            player.pause()
        }
    }
    
    func setVolume(_ value: Float) {
        player.volume = value
        MPVolumeView.setVolume(value)
    }

    private func listenVolumeButton() {
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("AVAudioSession set active fail")
        }
        outputVolumeObserve = AVAudioSession.sharedInstance().observe(\.outputVolume) { [weak self] (audioSession, changes) in
            self?.player.volume = audioSession.outputVolume
            self?.delegate?.deviceVolumeButttonTapped()
        }
    }
}
