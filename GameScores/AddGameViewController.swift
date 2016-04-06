//
//  AddGameViewController.swift
//  GameScores
//
//  Created by Silviu Odobescu on 14/03/16.
//  Copyright © 2016 ODSI. All rights reserved.
//

import UIKit
import RealmSwift

class AddGameViewController: UIViewController {
    @IBOutlet weak var gameNameLabel: UITextField!
    
    let realm = try! Realm(configuration: RealmManager.sharedInstance.configuration())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    @IBAction func doneButtonClicked(sender: AnyObject)
    {
        if let text = gameNameLabel.text where !text.isEmpty
        {
            RealmManager.sharedInstance.addNewGame(text)
            self.dismissViewControllerAnimated(true, completion: nil);
        }
        else
        {
            let alertController = UIAlertController(title: "No game name?", message: "You gotta have a name", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}
