//
//  FeedCell.swift
//  Share_Firebase
//
//  Created by ysf on 09.11.21.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {
    @IBOutlet weak var userEmailLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var commnetLabel: UILabel!
    @IBOutlet weak var documentIdLabel: UILabel!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonClicked(_ sender: Any) {
        
        let db = Firestore.firestore()
        
        if let likeCount = Int(likeLabel.text!) {
            
            let likeStore = ["likes" : likeCount + 1] as [String : Any]
            db.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)
        }
        
        
        
    }
}
