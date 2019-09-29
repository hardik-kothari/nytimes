//
//  ArticleDetailViewController.swift
//  NYTimes
//
//  Created by Hardik Kothari on 30/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import UIKit
import SafariServices

class ArticleDetailViewController: UIViewController {
    
    // MARK: - Private properties
    private var viewModel: ArticleDetailViewModel
    
    // MARK: - UI Controls
    private lazy var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollview.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollview.widthAnchor, multiplier: 1.0),
            contentView.topAnchor.constraint(equalTo: scrollview.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor)
        ])
        return scrollview
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(articleImage)
        
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(captionLabel)
        
        publishedLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(publishedLabel)
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(authorLabel)
        
        abstractLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(abstractLabel)
        
        seeMoreButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(seeMoreButton)

        NSLayoutConstraint.activate([
            articleImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            articleImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            articleImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            captionLabel.topAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: Padding.Margin.small.rawValue),
            captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Padding.Margin.small.rawValue),
            captionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Padding.Margin.small.rawValue),
            
            publishedLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: Padding.Margin.extraSmall.rawValue),
            publishedLabel.leadingAnchor.constraint(equalTo: captionLabel.leadingAnchor),
            publishedLabel.trailingAnchor.constraint(equalTo: captionLabel.trailingAnchor),
            
            authorLabel.topAnchor.constraint(equalTo: publishedLabel.bottomAnchor, constant: Padding.Margin.extraSmall.rawValue),
            authorLabel.leadingAnchor.constraint(equalTo: captionLabel.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: captionLabel.trailingAnchor),
            
            abstractLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: Padding.Margin.small.rawValue),
            abstractLabel.leadingAnchor.constraint(equalTo: captionLabel.leadingAnchor),
            abstractLabel.trailingAnchor.constraint(equalTo: captionLabel.trailingAnchor),
            
            seeMoreButton.heightAnchor.constraint(equalToConstant: 48.0),
            seeMoreButton.widthAnchor.constraint(equalToConstant: 320.0),
            seeMoreButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            seeMoreButton.topAnchor.constraint(equalTo: abstractLabel.bottomAnchor, constant: Padding.Margin.regular.rawValue),
            seeMoreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Padding.Margin.regular.rawValue)
        ])
        return contentView
    }()
    
    private lazy var articleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: Font.bold, size: Font.Size.regular.rawValue)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var publishedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: Font.regular, size: Font.Size.extraSmall.rawValue)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: Font.regular, size: Font.Size.small.rawValue)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var abstractLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: Font.regular, size: Font.Size.medium.rawValue)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var seeMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("SEE MORE", for: .normal)
        button.titleLabel?.font = UIFont(name: Font.medium, size: Font.Size.medium.rawValue)
        button.setTitleColor(.systemBackground, for: .normal)
        button.backgroundColor = .systemTeal
        button.layer.cornerRadius = 24.0
        button.addTarget(self, action: #selector(showFullArticle), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initialization
    init(_ viewModel: ArticleDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        showArticleInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
    }

    private func configureView() {
        view.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Data methods
    private func showArticleInfo() {
        title = viewModel.title
        guard let largeImage = viewModel.largeImage,
            let urlString = largeImage.url,
            let imageSize = largeImage.imageSize,
            let imageURL = URL(string: urlString) else {
            return
        }
        let height = UIScreen.main.bounds.width * imageSize.height / imageSize.width
        articleImage.heightAnchor.constraint(equalToConstant: height).isActive = true
        articleImage.kf.indicatorType = .activity
        articleImage.kf.setImage(with: imageURL)
        
        captionLabel.text = viewModel.title
        publishedLabel.text = viewModel.publishedOn
        authorLabel.text = viewModel.author
        abstractLabel.text = viewModel.abstract
    }
    
    // MARK: - Action methods
    @objc private func showFullArticle() {
        guard let articleLink = viewModel.articleLink, let url = URL(string: articleLink) else {
             return
         }
         let safariVC = SFSafariViewController(url: url)
         present(safariVC, animated: true, completion: nil)
    }
}
