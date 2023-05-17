//
//  SearchResultsSubtitleCell.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 5/12/23.
//

import UIKit
import SDWebImage

class SearchResultsSubtitleCell: UITableViewCell {
    static let identifier = "SearchResultsSubtitleCell"
    
    private let searchResultLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let searchResultSubtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(searchResultLabel)
        contentView.addSubview(searchResultSubtitleLabel)
        contentView.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.height - 10
        let labelHeight = contentView.height / 2
        iconImageView.frame = CGRect(x: 10, y: 5, width: imageSize, height: imageSize)
        searchResultLabel.frame = CGRect(x: iconImageView.right + 10, y: 0, width: contentView.width - iconImageView.right - 15, height: labelHeight)
        searchResultLabel.frame = CGRect(x: iconImageView.right + 10, y: labelHeight, width: contentView.width - iconImageView.right - 15, height: labelHeight)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        searchResultLabel.text = nil
        searchResultSubtitleLabel.text = nil
    }
    
    func configure(with viewModel: SearchResultsSubtitleViewModel) {
        searchResultLabel.text = viewModel.title
        searchResultSubtitleLabel.text = viewModel.subtitle
        iconImageView.sd_setImage(with: viewModel.imageURL, placeholderImage: UIImage(systemName: "photo"),completed: nil)
    }
}
