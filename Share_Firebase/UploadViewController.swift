//
//  UploadViewController.swift
//  Share_Firebase
//
//  Created by ysf on 07.11.21.
//

import UIKit
import Firebase
import FirebaseFirestore



class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
    }
    @objc func chooseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func makeAlert(title:String, message:String) {
        let alert = UIAlertController(title:title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

            @IBAction func uploadButtonClicked(_ sender: Any) {
                
                let storage = Storage.storage()
                let storageReference = storage.reference()
                // referance bize firebase storage konumunu gosteriyor. child dedigimizde icerisindeki bir klasore ulasmis ya da olusturmus oluyoruz. onun icersindeki bask abir klasore ulasmak icin yine .child denebilir
                let mediaFolder = storageReference.child("media")
                
                // firebase Storage icerisine image i kaydetmek icin
                
                if let data = imageView.image?.jpegData(compressionQuality: 0.4) {
                    let uuid = UUID().uuidString
                    let imageReferance = mediaFolder.child("\(uuid).jpeg")
                    imageReferance.putData(data, metadata: nil) { metaData, error in
                        if error != nil {
                            self.makeAlert(title: "Error!", message: error?.localizedDescription ?? "Error!")
                        } else {
                            imageReferance.downloadURL { url, error in
                                if error == nil {
                                    let imageURL = url?.absoluteString
                                    
                                    // tum verileri DATABASE icerisine kaydetmek icin
                                    
                                    let firestoreDatabase = Firestore.firestore()
                                    var firestoreReferance : DocumentReference? = nil
                                    let firestorePost = ["imageUrl":imageURL,"postedby":Auth.auth().currentUser!.email,"postComment":self.commentText.text!,"date": FieldValue.serverTimestamp(), "likes": 0 ] as [String: Any]
                                    firestoreReferance = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                        if error != nil {
                                            self.makeAlert(title: "Error!", message: error?.localizedDescription ?? "Error!")
                                        } else {
                                            self.tabBarController?.selectedIndex = 0
                                        }
                                    })
                                    
                                    
                                    
                            }
                        }
                        }
                    }
                    
                }
                
            }
            
    
//    var ref: DocumentReference? = nil
//    ref = db.collection("users").addDocument(data: [
//        "first": "Ada",
//        "last": "Lovelace",
//        "born": 1815
//    ]) { err in
//        if let err = err {
//            print("Error adding document: \(err)")
//        } else {
//            print("Document added with ID: \(ref!.documentID)")
//        }
//    }
    
}

