//
//  ExampleTableViewCell.swift
//  Swifty
//
//  Created by AndrewTremblay on 6/3/14.
//  Copyright (c) 2014 andrewTremblayLLC. All rights reserved.
//

import UIKit

class ExampleTableViewCell : UITableViewCell {
    @IBOutlet var titleLabel : UILabel
    @IBOutlet var detailLabel: UILabel
    
    init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    
    func setTitle(newTitle: String!) {
           titleLabel.text = newTitle
    }
}

