//
//  ViewController.swift
//  Share_Firebase
//
//  Created by ysf on 07.11.21.
//

import UIKit
import Firebase


class ViewController: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // eger kullanici zaten giris yapmisa uygulamanin direk olarak acilmasi icin alttaki kodlar kullanilir, ama son guncellemelerle birlikte bunlari SceneDelegate icersinde yazmak gerekiyor.
//        let currentUser = Auth.auth().currentUser
//        
//        if currentUser != nil {
//            performSegue(withIdentifier: "toFeedVC", sender: nil)
//        }
//        
    }

    @IBAction func signInClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail:  emailText.text!, password: passwordText.text!) { authdata, error in
                if error != nil {
                    self.makeAlert(title: "Error!", message: error?.localizedDescription ?? "Error!")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            makeAlert(title: "Error", message: "Email and Password fields can not be empty")
        }
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                    
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
            
            
        } else {
            makeAlert(title:"Error!",message:"Email and Password fields can not be empty")
        }
        
    }
    
    func makeAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

