//
//  DetailViewController.swift
//  Gareware
//
//  Created by Gopakumar MP on 2/25/19.
//  Copyright © 2019 Gopakumar MP. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var filmInfoView: UIView!
    @IBOutlet var tableView: UITableView!
    var data:[CellInfo] = [CellInfo]()
    @IBOutlet weak var colorPreviewView: UIImageView!
    var overLayView:FilmInfoOverlayView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "FilmColorInfoCell", bundle: nil), forCellReuseIdentifier: "FilmColorInfoCellID")
        self.tableView.register(UINib(nibName: "ExpandableSectionHeaderCell", bundle: nil), forCellReuseIdentifier: "ExpandableSectionHeaderCellID")

        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        self.data = self.prpareData()
        self.imageView.backgroundColor = bgColor(self.view, title: "archbg1")
        self.tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var frame = self.imageView.bounds
        frame.origin.x = self.imageView.bounds.origin.x + 170
        frame.origin.y = self.imageView.bounds.origin.y + 10
        frame.size.width = self.imageView.bounds.width - 200
        frame.size.height = self.imageView.bounds.height - 10

        self.overLayView = FilmInfoOverlayView.createView()
        self.overLayView.frame = frame
        self.imageView.addSubview(self.overLayView)
        //self.overLayView.leftAnchor.constraint(lessThanOrEqualTo: self.imageView.leftAnchor, constant: 10)
        //self.overLayView.rightAnchor.constraint(lessThanOrEqualTo: self.imageView.rightAnchor, constant: 10)
        //self.overLayView.topAnchor.constraint(lessThanOrEqualTo: self.imageView.topAnchor, constant: 10)
        //self.overLayView.bottomAnchor.constraint(lessThanOrEqualTo: self.imageView.bottomAnchor, constant: -100)
    }
    
    func prpareData() -> [CellInfo] {
        var modelData = [SolarControlFilmMainCategory]()
        var infoList = [CellInfo]()
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        
        if let documentPath = paths.first {
            let filePath = NSMutableString(string: documentPath).appendingPathComponent(kFilmDetailsFileName).appending("txt")
            if let dictionary = NSMutableDictionary(contentsOfFile: filePath ) as? [String:AnyObject] {
                modelData = DataExtractor.extractSolarControlFilData(source: dictionary)
            } else {
                Services().fetchFilmDetails(completionHandler: { (error) in
                    let filePath = NSMutableString(string: documentPath).appendingPathComponent(kFilmDetailsFileName).appending("txt")
                    if let dictionary = NSMutableDictionary(contentsOfFile: filePath ) as? [String:AnyObject] {
                        modelData = DataExtractor.extractSolarControlFilData(source: dictionary)
                    }
                })
            }
        }
        
        if modelData.count > 0 {
            infoList = modelData[1].displayInfo() ?? [CellInfo]()
        }
        return infoList
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count - 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let section  = self.data[section]
        if section.isExpanded == true {
            return section.subsectionData.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.data[indexPath.section]
        
        if indexPath.row == 0 {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "ExpandableSectionHeaderCellID") as! ExpandableSectionHeaderCell
            cell.title.text = section.title
            return cell
        } else if section.isExpanded == true {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "FilmColorInfoCellID") as! FilmColorInfoCell
            cell.setupInfo(title: section.subsectionData[indexPath.row].title(), hxColor: section.subsectionData[indexPath.row].color())
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            if self.data[indexPath.section].isExpanded {
                self.data[indexPath.section].isExpanded = false
                self.tableView.reloadSections([indexPath.section], with: .automatic)
            } else {
                self.data[indexPath.section].isExpanded = true
                self.tableView.reloadSections([indexPath.section], with: .automatic)
            }
        } else {
            
        }
    }
}

extension DetailViewController {
    
    func showInfoView(hxColor:String ) {
        self.filmInfoView.isHidden = false
        self.colorPreviewView.backgroundColor = UIColor(hex: hxColor)
    }
    
    func hideInfoView() {
        self.filmInfoView.isHidden = true
    }
    
}
