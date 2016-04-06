//
//  PlayersListViewController.swift
//  GameScores
//
//  Created by Silviu Odobescu on 14/03/16.
//  Copyright © 2016 ODSI. All rights reserved.
//

import UIKit
import RealmSwift

class PlayerTableViewCell : UITableViewCell
{
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerWinsLabel: UILabel!
    
}

class PlayersListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    var players : Results<Player>?
    let realm = try! Realm()
    var token : NotificationToken?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // Observe Results Notifications
        self.token = realm.objects(Player).addNotificationBlock { results, error in
            self.players = results
            self.tableView.reloadData()
        }
    }
    
    deinit
    {
        self.token?.stop()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let playersList = players
        {
            return playersList.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("PlayerTableViewCell", forIndexPath: indexPath) as! PlayerTableViewCell
        
        let player = self.players![indexPath.row]
        cell.playerNameLabel.text = player.name
        cell.playerWinsLabel.text = String(player.gamesWon)
        
        return cell
    }

}
