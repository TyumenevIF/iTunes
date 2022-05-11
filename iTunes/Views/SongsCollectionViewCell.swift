//
//  SongsCollectionViewCell.swift
//  iTunes
//
//  Created by Ilyas Tyumenev on 02.05.2022.
//

import UIKit

class SongsCollectionViewCell: UICollectionViewCell {
    
    let nameSongLabel: UILabel = {
        let label = UILabel()
        label.text = "Song name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)        
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    func setupConstraints() {
        self.addSubview(nameSongLabel)
        
        NSLayoutConstraint.activate([
            nameSongLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            nameSongLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            nameSongLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            nameSongLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
