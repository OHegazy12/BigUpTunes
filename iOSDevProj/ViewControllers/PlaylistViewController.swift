//
//  PlaylistViewController.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 5/10/23.
//

import UIKit

class PlaylistViewController: UIViewController {

    private let playlist: Playlist

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
        // Item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 1, trailing: 2)
        
        // Group
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), subitem: item, count: 1)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        return section
    }))
    
    init(playlist: Playlist) {
        self.playlist = playlist
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var viewModels = [RecommendedTracksCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = playlist.name
        view.addSubview(collectionView)
        collectionView.register(PlaylistHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier)
        collectionView.register(RecommendedTrackCell.self, forCellWithReuseIdentifier: RecommendedTrackCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        
        APICaller.shared.getPlaylistDetails(for: playlist) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.viewModels = model.tracks.items.compactMap({RecommendedTracksCellViewModel(name: $0.track.name, albumCover: URL(string: $0.track.album?.images.first?.url ?? ""), artistname: $0.track.artists.first?.name ?? "-")})
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShareButton))
    }

    @objc private func didTapShareButton() {
        guard let url = URL(string: playlist.external_urls["spotify"] as? String ?? "") else {
            return
        }
        let shareVC = UIActivityViewController(activityItems: [url], applicationActivities: [])
        shareVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(shareVC, animated: true)
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension PlaylistViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedTrackCell.identifier, for: indexPath) as? RecommendedTrackCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier, for: indexPath) as? PlaylistHeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let playlistHeaderViewModel = PlaylistHeaderViewModel(name: playlist.name, ownerName: playlist.owner.display_name, description: playlist.description, headerImage: URL(string: playlist.images.first?.url ?? ""))
        header.configure(with: playlistHeaderViewModel)
        header.delegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = PlayerViewController()
        
    }
}

extension PlaylistViewController: PlaylistHeaderCollectionReusableViewDelegate {
    func playlistHeaderCollectionReusableViewDidPressPlay(_ header: PlaylistHeaderCollectionReusableView) {
        print("Playing playlist!")
    }
}
