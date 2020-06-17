//
//  CreatureManager.swift
//  HoMaMTypeGame2
//
//  Created by Scott Vander Pryt on 2020-06-12.
//  Copyright © 2020 Scott Vander Pryt. All rights reserved.
//

import Foundation
import SpriteKit

class CreatureManager{
    static let instance = CreatureManager()
    
    var creatureData = Array(repeating: CreatureData(name: "Spider", moveDistance: 4, speed : 0), count: eCreatureGlossary.allCases.count)
    
    var activeCreatures : [Creature] = []
    
    init(){
        LoadCreatureData()
    }
    
    func LoadCreatureData(){
        creatureData[eCreatureGlossary.GHOST.rawValue] = CreatureData(name: "Ghost", moveDistance: 7, speed : 7)
        creatureData[eCreatureGlossary.SPIDER.rawValue] = CreatureData(name: "Spider", moveDistance: 3, speed : 3)
        creatureData[eCreatureGlossary.EFREET.rawValue] = CreatureData(name: "Efreet", moveDistance: 5, speed: 5)
    }
    
    public func GetCreatureData(creatureGlossary: eCreatureGlossary) -> CreatureData{
        return creatureData[creatureGlossary.rawValue]
    }
    
    public func CreateNewCreature(creatureGlossary: eCreatureGlossary, position: CGPoint, tileCoords: TileCoords, tileDefinition : SKTileDefinition, creatureCount: Int, scene: SKScene, owningPlayer: Player) -> Creature{
        let creature = Creature(creatureData: creatureData[creatureGlossary.rawValue], creatureCount: 5, tileCoords: tileCoords, tileDefinition: tileDefinition, owningPlayer: owningPlayer)
        creature.position = position
        //creature.spriteNode?.size *= 2
        
        activeCreatures.append(creature)
        scene.addChild(creature)
        return creature
    }
    
    //TEMP UPDATE FUNC
    public func UpdateAllActiveCreatures(){
        for creature in activeCreatures{
            creature.Update()
        }
    }
}

enum eCreatureGlossary: Int, CaseIterable{
    case GHOST
    case SPIDER
    case EFREET
}

