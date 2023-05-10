//
//  NewReleaseCell.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 5/6/23.
//

import UIKit
import SDWebImage

class NewReleaseCell: UICollectionViewCell {
    static let identifier = "NewReleaseCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
       let label = UILabel()
       label.numberOfLines = 0
       label.font = .systemFont(ofSize: 20, weight: .semibold)
       return label
    }()
    
    private let numberOfTracksLabel: UILabel = {
       let label = UILabel()
       label.numberOfLines = 0
       label.font = .systemFont(ofSize: 22, weight: .thin)
       return label
    }()
    
    private let artistNameLabel: UILabel = {
       let label = UILabel()
       label.numberOfLines = 0
       label.font = .systemFont(ofSize: 22, weight: .light)
       return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
        contentView.addSubview(numberOfTracksLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.height - 10
        let albumNameLabelSize = albumNameLabel.sizeThatFits(CGSize(width: contentView.width - imageSize - 10, height: contentView.height - 10))
        artistNameLabel.sizeToFit()
        numberOfTracksLabel.sizeToFit()
        
        let albumNameLabelHeight = min(60, albumNameLabelSize.height)
        
        albumCoverImageView.frame = CGRect(x: 5, y: 5, width: imageSize, height: imageSize)
        albumNameLabel.frame = CGRect(x: albumCoverImageView.right + 10 , y: 5, width: albumNameLabelSize.width, height: albumNameLabelHeight)
        artistNameLabel.frame = CGRect(x: albumCoverImageView.right + 10, y: albumNameLabel.bottom, width: contentView.width - albumCoverImageView.right - 10, height: 30)
        numberOfTracksLabel.frame = CGRect(x: albumCoverImageView.right + 10 , y: contentView.bottom - 44, width: numberOfTracksLabel.width, height: 44)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumNameLabel.text = nil
        artistNameLabel.text = nil
        numberOfTracksLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configure(with viewModel: NewReleasesCellViewModel) {
        albumNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistname
        numberOfTracksLabel.text = "Tracks: \(viewModel.number_of_tracks)"
        albumCoverImageView.sd_setImage(with: viewModel.albumCover, completed: nil)
    }
}
