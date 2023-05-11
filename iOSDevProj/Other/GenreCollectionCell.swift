//
//  GenreCollectionCell.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 5/11/23.
//

import UIKit

class GenreCollectionCell: UICollectionViewCell {
    static let identifier = "GenreCollectionCell"
    
    private let genreImageView: UIImageView = {
        let genreImageView = UIImageView()
        genreImageView.contentMode = .scaleAspectFit
        genreImageView.tintColor = .systemBackground
        genreImageView.image = UIImage(systemName: "music.note.list", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        return genreImageView
    }()
    
    private let genreLabel: UILabel = {
        let genreLabel = UILabel()
        genreLabel.textColor = .label
        genreLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        return genreLabel
    }()
    
    private let colors: [UIColor] = [
            .spotifyGreen,
            .systemPink,
            .systemBlue,
            .systemPurple,
            .systemOrange,
            .systemRed,
            .darkGray,
            .systemYellow,
            .systemTeal
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubview(genreLabel)
        contentView.addSubview(genreImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        genreLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        genreLabel.frame = CGRect(x: 10, y: contentView.height / 2, width: contentView.width - 20, height: contentView.height / 2)
        genreImageView.frame = CGRect(x: contentView.width / 2, y: 0, width: contentView.width / 2, height: contentView.height / 2)
    }
    
    func configure(with title: String) {
        genreLabel.text = title
        contentView.backgroundColor = colors.randomElement()
    }
}
