//
//  ExampleTableViewCell.swift
//  Swifty
//
//  Created by AndrewTremblay on 6/3/14.
//  Copyright (c) 2014 andrewTremblayLLC. All rights reserved.
//

import UIKit

class ExampleTableViewCell : UITableViewCell {
    @IBOutlet var titleLabel: UILabel
    @IBOutlet var detailLabel: UILabel
    
    init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel = self.viewWithTag(1) as UILabel
        detailLabel = self.viewWithTag(2) as UILabel
    }
    
}