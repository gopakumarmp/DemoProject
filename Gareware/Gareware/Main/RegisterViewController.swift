//
//  RegisterViewController.swift
//  Gareware
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet var enterSiteView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    weak var delegate:MainViewControllerDelegate?
    
    override func viewDidLoad() {
        self.setupView()
    }
    
    func setupView() {
        self.view.backgroundColor = bgColor(self.view, title: "splash")
        self.emailTextField.backgroundColor = UIColor.clear
        self.nameTextField.backgroundColor = UIColor.clear
        self.phoneNumberTextField.backgroundColor = UIColor.clear
        
        self.emailTextField.textColor = UIColor.white
        self.nameTextField.textColor = UIColor.white
        self.phoneNumberTextField.textColor = UIColor.clear

        self.emailTextField.setPlaceholderWithColor("Email", color: UIColor.white)
        self.nameTextField.setPlaceholderWithColor("Name", color: UIColor.white)
        self.phoneNumberTextField.setPlaceholderWithColor("Mobile(optional)", color: UIColor.white)
        
        self.emailTextField.layer.borderColor = UIColor.white.cgColor
        self.nameTextField.layer.borderColor = UIColor.white.cgColor
        self.phoneNumberTextField.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func enterSiteButtonTapped(_ sender: Any) {
        guard let name = self.nameTextField.text,let email = self.emailTextField.text, name.count > 0 , (email.contains("@") && email.contains(".com")) else {
            
            let alertController = UIAlertController(title: "Alert", message: "Please Enter Your Name and Email.", preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2 , execute: {
                alertController.dismiss(animated: true, completion: {})
            })
            
            return
        }
        
        Services().addNewNewUser(name:name ,email: email) { ( err) in
            
            if err == nil {
                DispatchQueue.main.async {
                    AppObject.delegate().navController.dismiss(animated: true) {}
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "com.registraioncomplted"), object: nil)
                }
            }
        }
    }
}
