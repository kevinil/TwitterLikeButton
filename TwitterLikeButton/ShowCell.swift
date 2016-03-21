//
//  ShowCell.swift
//  TwitterLikeButton
//
//  Created by 刘剑文 on 16/3/21.
//  Copyright © 2016年 kevinil. All rights reserved.
//

import UIKit

class ShowCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        let iv = KevinButton(frame: CGRectMake(30, 30, 10, 10))
        iv.initialImage = UIImage(named: "unlike")
        iv.selectedImage = UIImage(named: "like")
        self.contentView.addSubview(iv)
    }

}
