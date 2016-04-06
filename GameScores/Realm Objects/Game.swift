//
//  Game.swift
//  GameScores
//
//  Created by Silviu Odobescu on 14/03/16.
//  Copyright © 2016 ODSI. All rights reserved.
//

import Foundation
import RealmSwift

class Game: Object
{
    dynamic var gameId = NSUUID().UUIDString;
    dynamic var name = "";
    dynamic var winner : Player? //to-one relationships must be optional
    
    
    var scores : [Score]
    {
        return linkingObjects(Score.self, forProperty: "game");
    }
    
    var numberOfPlayers : String
    {
        return String(linkingObjects(Score.self, forProperty: "game").count)
    }
    
    override static func primaryKey() -> String?
    {
        return "gameId";
    }

}
