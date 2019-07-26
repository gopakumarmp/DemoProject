//
//  SolarControlFilm.swift
//  Gareware
//
//  Created by Gopakumar MP on 4/21/19.
//  Copyright © 2019 Gopakumar MP. All rights reserved.
//

import Foundation

struct RGBValue {
    private var redValue:Float
    private var greenValue:Float
    private var blueValue:Float
    
    init(r: Float, g: Float, b: Float) {
        redValue = r
        greenValue = g
        blueValue = b
    }
}

struct CellInfo {
    var isExpanded = false
    var title = String()
    var subsectionData = [SolarFilm]()
}

struct VisibilityProperty {
    var name:String?
    var value:String?
}

class SolarControlFilmMainCategory: NSObject {
    private var mainCategoryName:String!
    private var mainCategoryID:String?
    private var subCategoryList = [SolarControlFilmSubCategory]()
    
    init(source:[String:AnyObject]?) {
        if let dict = source {
            self.mainCategoryID = dict["MainCategoryID"] as? String
            self.mainCategoryName = dict["MainCategoryName"] as? String
            if let categories  = dict["SubCategoryList"] as? Array<[String:AnyObject]> {
                for category in categories {
                    let subCategory  = SolarControlFilmSubCategory(source: category)
                    self.subCategoryList.append(subCategory)
                }
            }
        }
    }
    
    func displayTitle() -> String {
        return self.mainCategoryName
    }
    
    func subcategoryList() ->[SolarControlFilmSubCategory] {
        return self.subCategoryList
    }
    
    func displayInfo() -> [CellInfo]? {
        var displayList:[CellInfo]?
        
        guard self.subcategoryList().count > 0 else {
            return displayList
        }
        
        displayList = [CellInfo]()
        
        for subListItem in self.subcategoryList() {
            let info = CellInfo(isExpanded: false, title: subListItem.title(), subsectionData: subListItem.films())
            displayList?.append(info)
        }
        return displayList
    }
}

class SolarControlFilmSubCategory:NSObject {
    private var subCategoryName:String!
    private var subCategoryID:String?
    private var filmList = [SolarFilm]()
    init(source:[String:AnyObject]?) {
        if let dict = source {
            self.subCategoryID = dict["SubCategoryID"] as? String
            self.subCategoryName = dict["SubCategoryName"] as? String
            if let categories  = dict["FilmsList"] as? Array<[String:AnyObject]> {
                for category in categories {
                    let film  = SolarFilm(category)
                    self.filmList.append(film)
                }
            }
        }
    }
    
    func title() -> String {
        var result = ""
        if  let name = self.subCategoryName {
            result = name
        }
        return result
    }
    
    func films() -> [SolarFilm] {
        var result  = [SolarFilm]()
        if self.filmList.count > 0 {
            result = self.filmList
        }
        return result
    }
}

class SolarFilm:NSObject {
    private var filmName:String?
    private var baseColor:String?
    private var filmID:String?
    private var propertiesList = [VisibilityProperty]()
    
    init(_ source:[String:AnyObject]?) {
        if let dict = source {
            self.filmID = dict["FilmID"] as? String
            self.baseColor = dict["BaseColor"] as? String
            self.filmName = dict["FilmName"] as? String
            if let properties  = dict["PropertiesList"] as? Array<[String:AnyObject]> {
                for property in properties {
                    var p = VisibilityProperty()
                    p.name = property["Name"] as? String
                    p.value = property["Value"] as? String
                    self.propertiesList.append(p)
                }
            }
        }
    }
    
    func title() -> String {
        var result = ""
        if  let name = self.filmName {
            result = name
        }
        return result
    }
    
    func color() -> String {
        var result = ""
        if  let name = self.baseColor {
            result = name
        }
        return result
    }
}


