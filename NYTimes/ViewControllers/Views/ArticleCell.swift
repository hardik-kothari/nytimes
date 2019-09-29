//
//  ArticleCell.swift
//  NYTimes
//
//  Created by Hardik Kothari on 30/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleCell: UITableViewCell {
    
    static let identifier = "ArticleCell"
    
    // MARK: - UI Controls
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: Font.medium, size: Font.Size.medium.rawValue)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: Font.regular, size: Font.Size.extraSmall.rawValue)
        label.numberOfLines = 0
        return label
    }()
    
     private lazy var articleImage: UIImageView = {
         let imageView = UIImageView()
         imageView.contentMode = .scaleAspectFit
         imageView.clipsToBounds = true
         return imageView
     }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    // MARK: - Configuration
    private func configureView() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(articleImage)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(authorLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            articleImage.widthAnchor.constraint(equalToConstant: 75.0),
            articleImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Padding.Margin.small.rawValue),
            articleImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Padding.Margin.small.rawValue),
            articleImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Padding.Margin.small.rawValue),

            titleLabel.topAnchor.constraint(equalTo: articleImage.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: articleImage.trailingAnchor, constant: Padding.Margin.small.rawValue),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Padding.Margin.small.rawValue),

            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Padding.Margin.extraSmall.rawValue / 2.0),
            authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        ])
        let heightConstraint = articleImage.heightAnchor.constraint(equalToConstant: 75.0)
        heightConstraint.priority = UILayoutPriority(750)
        heightConstraint.isActive = true
    }
    
    func configure(_ viewModel: ArticleDetailViewModel) {
        titleLabel.text = viewModel.title
        authorLabel.text = viewModel.author
        guard let urlString = viewModel.thumbImage?.url, let imageURL = URL(string: urlString) else {
            return
        }
        articleImage.kf.indicatorType = .activity
        articleImage.kf.setImage(with: imageURL)
    }
}
