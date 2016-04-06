//
//  AddPlayerViewController.swift
//  GameScores
//
//  Created by Silviu Odobescu on 14/03/16.
//  Copyright © 2016 ODSI. All rights reserved.
//

import UIKit

class AddPlayerViewController: UIViewController {

    @IBOutlet weak var playerNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func savePlayer(sender: AnyObject)
    {
        if let text = playerNameTextField.text where !text.isEmpty
        {
            RealmManager.sharedInstance.addNewPlayer(text)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else
        {
            let alertController = UIAlertController(title: "No name?", message: "You gotta have a name", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelAction(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
}
