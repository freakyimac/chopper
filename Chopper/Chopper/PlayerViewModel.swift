//
//  PlayerViewModel.swift
//  Chopper
//
//  Created by 김동현 on 2023/04/27.
//

import Foundation
import AVFoundation

final class PlayerViewModel {
    
    var isPlaying: Bool = false
    
    var currentItemTimeStr: String {
        return convertTimeToString(CMTimeGetSeconds(PlayerManager.shared.currentTime))
    }
    
    var currentItemDurationStr: String {
        return convertTimeToString(PlayerManager.shared.currentItemDuration)
    }
    
    func convertTimeToString(_ time: Float64) -> String {
        let totalSeconds = Int(time)
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let timeFormatString  = String(format: "%02d:%02d", minutes, seconds)
        return timeFormatString
    }
}
