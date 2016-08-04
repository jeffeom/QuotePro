//
//  HomeViewController.swift
//  QuotePro
//
//  Created by Jeff Eom on 2016-08-03.
//  Copyright © 2016 Jeff Eom. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, QuoteBuilderDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var photosArray = [UIImage]()
    var quotesArray = [String]()
    var authorsArray = [String]()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addQuote" {
            let addVC = segue.destinationViewController as! QuoteBuilderViewController
            addVC.saveButtonDelegate = self
        }
    }
    
    func saveButtonPressed(photo: UIImage, quote: String, author: String) {
        
        photosArray.append(photo)
        quotesArray.append(quote)
        authorsArray.append(author)
        
        self.tableView.reloadData()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return photosArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MyTableViewCell
        
        cell.bounds = self.view.frame
        
        cell.quoteView.quote?.text = quotesArray[indexPath.row]
        cell.quoteView.quoteBy?.text = authorsArray[indexPath.row]
        cell.quoteView.imageView?.image = photosArray[indexPath.row]
        
        
        return cell
    }

}
