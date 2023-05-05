//
//  extension_MPVolumeView.swift
//  Chopper
//
//  Created by 김동현 on 2023/05/05.
//

import Foundation
import MediaPlayer

extension MPVolumeView {
    static func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
        DispatchQueue.main.async {
            slider?.value = volume
        }
    }
}
