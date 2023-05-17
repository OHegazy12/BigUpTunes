//
//  PlayerViewController.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 4/22/23.
//

import UIKit
import AVFoundation
import SDWebImage

// https://youtube.com/playlist?list=PL5PR3UyfTWve9ZC7Yws0x6EGjBO2FGr0o, I implemented a PlayerViewController on my own, parts 18-19 were used to help change it from a hardcoded Player to a dynamic Player (meaning being able to play dynamically fetched tracks instead of hardcoded tracks).

protocol PlayerViewControllerDelegate: AnyObject {
    func didTapPlayPause()
    func didTapForward()
    func didTapBackwards()
    func didSlideSlider(_ value: Float)
}

class PlayerViewController: UIViewController, PlayerControlsViewDelegate {
    
    weak var dataSource: PlayerDataSource?
    weak var delegate: PlayerViewControllerDelegate?
    
    private let albumImageView: UIImageView =
    {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let playerControls = PlayerControllers()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(albumImageView)
        view.addSubview(playerControls)
        playerControls.delegate = self
        configureBarButtons()
        configurePlayerUI()
    }
    
    private func configurePlayerUI() {
        albumImageView.sd_setImage(with: dataSource?.imageURL, completed: nil)
        playerControls.configure(with: PlayerControllerViewModel(title: dataSource?.songName, subtitle: dataSource?.subtitle))
    }
    
    private func configureBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapCloseButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapActionButton))
    }
    
    @objc private func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapActionButton() {
        let shareVC = UIActivityViewController(activityItems: ["Share this track!"], applicationActivities: [])
        shareVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(shareVC, animated: true)
    }
    
    func refreshUI() {
        configurePlayerUI()
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        configure()
    }
    
    private func configure() {
        albumImageView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.width)
        playerControls.frame = CGRect(x: 10, y: albumImageView.bottom + 10, width: view.width - 20, height: CGFloat(view.height - albumImageView.height - view.safeAreaInsets.bottom - 15))
    }

    func didTapPlayPauseButton(_ playercontrollersView: PlayerControllers) {
        delegate?.didTapPlayPause()
    }
    
    func didTapForwardButton(_ playercontrollersView: PlayerControllers) {
        delegate?.didTapForward()
    }
    
    func didTapRewindButton(_ playercontrollersView: PlayerControllers) {
        delegate?.didTapBackwards()
    }
    
    func playerControlsView(_ playercontrollersView: PlayerControllers, didSlideSlider value: Float) {
        delegate?.didSlideSlider(value)
    }
}

protocol PlayerControlsViewDelegate: AnyObject {
    func didTapPlayPauseButton(_ playercontrollersView: PlayerControllers)
    func didTapForwardButton(_ playercontrollersView: PlayerControllers)
    func didTapRewindButton(_ playercontrollersView: PlayerControllers)
    func playerControlsView(_ playercontrollersView: PlayerControllers, didSlideSlider value: Float)
}

final class PlayerControllers: UIView {
    
    weak var delegate: PlayerControlsViewDelegate?
    
    private var isPlaying = true
    
    private let slider: UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        return slider
    }()
    
    private let nameLabel: UILabel =
    {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    private let subtitleLabel: UILabel =
    {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    let rewind: UIButton = {
        let backButton = UIButton()
        backButton.tintColor = .label
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular)), for: .normal)
        return backButton
    }()
    
    let forward: UIButton = {
        let nextButton = UIButton()
        nextButton.tintColor = .label
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular)), for: .normal)
        return nextButton
    }()
    
    let playPause: UIButton = {
       let playPauseButton = UIButton()
        playPauseButton.tintColor = .label
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular)), for: .normal)
        return playPauseButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(slider)
        addSubview(rewind)
        addSubview(playPause)
        addSubview(forward)
        
        rewind.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        playPause.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        forward.addTarget(self, action: #selector(didTapForward), for: .touchUpInside)
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        
        clipsToBounds = true
    }
    
    @objc func didSlideSlider(_ slider: UISlider) {
        let value = slider.value
        delegate?.playerControlsView(self, didSlideSlider: value)
    }
    
    @objc private func didTapBack() {
        delegate?.didTapRewindButton(self)
    }
    
    @objc private func didTapPlayPause() {
        self.isPlaying = !isPlaying
        delegate?.didTapPlayPauseButton(self)
        
        let pause = UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        let play = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        
        playPause.setBackgroundImage(isPlaying ? pause : play, for: .normal)
    }
    
    @objc private func didTapForward() {
        delegate?.didTapForwardButton(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        subtitleLabel.frame = CGRect(x: 0, y: nameLabel.bottom + 10, width: width, height: 50)
        
        slider.frame = CGRect(x: 10, y: subtitleLabel.bottom + 20, width: width - 20, height: 44)
        
        let buttonSize: CGFloat = 60
        playPause.frame = CGRect(x: (width - buttonSize) / 2, y: slider.bottom + 30, width: buttonSize, height: buttonSize)
        rewind.frame = CGRect(x: playPause.left - 80, y: playPause.top, width: buttonSize, height: buttonSize)
        forward.frame = CGRect(x: playPause.right + 20, y: playPause.top, width: buttonSize, height: buttonSize)
    }
    
    func configure(with viewModel: PlayerControllerViewModel) {
        nameLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
}

struct PlayerControllerViewModel {
    let title: String?
    let subtitle: String?
}
