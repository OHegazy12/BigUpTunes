//
//  LibraryView.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 5/14/23.
//

import UIKit

class LibraryView: UIView {
    
    enum State {
        case playlist
        case album
    }
    
    var state: State = .playlist
    
    weak var delegate: LibraryViewDelegate?
    
    private let playlistButton: UIButton = {
        let playlistButton = UIButton()
        playlistButton.setTitleColor(.label, for: .normal)
        playlistButton.setTitle("Playlists", for: .normal)
        return playlistButton
    }()
    
    private let albumsButton: UIButton = {
        let albumsButton = UIButton()
        albumsButton.setTitleColor(.label, for: .normal)
        albumsButton.setTitle("Albums", for: .normal)
        return albumsButton
    }()

    private let indicatorView: UIView = {
        let indicatorView = UIView()
        indicatorView.backgroundColor = .systemMint
        indicatorView.layer.masksToBounds = true
        indicatorView.layer.cornerRadius = 4
        return indicatorView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playlistButton)
        addSubview(albumsButton)
        addSubview(indicatorView)
        
        playlistButton.addTarget(self, action: #selector(didTapPlaylists), for: .touchUpInside)
        albumsButton.addTarget(self, action: #selector(didTapAlbums), for: .touchUpInside)
    }
    
    @objc private func didTapPlaylists() {
        state = .playlist
        
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
        delegate?.libraryViewDidTapPlaylists(self)
    }
    
    @objc private func didTapAlbums() {
        state = .album
        
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
        delegate?.libraryViewDidTapAlbums(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playlistButton.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        albumsButton.frame = CGRect(x: playlistButton.right, y: 0, width: 100, height: 40)
        layoutIndicator()
    }
    
    func layoutIndicator() {
        switch state {
        case .playlist:
            indicatorView.frame = CGRect(x: 0, y: playlistButton.bottom, width: 100, height: 3)
        case .album:
            indicatorView.frame = CGRect(x: 100, y: playlistButton.bottom, width: 100, height: 3)
        }
    }
    
    func update(for state: State) {
        self.state = state
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
    }
}


protocol LibraryViewDelegate: AnyObject {
    func libraryViewDidTapPlaylists(_ libraryView: LibraryView)
    func libraryViewDidTapAlbums(_ libraryView: LibraryView)
}
