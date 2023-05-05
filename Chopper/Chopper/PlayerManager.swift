//
//  PlayerManager.swift
//  Chopper
//
//  Created by 김동현 on 2023/05/05.
//

import Foundation
import AVFoundation

final class PlayerManager {
    
    // MARK: - Properties
    static let shared = PlayerManager()
    private let player = AVPlayer()
    
    // MARK: - Functions
    func setPlayerItem(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
    }
    
    func playOrPause() {
        if player.timeControlStatus == .paused {
            player.play()
        } else {
            player.pause()
        }
    }
}
