//
//  StoryArticlesTableViewCell.swift
//  testApp
//
//  Created by Codreanu Inga on 8/4/16.
//  Copyright © 2016 Codreanu Inga. All rights reserved.
//

import UIKit

class StoryArticlesTableViewCell: UITableViewCell {

    @IBOutlet var titleArticles: UILabel!
    @IBOutlet var dateArticles: UILabel!
    @IBOutlet var numberComments: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
