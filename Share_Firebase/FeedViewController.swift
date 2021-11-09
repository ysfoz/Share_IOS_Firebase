//
//  FeedViewController.swift
//  Share_Firebase
//
//  Created by ysf on 07.11.21.
//

import UIKit
import Firebase
import SDWebImage


class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//
   
    
    

    @IBOutlet weak var tableView: UITableView!
    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        getData()
    }
  
    func getData() {
        let db = Firestore.firestore()
        db.collection("Posts").order(by: "date", descending: true).getDocuments { querysnapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if querysnapshot?.isEmpty != true {
                    
                    self.userImageArray.removeAll(keepingCapacity: false)
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    for document in querysnapshot!.documents {
                        let documentID = document.documentID
                        
                        if let postedby = document.get("postedby") as? String {
                            self.userEmailArray.append(postedby)
                            print(self.userEmailArray)
                        }
                        if let postComment = document.get("postComment") as? String {
                            self.userCommentArray.append(postComment)
                        }
                        if let likes = document.get("likes") as? Int {
                            self.likeArray.append(likes)
                        }
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.userImageArray.append(imageUrl)
                        }
                        
                    }
                    self.tableView.reloadData()
                }
                
               
            }
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->  UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        print("indexPath \(indexPath.row), \(userCommentArray.count)")
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        cell.commnetLabel.text = userCommentArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        return cell
    }
    
    
   
    

   
}
