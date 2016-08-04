//
//  QuoteBuilderViewController.swift
//  QuotePro
//
//  Created by Jeff Eom on 2016-08-03.
//  Copyright © 2016 Jeff Eom. All rights reserved.
//

import UIKit

//MARK: Protocol

protocol QuoteBuilderDelegate : class {
    func saveButtonPressed(photo: UIImage, quote: String, author: String)
}

//MARK: Class

class QuoteBuilderViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPhoto()
        fetchQuoteAndQuoteAuthor()
        
    }
    
    //MARK: Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var quoteByLabel: UILabel!
    
    
    //MARK: Protocol Delegate
    
    weak var saveButtonDelegate:QuoteBuilderDelegate?
    
    //MARK: Action
    
    @IBAction func getNewImage(sender: AnyObject) {
        fetchPhoto()
    }

    @IBAction func getNewQuote(sender: AnyObject) {
        fetchQuoteAndQuoteAuthor()
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        self.navigationController!.popViewControllerAnimated(true)
        self.saveButtonDelegate?.saveButtonPressed(imageView.image!, quote: quoteLabel.text!, author: quoteByLabel.text!)
    }
    
    //MARK: Functions
    
    func fetchPhoto(){
        
        let imageURL = NSURL(string: "https://unsplash.it/\(self.view.frame.width)/\(self.view.frame.height)/?random")
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let data = NSData(contentsOfURL: imageURL!)
            dispatch_async(dispatch_get_main_queue(), {
                self.imageView.image = UIImage(data: data!)!
            })
        }
    }
    
    func fetchQuoteAndQuoteAuthor(){
        let req = NSMutableURLRequest(URL: NSURL(string: "http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json")!)
        
        req.HTTPMethod = "GET"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(req) { (data, resp, err) in
            
            guard let data = data else {
                print("no data returned from server \(err)")
                return
            }
            
            guard let resp = resp as? NSHTTPURLResponse else {
                print("no response returned from server \(err)")
                return
            }
            
            guard let rawJson = try? NSJSONSerialization.JSONObjectWithData(data, options: []) else {
                print("data returned is not json, or not valid")
                return
            }
            
            guard resp.statusCode == 200 else {
                // handle error
                print("an error occurred \(rawJson["error"])")
                return
            }
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                let fetchedDictionary = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary
                let fetchedQuote: String = fetchedDictionary["quoteText"] as! String
                let fetchedQuoteBy: String = fetchedDictionary["quoteAuthor"] as! String
                dispatch_async(dispatch_get_main_queue(), {
                    self.quoteLabel.text = fetchedQuote
                    self.quoteByLabel.text = fetchedQuoteBy
                })
            }
        }
        
        task.resume()
    }

}
