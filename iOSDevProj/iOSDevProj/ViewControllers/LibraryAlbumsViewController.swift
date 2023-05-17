//
//  LibraryAlbumsViewController.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 5/14/23.
//

import UIKit

class LibraryAlbumsViewController: UIViewController {

    var albums = [Album]()
    
    private let noAlbumsView = ActionLabelView()
    
    private var albumTableView: UITableView = {
        let albumTableView = UITableView(frame: .zero, style: .grouped)
        albumTableView.register(SearchResultsSubtitleCell.self, forCellReuseIdentifier: SearchResultsSubtitleCell.identifier)
        albumTableView.isHidden = true
        return albumTableView
    }()
    
    private var observer: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        albumTableView.delegate = self
        albumTableView.dataSource = self
        view.addSubview(albumTableView)
        setUpNoAlbumView()
        fetchAlbums()
        observer = NotificationCenter.default.addObserver(forName: .albumSavedNotification, object: nil, queue: .main, using: { [weak self] _ in
            self?.fetchAlbums()
        })
    }
    
    @objc func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    private func fetchAlbums() {
        albums.removeAll()
        APICaller.shared.getCurrentUserAlbums { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let albums):
                    self?.albums = albums
                    self?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func setUpNoAlbumView() {
        view.addSubview(noAlbumsView)
        noAlbumsView.delegate = self
        noAlbumsView.configure(with: ActionLabelViewViewModel(text: "No Saved Albums Found", actionTitle: "Browse"))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noAlbumsView.frame = CGRect(x: (view.width - 150) / 2, y: (view.height - 150) / 2, width: 150, height: 150)
        albumTableView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
    }

    private func updateUI() {
        if albums.isEmpty {
            noAlbumsView.isHidden = false
            albumTableView.isHidden = true
        }
        else {
            noAlbumsView.isHidden = true
            albumTableView.reloadData()
            albumTableView.isHidden = false
        }
    }
}

extension LibraryAlbumsViewController: ActionLabelViewDelegate {
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        tabBarController?.selectedIndex = 0
    }
}

extension LibraryAlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsSubtitleCell.identifier, for: indexPath) as? SearchResultsSubtitleCell else {
            return UITableViewCell()
        }
        let album = albums[indexPath.row]
        cell.configure(with: SearchResultsSubtitleViewModel(title: album.name, subtitle: album.artists.first?.name ?? "-", imageURL: URL(string: album.images.first?.url ?? "")))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let album = albums[indexPath.row]
        
        let AlbumsVC = AlbumViewController(album: album)
        AlbumsVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(AlbumsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
}
