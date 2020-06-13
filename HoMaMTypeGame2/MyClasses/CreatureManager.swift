//
//  CreatureManager.swift
//  HoMaMTypeGame2
//
//  Created by Scott Vander Pryt on 2020-06-12.
//  Copyright © 2020 Scott Vander Pryt. All rights reserved.
//

import Foundation


class CreatureManager{
    static let instance = CreatureManager()
    
    var creatureData = Array(repeating: CreatureData(name: "Spider"), count: eCreatureGlossary.allCases.count)
    
    var activeCreatures : [Creature] = []
    
    init(){
        LoadCreatureData()
    }
    
    func LoadCreatureData(){
        creatureData[eCreatureGlossary.GHOST.rawValue] = CreatureData(name: "Ghost")
        creatureData[eCreatureGlossary.SPIDER.rawValue] = CreatureData(name: "Spider")
        creatureData[eCreatureGlossary.EFREET.rawValue] = CreatureData(name: "Efreet")
    }
    
    public func GetCreatureData(creatureGlossary: eCreatureGlossary) -> CreatureData{
        return creatureData[creatureGlossary.rawValue]
    }
    
    public func CreateNewCreature(creatureGlossary: eCreatureGlossary, creatureCount : Int) -> Creature{
        let creature = Creature(creatureData: creatureData[creatureGlossary.rawValue], creatureCount: creatureCount)
        activeCreatures.append(creature)
        //creature.position = CGPoint(x:-100, y: 0)
        //addChild(creature!)
        return creature
    }
    
    //TEMP UPDATE FUNC
    public func UpdateAllActiveCreatures(){
        for creature in activeCreatures{
            creature.Update()
        }
    }
    
    //TEMP CHANGE ANIM FUN
    public func IterateAllAnimations(){
        for creature in activeCreatures{
            creature.IterateAnimation()
        }
    }
}

enum eCreatureGlossary: Int, CaseIterable{
    case GHOST
    case SPIDER
    case EFREET
}

