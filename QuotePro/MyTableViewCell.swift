//
//  MyTableViewCell.swift
//  QuotePro
//
//  Created by Jeff Eom on 2016-08-03.
//  Copyright © 2016 Jeff Eom. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var quoteView: QuoteView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
