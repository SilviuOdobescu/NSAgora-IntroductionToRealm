//
//  RealmManager.swift
//  GameScores
//
//  Created by Silviu Odobescu on 23/03/16.
//  Copyright © 2016 ODSI. All rights reserved.
//

import RealmSwift

class RealmManager
{
    static let sharedInstance = RealmManager()
    private init()
    {
        var config = Realm.Configuration()
        // Use the default directory, but replace the filename
        config.path = NSURL.fileURLWithPath(config.path!).URLByDeletingLastPathComponent?.URLByAppendingPathComponent("GameScores.realm").path
        // Set this as the configuration used for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
    
    func addNewPlayer(name:String) -> Void
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
        {
            let newPlayer = Player()
            newPlayer.name = name
            
            let realm = try! Realm()
            try! realm.write
            {
                realm.add(newPlayer, update: true)
            }
        }
    }
    
    func addNewGame(gameName:String) -> Void
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
        {
            let newGame = Game()
            newGame.name = gameName
            
            let realm = try! Realm()
            try! realm.write
            {
                realm.add(newGame, update: true)
            }
        }
    }
    
    func addScore(playerName: String, gameIdentifier: String, score:Int) -> Void
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let realm = try! Realm()
            let player = realm.objects(Player).filter("name = %@", playerName).first
            let game = realm.objects(Game).filter("gameId = %@", gameIdentifier).first
            
            let newScore = Score()
            newScore.player = player
            newScore.game = game
            newScore.points = score
            
            try! realm.write({ 
                realm.add(newScore, update: true)
            })
        }
    }
    
    func configuration() -> Realm.Configuration
    {
        var config = Realm.Configuration()
        // Use the default directory, but replace the filename
        config.path = NSURL.fileURLWithPath(config.path!).URLByDeletingLastPathComponent?.URLByAppendingPathComponent("GameScores.realm").path
        return config
    }
    
}