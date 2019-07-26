//
//  RegionView.swift
//  Gareware
//
//  Created by Gopakumar MP on 7/19/19.
//  Copyright © 2019 Gopakumar MP. All rights reserved.
//

import UIKit

class RegionView: UIView {
    @IBOutlet weak var indiaImageView: UIImageView!
    @IBOutlet weak var internationalimageView: UIImageView!
    weak var delegate:MainViewControllerDelegate?
    
    static func createView(frame: CGRect) -> RegionView? {
        let nib = UINib(nibName: "RegionView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? RegionView
    }
    
    @IBAction func IndiaTapped(_ sender: Any) {
        self.delegate?.IndiaRegionSelected()
    }
    
}
