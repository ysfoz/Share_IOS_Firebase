//
//  FeedCell.swift
//  Share_Firebase
//
//  Created by ysf on 09.11.21.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var userEmailLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var commnetLabel: UILabel!
    
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
    }
}
