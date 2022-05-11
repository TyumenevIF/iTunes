//
//  DetailAlbumView.swift
//  iTunes_test
//
//  Created by Ilyas Tyumenev on 11.05.2022.
//

import UIKit

class DetailAlbumView: UIView {
    
    private(set) lazy var albumLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private(set) lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Album name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Artist name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Release date"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var trackCountLabel: UILabel = {
        let label = UILabel()
        label.text = "Track count"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.bounces = false
        collectionView.register(SongsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var stackView = UIStackView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(albumLogo)
        stackView = UIStackView(arrangedSubviews: [albumNameLabel,
                                                   artistNameLabel,
                                                   releaseDateLabel,
                                                   trackCountLabel],
                                axis: .vertical,
                                spacing: 5,
                                distribution: .fillProportionally)
        
        addSubview(stackView)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            albumLogo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            albumLogo.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            albumLogo.heightAnchor.constraint(equalToConstant: 100),
            albumLogo.widthAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: albumLogo.trailingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: albumLogo.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
