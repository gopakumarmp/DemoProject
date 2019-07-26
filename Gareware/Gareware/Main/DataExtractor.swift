//
//  FilmDataExtractor.swift
//  Gareware
//
//  Created by Gopakumar MP on 7/24/19.
//  Copyright © 2019 Gopakumar MP. All rights reserved.
//

import Foundation

class DataExtractor:NSObject {
    class func extractSolarControlFilData(source:[String:AnyObject]?) -> [SolarControlFilmMainCategory] {
        
        var result = [SolarControlFilmMainCategory]()
        
        guard let filmDetails = source?["FilmDetails"] as? [String:AnyObject] else {
            return result
        }
        
        guard let mainCategories = filmDetails["FilmDetailsList"] as? Array<AnyObject> else {
            return result
        }
        
        for item in mainCategories {
            if let dict  = item as? [String:AnyObject] {
                let solarControl = SolarControlFilmMainCategory(source: dict)
                result.append(solarControl)
            }
        }
        return result
    }
}
