//
//  PlayerViewController.swift
//  Chopper
//
//  Created by 김동현 on 2023/04/24.
//

import UIKit
import AVFoundation

final class PlayerViewController: UIViewController, PlayerManagerDelegate {

    // MARK: - Views
    private lazy var imageViewRoot: UIView = {
        let imageView = UIImageView(image: UIImage(named: "blur_test_image"))
        imageView.contentMode = .scaleAspectFill
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = self.view.frame
        imageView.addSubview(visualEffectView)
        return imageView
    }()
    
    private let containerViewArtwork: UIView = {
        let view = UIView()
        return view
    }()
    
    private let imageViewArtwrok: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "blur_test_image"))
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let labelTitle: UILabel = {
        let label = UILabel()
        label.text = "labelTitlelabelTitlelabelTitlelabelTitlelabelTitle"
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .white
        return label
    }()
    
    private let labelSubTitle: UILabel = {
        let label = UILabel()
        label.text = "labelSubTitlelabelSubTitlelabelSubTitlelabelSubTitlelabelSubTitle"
        label.font = .systemFont(ofSize: 19)
        label.textColor = .lightText
        return label
    }()
    
    private let containerViewSliderProgress: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var sliderProgress: UISlider = {
        let slider = UISlider()
        slider.addTarget(self, action: #selector(progressChange(sender:event:)), for: .valueChanged)
        return slider
    }()
    
    private let labelCurrentTime: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .lightText
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private let labelTotalTime: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .lightText
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private let containerViewControlButtons: UIView = {
        let view = UIView()
        return view
    }()
    
    private let buttonPrev: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "button_prev_track")?.withTintColor(.white), for: .normal)
        return button
    }()
    
    private lazy var buttonPlayPause: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "button_play_track")?.withTintColor(.white), for: .normal)
        button.setImage(UIImage(named: "button_pause_track")?.withTintColor(.white), for: .selected)
        button.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        return button
    }()
    
    private let buttonNext: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "button_next_track")?.withTintColor(.white), for: .normal)
        return button
    }()
    
    private let containerViewSliderVolume: UIView = {
        let view = UIView()
        return view
    }()
    
    private let imageViewMinVolume: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "button_volume_min")?.withTintColor(.lightText)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let imageViewMaxVolume: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "button_volume_max")?.withTintColor(.lightText)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var sliderVolume: UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(), for: .normal)
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = PlayerManager.shared.currentVolume
        slider.addTarget(self, action: #selector(volumeChange(sender:event:)), for: .valueChanged)
        return slider
    }()
    
    private lazy var stackViewControlPlate: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.addArrangedSubview(containerViewSliderProgress)
        stackView.addArrangedSubview(containerViewControlButtons)
        stackView.addArrangedSubview(containerViewSliderVolume)
        return stackView
    }()
    
    // MARK: - Properties
    private let viewModel = PlayerViewModel()
    private let commonPaddingHorizontal: CGFloat = 15
    private let commonPaddingArtwork: CGFloat = 30
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        PlayerManager.shared.delegate = self
        // MARK: - TEST
        let tmpUrl = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3"
        PlayerManager.shared.setPlayerItem(url: tmpUrl)
    }

    // MARK: - Functions
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(imageViewRoot)
        imageViewRoot.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.addSubview(containerViewArtwork)
        containerViewArtwork.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            make.leading.trailing.equalToSuperview().inset(commonPaddingHorizontal)
            make.width.height.equalTo(view.frame.width - (commonPaddingHorizontal * 2))
        }
        containerViewArtwork.addSubview(imageViewArtwrok)
        imageViewArtwrok.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(commonPaddingArtwork)
        }
        view.addSubview(labelTitle)
        view.addSubview(labelSubTitle)
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(containerViewArtwork.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(commonPaddingHorizontal)
            make.height.equalTo(30)
        }
        labelSubTitle.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(commonPaddingHorizontal)
            make.height.equalTo(30)
        }
        containerViewSliderProgress.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        containerViewSliderProgress.addSubview(sliderProgress)
        containerViewSliderProgress.addSubview(labelCurrentTime)
        containerViewSliderProgress.addSubview(labelTotalTime)
        sliderProgress.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(2)
        }
        labelCurrentTime.snp.makeConstraints { make in
            make.top.equalTo(sliderProgress.snp.bottom)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(18)
        }
        labelTotalTime.snp.makeConstraints { make in
            make.top.equalTo(sliderProgress.snp.bottom)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(18)
        }
        containerViewControlButtons.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(50)
        }
        containerViewControlButtons.addSubview(buttonPlayPause)
        containerViewControlButtons.addSubview(buttonPrev)
        containerViewControlButtons.addSubview(buttonNext)
        buttonPrev.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(commonPaddingHorizontal)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        buttonPlayPause.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        buttonNext.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(commonPaddingHorizontal)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        view.addSubview(stackViewControlPlate)
        stackViewControlPlate.snp.makeConstraints { make in
            make.top.equalTo(labelSubTitle.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(commonPaddingHorizontal)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        containerViewSliderVolume.addSubview(sliderVolume)
        containerViewSliderVolume.addSubview(imageViewMinVolume)
        containerViewSliderVolume.addSubview(imageViewMaxVolume)
        imageViewMinVolume.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        imageViewMaxVolume.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        sliderVolume.snp.makeConstraints { make in
            make.leading.equalTo(imageViewMinVolume.snp.trailing).offset(10)
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(imageViewMaxVolume.snp.leading).offset(-10)
        }
        containerViewSliderVolume.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
}

// MARK: - Play
extension PlayerViewController {
    @objc private func didTapPlayPauseButton() {
        PlayerManager.shared.playOrPause()
        viewModel.isPlaying.toggle()
        buttonPlayPause.isSelected = viewModel.isPlaying
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: []) {
            self.imageViewArtwrok.snp.updateConstraints { make in
                make.edges.equalToSuperview().inset(self.viewModel.isPlaying ? 0 : self.commonPaddingArtwork)
            }
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - Volume
extension PlayerViewController {
    func deviceVolumeButttonTapped() {
        sliderVolume.setValue(PlayerManager.shared.currentVolume, animated: true)
    }
    
    @objc private func volumeChange(sender: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                PlayerManager.shared.isSliderVolumeMoving = true
            case .moved:
                PlayerManager.shared.setVolume(sender.value)
            default:
                PlayerManager.shared.isSliderVolumeMoving = false
            }
        }
    }
    
    @objc private func progressChange(sender: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                PlayerManager.shared.isSliderProgressMoving = true
            case .moved:
                labelCurrentTime.text = viewModel.convertTimeToString(PlayerManager.shared.currentItemDuration * Float64(sender.value))
            case .ended:
                PlayerManager.shared.seekWithSlider(value: sender.value) { success in
                    PlayerManager.shared.isSliderProgressMoving = false
                }
            default:
                PlayerManager.shared.isSliderProgressMoving = false
            }
        }
    }
}

// MARK: - Time
extension PlayerViewController {
    func playerTimeDidChange(percentage: Float64) {
        guard !PlayerManager.shared.isSliderProgressMoving else {
            return
        }
        sliderProgress.value = Float(percentage)
        labelCurrentTime.text = viewModel.currentItemTimeStr
        labelTotalTime.text = viewModel.currentItemDurationStr
    }
}
