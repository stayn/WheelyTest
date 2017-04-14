//
//  CrazyDataTableViewCell.swift
//  WheelyTest
//
//  Created by Anastasia Loginova on 12.04.17.
//  Copyright © 2017 Anastasia Loginova. All rights reserved.
//

import UIKit

class CrazyDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var crazyItem: Crazy! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        titleLabel.text = crazyItem.title
        descriptionLabel.text = crazyItem.text
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
