//
//  ShowCell.swift
//  TwitterLikeButton
//
//  Created by 刘剑文 on 16/3/21.
//  Copyright © 2016年 kevinil. All rights reserved.
//

import UIKit
import KevinButton

class ShowCell: UITableViewCell, LikeButtonDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
        let iv = LikeButton(frame: CGRectMake(20, 20, 20, 20))
        iv.delegate = self
        self.contentView.addSubview(iv)
    }
    
    func didSelectedLikeButton(likeButton: LikeButton) {
        print("selected")
    }
    
    func didDeSelectedLikeButton(likeButton: LikeButton) {
        print("deSelected")
    }

}
