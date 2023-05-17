//
//  HeaderTitleCollectionReusableView.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 5/11/23.
//

import UIKit

class HeaderTitleCollectionReusableView: UICollectionReusableView {
    static let identifier = "HeaderTitleCollectionReusableView"
    
    private let headerlabel: UILabel = {
        let headerlabel = UILabel()
        headerlabel.textColor = .label
        headerlabel.numberOfLines = 1
        headerlabel.font = .systemFont(ofSize: 20, weight: .semibold)
        return headerlabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(headerlabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerlabel.frame =  CGRect(x: 10, y: 0, width: width - 20, height: height)
    }
    
    func configure(with title: String) {
        headerlabel.text = title
    }
}
