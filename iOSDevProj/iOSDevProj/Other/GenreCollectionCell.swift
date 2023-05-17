//
//  CategoryCollectionCell.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 5/11/23.
//

import UIKit
import SDWebImage

class CategoryCollectionCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionCell"
    
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
        genreImageView.image = UIImage(systemName: "music.note.list", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        genreLabel.frame = CGRect(x: 10, y: contentView.height / 2, width: contentView.width - 20, height: contentView.height / 2)
        genreImageView.frame = CGRect(x: contentView.width / 2, y: 10, width: contentView.width / 2, height: contentView.height / 2)
    }
    
    func configure(with viewModel: CategoryViewModel) {
        genreLabel.text = viewModel.title
        genreImageView.sd_setImage(with: viewModel.albumCover, completed: nil)
        contentView.backgroundColor = colors.randomElement()
    }
}
