//
//  GameDetailsViewController.swift
//  GameScores
//
//  Created by Silviu Odobescu on 14/03/16.
//  Copyright © 2016 ODSI. All rights reserved.
//

import UIKit
import RealmSwift

class ScoreCell : UITableViewCell
{
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var isWinnerView: UIView!
    
}

class GameDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var playerNameLabel: UITextField!
    @IBOutlet weak var playerScoreLabel: UITextField!
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet weak var playersTableView: UITableView!
    @IBOutlet weak var isWinnerButton: UIButton!
    
    var scoreList: [Score]!
    var token : NotificationToken?
    var thisGameIdentifier : String?
    var isThisTheWinner : Bool = false
    let realm = try! Realm(configuration: RealmManager.sharedInstance.configuration())

    override func viewDidLoad() {
        super.viewDidLoad()

        self.playersTableView.dataSource = self
        self.playersTableView.delegate = self
        
        self.token = realm.objects(Game).filter("gameId = %@", self.thisGameIdentifier!).addNotificationBlock { (results, error) -> () in
            self.scoreList = results?.first?.scores
            self.title = results?.first?.name
            self.playersTableView.reloadData()
        }
    }
    
    deinit
    {
        self.token?.stop()
    }
    

    @IBAction func addPlayerButtonClicked(sender: AnyObject)
    {
        if let playerName = playerNameLabel.text where !playerName.isEmpty, let scoreValue = playerScoreLabel.text where !scoreValue.isEmpty
        {
            if let player = realm.objects(Player).filter("name = %@", playerName).first
            {
                RealmManager.sharedInstance.addScore(player.name, gameIdentifier: self.thisGameIdentifier!, score: Int(scoreValue)!)
                
            }
            else
            {
                let alertController = UIAlertController(title: "No player?", message: "Get your players right", preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                alertController.addAction(cancelAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
        else
        {
            let alertController = UIAlertController(title: "Really?", message: "So the users are very stupid!", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
//    @IBAction func isWinnerButtonClicked(sender: AnyObject)
//    {
//        if (self.thisGame?.winner) != nil
//        {
//            let alertController = UIAlertController(title: "There is a winner already", message: "See table below", preferredStyle: .Alert)
//            let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
//            alertController.addAction(cancelAction)
//            
//            self.presentViewController(alertController, animated: true, completion: nil)
//        }
//        else
//        {
//            self.isThisTheWinner = true
//        }
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //====
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.playersTableView.dequeueReusableCellWithIdentifier("ScoreCell", forIndexPath: indexPath) as! ScoreCell
        
        let score = self.scoreList![indexPath.row]
        cell.playerNameLabel.text = score.player!.name
        cell.playerScoreLabel.text = String(score.points)
//        if((self.thisGame?.winner?.isEqual(score.player)) != nil)
//        {
//            cell.isWinnerView.backgroundColor = UIColor.greenColor()
//        }
//        else
//        {
//            cell.isWinnerView.backgroundColor = UIColor.redColor()
//        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let scores = scoreList
        {
            return scores.count
        }
        else
        {
            return 0
        }
    }

}
