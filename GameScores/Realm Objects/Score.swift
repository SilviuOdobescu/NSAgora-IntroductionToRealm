//
//  Score.swift
//  GameScores
//
//  Created by Silviu Odobescu on 14/03/16.
//  Copyright © 2016 ODSI. All rights reserved.
//

import Foundation
import RealmSwift

class Score: Object
{
    dynamic var scoreId = NSUUID().UUIDString;
    dynamic var points = -1;
    dynamic var player : Player?;
    dynamic var game : Game?
    
    override static func primaryKey() -> String?
    {
        return "scoreId";
    }
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
