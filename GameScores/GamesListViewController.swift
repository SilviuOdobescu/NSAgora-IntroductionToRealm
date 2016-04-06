//
//  GamesListViewController.swift
//  GameScores
//
//  Created by Silviu Odobescu on 14/03/16.
//  Copyright © 2016 ODSI. All rights reserved.
//

import UIKit
import RealmSwift

class GameTableViewCell : UITableViewCell
{
    @IBOutlet weak var numberOfPlayersLabel: UILabel!
    @IBOutlet weak var gameNameLabel: UILabel!
    
    class func cellIdentifier() -> String
    {
        return "GameTableViewCell"
    }
    
}

class GamesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var gamesTableView: UITableView!
    var gamesList: Results<Game>!
    let realm = try! Realm(configuration: RealmManager.sharedInstance.configuration())
    var token : NotificationToken?
    var gameSelected : Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gamesTableView.dataSource = self
        self.gamesTableView.delegate = self
        
        self.token = realm.objects(Game).addNotificationBlock { (results, error) -> () in
            self.gamesList = results
            self.gamesTableView.reloadData()
        }
    }
    
    deinit
    {
        self.token?.stop()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
        if segue.identifier == "GameDetails"
        {
            let destinationVC = segue.destinationViewController as! GameDetailsViewController
            let indexPath = self.gamesTableView.indexPathForSelectedRow
            destinationVC.thisGameIdentifier = self.gamesList[(indexPath?.row)!].gameId
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(GameTableViewCell.cellIdentifier(), forIndexPath: indexPath) as! GameTableViewCell
        
        let aGame = self.gamesList[indexPath.row] 
        cell.gameNameLabel.text = aGame.name
        cell.numberOfPlayersLabel.text = aGame.numberOfPlayers
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let games = gamesList
        {
            return games.count
        }
        else
        {
            return 0
        }
    }
}
