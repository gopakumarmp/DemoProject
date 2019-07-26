//
//  FilmInfoOverlayView.swift
//  Gareware
//
//  Created by Gopakumar MP on 7/25/19.
//  Copyright © 2019 Gopakumar MP. All rights reserved.
//

import UIKit

class FilmInfoOverlayView: UIView,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var filmColorView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var displayData = [[String:String]] ()
    
    
    static func createView() -> FilmInfoOverlayView? {
        let nib = UINib(nibName: "FilmInfoOverlayView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? FilmInfoOverlayView
    }
    
    func setFilmColor(hexColorValue: String) {
        self.filmColorView.backgroundColor = UIColor(hex: hexColorValue)
    }
    
    func setFilmMetaInfo(values:[String:String]) {
        self.displayData.append(["Thickness": "2.1"])
        self.displayData.append(["Light Transmittance": "0.4%"])
        self.displayData.append(["UV transmittance": "<4%"])

        self.tableView.reloadData()
    }
    
    func setFilmOverlayViewHidden() {
        self.isHidden = true
    }
    func showFilmOverlayViewHidden() {
        self.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayData.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = self.displayData[indexPath.row]
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = data.keys.first
        cell.textLabel?.text = data.values.first
        
        return cell

    }
    

}

