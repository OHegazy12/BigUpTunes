//
//  RecommendedTrackCell.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 5/6/23.
//

import UIKit

class RecommendedTrackCell: UICollectionViewCell {
    static let identifier = "RecommendedTrackCell"
    
    private let trackCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
       let label = UILabel()
       label.numberOfLines = 0
       label.font = .systemFont(ofSize: 18, weight: .regular)
       return label
    }()
    
    private let artistNameLabel: UILabel = {
       let label = UILabel()
       label.numberOfLines = 0
       label.font = .systemFont(ofSize: 15, weight: .light)
       return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(trackCoverImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        trackCoverImageView.frame = CGRect(x: 5, y: 2, width: contentView.height - 4, height: contentView.height - 4)
        trackNameLabel.frame = CGRect(x: trackCoverImageView.right + 10, y: 0, width: contentView.width - trackCoverImageView.right - 15, height: contentView.height / 2)
        artistNameLabel.frame = CGRect(x: trackCoverImageView.right + 10, y: contentView.height / 2, width: contentView.width - trackCoverImageView.right - 15, height: contentView.height / 2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        trackCoverImageView.image = nil
    }
    
    func configure(with viewModel: RecommendedTracksCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistname
        trackCoverImageView.sd_setImage(with: viewModel.albumCover, completed: nil)
    }
}
