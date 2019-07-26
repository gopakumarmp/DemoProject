//
//  FilmColorInfoCell.swift
//  Gareware
//
//  Created by Gopakumar MP on 7/25/19.
//  Copyright © 2019 Gopakumar MP. All rights reserved.
//

import UIKit

class FilmColorInfoCell:UITableViewCell {
    @IBOutlet weak var colorView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func setupInfo(title:String, hxColor:String) {
        self.title.text = title
        self.colorView.backgroundColor = UIColor(hex: hxColor)
    }
}
