//
//  Player.swift
//  HoMaMTypeGame2
//
//  Created by Scott Vander Pryt on 2020-06-14.
//  Copyright © 2020 Scott Vander Pryt. All rights reserved.
//

class Player{
    
    //var isPlayerA = false
    
    //var creatures : [Creature] = []
    var playerID : Int
    var creatureData : [eCreatureGlossary] = []
    var creatures : [Creature] = []
    
    init(creatureData : [eCreatureGlossary], playerID : Int){
//        for i in 0..<creatureData.count{
//            if i >= Constants.maxTeamSize { break}
//            self.creatureData.append(CreatureManager.instance.GetCreatureData(creatureGlossary: creatureData[i]))
//        }
        self.creatureData = creatureData
        self.playerID = playerID
    }
    
    func PopulateTeam(){
        
    }
}
