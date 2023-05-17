//
//  PlayerPresenter.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 5/12/23.
//

import UIKit
import AVFoundation

protocol PlayerDataSource: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get }
    var imageURL: URL? { get }
}

final class PlayerPresenter {
    
    var playerVC: PlayerViewController?
    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?
    
    static let shared = PlayerPresenter()
    
    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    
    var index = 0
    
    var currentTrack: AudioTrack? {
        if let track = track, tracks.isEmpty {
            return track
        }
        else if let player = self.playerQueue, !tracks.isEmpty {
            return tracks[index]
        }
        
        return nil
    }
    
     func startPlayer(from viewController: UIViewController, track: AudioTrack) {
         
         guard let url = URL(string: track.preview_url ?? "") else {
             return
         }
         
        player = AVPlayer(url: url)
        player?.volume = 0.5
         
        self.track = track
        self.tracks = []
        let playerVC = PlayerViewController()
        playerVC.title = track.name
        playerVC.dataSource = self
        playerVC.delegate = self
        viewController.present(UINavigationController(rootViewController: playerVC), animated: true) { [weak self] in
            self?.player?.play()
        }
         self.playerVC = playerVC
    }
    
     func startPlayer(from viewController: UIViewController, tracks: [AudioTrack]) {
        self.tracks = tracks
        self.track = nil
         
         
         let items: [AVPlayerItem] = tracks.compactMap({
             guard let url = URL(string: $0.preview_url ?? "") else {
                 return nil
             }
             
             return AVPlayerItem(url: url)
         })
         self.playerQueue = AVQueuePlayer(items: items)
         self.playerQueue?.volume = 0.5
         self.playerQueue?.play()
         
        let playerVC = PlayerViewController()
        playerVC.dataSource = self
        playerVC.delegate = self
        viewController.present(UINavigationController(rootViewController: playerVC), animated: true, completion: nil)
        self.playerVC = playerVC

    }
}

extension PlayerPresenter: PlayerDataSource, PlayerViewControllerDelegate {
    func didSlideSlider(_ value: Float) {
        player?.volume = value
    }
    
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused {
                player.play()
            }
        }
        else if let player = playerQueue {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused {
                player.play()
            }
        }
    }
    
    func didTapForward() {
        if tracks.isEmpty {
            player?.pause()
        }
        else if let player = playerQueue {
            player.advanceToNextItem()
            index += 1
            print(index)
            playerVC?.refreshUI()
        }
    }
    
    func didTapBackwards() {
        if tracks.isEmpty {
            player?.seek(to: CMTime.zero)
            player?.play()
        } else if let player = playerQueue {
            if index > 0 {
                index -= 1
                player.pause()
                player.seek(to: CMTime.zero)
                player.insert(player.currentItem!, after: nil)
                player.advanceToNextItem()
                playerVC?.refreshUI()
                player.play()
            } else {
                player.seek(to: CMTime.zero)
                player.play()
            }
        }
    }


    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        print(currentTrack?.album?.images.first)
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
}
