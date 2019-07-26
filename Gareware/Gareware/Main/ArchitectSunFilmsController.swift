//
//  ArchitectSunFilms.swift
//  Gareware
//

import UIKit

class ArchitectSunFilmsController: UIViewController {
    
    @IBOutlet weak var v1: UIView!
    
    override func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleSolarFilmTap))
        self.v1.addGestureRecognizer(tap)
    }
    
    @objc func handleSolarFilmTap() {
        let detailVC = UIStoryboard.DetailViewController()
        AppObject.delegate().navController.pushViewController(detailVC, animated: true)
    }
}
