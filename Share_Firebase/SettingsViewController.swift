//
//  SettingsViewController.swift
//  Share_Firebase
//
//  Created by ysf on 07.11.21.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func logoutButtonClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
            
        } catch {
            print("Error!")
        }
        
        
    }
    
}
