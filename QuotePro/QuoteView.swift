//
//  QuoteViewController.swift
//  QuotePro
//
//  Created by Jeff Eom on 2016-08-03.
//  Copyright © 2016 Jeff Eom. All rights reserved.
//

import UIKit

class QuoteView: UIView {
    
    //MARK: Properties
    
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var quote: UILabel!
    @IBOutlet weak var quoteBy: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib.init(nibName: "QuoteView", bundle: nil).instantiateWithOwner(self, options: nil).first
        self.addSubview(self.view)
        self.view.frame = self.frame
    }
}
