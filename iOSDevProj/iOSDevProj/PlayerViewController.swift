//
//  PlayerViewController.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 4/22/23.
//
import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    public var position: Int = 0
    public var tracks: [Track] = []
    
    var holderView: UIView!
    
    var player: AVAudioPlayer?
    
    private let albumImageView: UIImageView =
    {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let trackNameLabel: UILabel =
    {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let artistNameLabel: UILabel =
    {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        if holderView == nil
        {
            holderView = UIView(frame: CGRect(x: 40, y: 40, width: view.frame.size.width - 40, height: view.frame.size.width + 250))
            holderView.center = view.center
            holderView.backgroundColor = .spotifyGreen
            view.addSubview(holderView)
        }
        if holderView.subviews.count == 0
        {
            configure()
        }
    }
    
    let playPauseButton = UIButton()
    let nextButton = UIButton()
    let backButton = UIButton()
    
    func configure()
    {
        let track = tracks[position]
        
        let urlString = Bundle.main.path(forResource: track.trackName, ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else
            {
                print("URLString does not exist")
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            
            guard let player = player else
            {
                print("Player does not exist")
                return
            }
            
            player.volume = 0.5
            player.play()
        }
        catch
        {
            print("Error: \(error.localizedDescription)")
        }
        
        
        albumImageView.frame = CGRect(x: 10, y: 10, width: holderView.frame.size.width - 20, height: holderView.frame.size.width - 20)
        albumImageView.image = UIImage(named: track.imageName)
        holderView.addSubview(albumImageView)
        
        holderView.addSubview(trackNameLabel)
        holderView.addSubview(artistNameLabel)
        
        trackNameLabel.frame = CGRect(x: 10, y: albumImageView.frame.size.height + 10, width: holderView.frame.size.width - 20, height: 70)
        artistNameLabel.frame = CGRect(x: 10, y: albumImageView.frame.size.height + 10 + 40, width: holderView.frame.size.width - 20, height: 70)
        
        trackNameLabel.text = track.title
        artistNameLabel.text = track.artist
        
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        
        let yPosition = artistNameLabel.frame.origin.y + 70 + 20
        let size: CGFloat = 80
        
        playPauseButton.frame = CGRect(x: (holderView.frame.size.width) / 2.5, y: yPosition, width: size, height: size)
        nextButton.frame = CGRect(x: holderView.frame.size.width - size - 20, y: yPosition, width: size, height: size)
        backButton.frame = CGRect(x: 20, y: yPosition, width: size, height: size)
        
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        playPauseButton.tintColor = .black
        backButton.tintColor = .black
        nextButton.tintColor = .black
        
        holderView.addSubview(playPauseButton)
        holderView.addSubview(nextButton)
        holderView.addSubview(backButton)
        
        let slider = UISlider(frame: CGRect(x: 20, y: holderView.frame.size.height - 60, width: holderView.frame.size.width - 40, height: 50))
        slider.value = 0.5
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        holderView.addSubview(slider)
    }
    
    @objc func didTapBackButton()
    {
        if position > 0
        {
            position -= 1
            player?.stop()
            for subview in holderView.subviews
            {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    @objc func didTapPlayPauseButton()
    {
        if player?.isPlaying == true
        {
            player?.pause()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        else
        {
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    
    @objc func didTapNextButton()
    {
        if position < (tracks.count - 1)
        {
            position += 1
            player?.stop()
            for subview in holderView.subviews
            {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    @objc func didSlideSlider(_ slider: UISlider)
    {
        let value = slider.value
        player?.volume = value
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        if let player  = player
        {
            player.stop()
        }
    }
}
