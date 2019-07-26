//
//  MainViewController.swift
//  Gareware
//

import UIKit

protocol MainViewControllerDelegate:class{
    func IndiaRegionSelected()
}

class MainViewController: UIViewController,MainViewControllerDelegate {

    @IBOutlet weak var automotiveFilmThumbView: UIView!
    @IBOutlet weak var archFilmThumbView: UIView!
    var appVersion:String?
    var regionView:RegionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupOrientation()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleArchFilmTap))
        archFilmThumbView.addGestureRecognizer(tap)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(self.registrationCompleted),
                                       name: NSNotification.Name(rawValue: "com.registraioncomplted"),
                                       object: nil)
    }
    
    @objc func registrationCompleted() {
        self.showRegionView()
    }
    
    func showRegionView() {
        self.regionView = RegionView.createView(frame: self.view.bounds)
        self.automotiveFilmThumbView.isHidden = true
        self.archFilmThumbView.isHidden = true
        self.regionView?.isHidden = false
        if let view = self.regionView {
            self.view.addSubview(view)
            self.regionView?.isHidden = false
            self.regionView?.topAnchor.constraint(equalTo: view.topAnchor,constant: 8).isActive = true
            self.regionView?.bottomAnchor.constraint(equalTo: view.topAnchor,constant: 8).isActive = true
            self.regionView?.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 8).isActive = true
            self.regionView?.rightAnchor.constraint(equalTo: view.rightAnchor,constant: 8).isActive = true
            self.regionView?.frame = self.view.frame
            self.view.bringSubview(toFront: view)
            self.regionView?.delegate = self
        }
    }
    
    @objc func handleIndianRegionTap() {
        self.showFilmView()
    }
    
    func showFilmView() {
        self.automotiveFilmThumbView.isHidden = false
        self.archFilmThumbView.isHidden = false
        self.regionView?.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupOrientation()
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        Services().getAppVersion { (version, error) in
            if let _ =  error {
                
            }else {
                self.appVersion = version
            }
        }
    }
    
    func IndiaRegionSelected() {
        self.showFilmView()
    }
    
    @objc func handleArchFilmTap() {
        let detailVC = UIStoryboard.ArchitectSunFilmsController()
        AppObject.delegate().navController.pushViewController(detailVC, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupOrientation() {
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }    
}

