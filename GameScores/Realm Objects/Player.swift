//
//  Player.swift
//  GameScores
//
//  Created by Silviu Odobescu on 14/03/16.
//  Copyright © 2016 ODSI. All rights reserved.
//

import Foundation
import RealmSwift

class Player: Object
{
    dynamic var name = "";
    var gamesWon : Int
    {
        return linkingObjects(Game.self, forProperty: "winner").count;
    }
    
    override static func primaryKey() -> String?
    {
        return "name";
    }
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
