//
//  YoutubeCell.swift
//  uicollectionview
//
//  Created by Tushar Tapadia on 11/08/20.
//  Copyright © 2020 Tushar Tapadia. All rights reserved.
//

import Foundation
import UIKit
class YoutubeCell: UICollectionViewCell{
    
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
           
        setupLayout()
    }
    
    fileprivate func setupLayout(){
        let darkBlur = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.layer.cornerRadius = 10
        addSubview(imageView)
        addSubview(nameLabel)
        _ = imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 85)
        _ = nameLabel.anchor(top: imageView.bottomAnchor, left: imageView.leftAnchor, bottom: bottomAnchor, right: imageView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
