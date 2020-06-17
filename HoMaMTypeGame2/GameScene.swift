//
//  GameScene.swift
//  HoMaMTypeGame2
//
//  Created by Scott Vander Pryt on 2020-06-12.
//  Copyright © 2020 Scott Vander Pryt. All rights reserved.
//

import SpriteKit
import GameplayKit

enum eBattleState {
    case INITIALIZE
    case PLAYER_TURN
    case WAIT_FOR_ACTION
    case UPDATE_ACTIVE_CREATURE
    case END
}

class GameScene: SKScene {
    
    var creatureSpawnGrid : SKTileMapNode?
    var gridLayout : SKTileMapNode?
    var player1 : Player?
    var player2 : Player?

    var creaturesInBattleInOrder : [Creature]?
    var activeCreature : Creature?
    var activeCreatureIndex : Int = 0
    
    var battleState = eBattleState.INITIALIZE
    
    //This isnt so much the Start method as it is, this scene is now moved into the game view.
    override func didMove(to view: SKView) {
        creatureSpawnGrid = childNode(withName: "SpawnGrid") as? SKTileMapNode
        gridLayout = childNode(withName: "BattleGrid") as? SKTileMapNode
        
        player1 = Player(creatureData:[eCreatureGlossary.EFREET, eCreatureGlossary.GHOST, eCreatureGlossary.SPIDER, eCreatureGlossary.SPIDER, eCreatureGlossary.SPIDER],playerID:  1)
        player2 = Player(creatureData:[eCreatureGlossary.SPIDER, eCreatureGlossary.GHOST, eCreatureGlossary.EFREET, eCreatureGlossary.GHOST, eCreatureGlossary.SPIDER],playerID:  2)
        
        
        SpawnPlayerCreatures(player: player1!)
        SpawnPlayerCreatures(player: player2!)
        
        creatureSpawnGrid?.removeFromParent()
        
        creaturesInBattleInOrder = GetTurnOrder(isFirstTimeRun: true)
        
//        for i in 0..<creatureTurnOrder!.count{
//            print(String(i) + creatureTurnOrder![i].name!)
//        }
        
        ChangeState(newState: .PLAYER_TURN)
    }
    
    func ChangeState(newState : eBattleState){
        battleState = newState
        
        if(newState == .UPDATE_ACTIVE_CREATURE){
            UpdateActiveCreature()
            ChangeState(newState: .PLAYER_TURN)
        }
    }
    
    func SpawnPlayerCreatures(player: Player){
        let spawnKey = player.playerID == 1 ? "creatureSpawn1" : "creatureSpawn2"
        var spawnIndex = 0
        
        for row in 0..<creatureSpawnGrid!.numberOfRows{
            for column in 0..<creatureSpawnGrid!.numberOfColumns{
                guard let tileDef = GetTile(tileMap: creatureSpawnGrid!, coords: (column, row)) else { continue }
                
                if(spawnIndex >= Constants.maxTeamSize) {return}
                
                if(tileDef.userData?.object(forKey: spawnKey) != nil) {
                    let position = ((creatureSpawnGrid?.centerOfTile(atColumn: column, row: row))!)
                    
                    //Create Creature
                    let creature = CreatureManager.instance.CreateNewCreature(creatureGlossary: player.creatureData[spawnIndex], position: position, tileCoords: (column, row), tileDefinition: (creatureSpawnGrid?.tileDefinition(atColumn: column, row: row))!, creatureCount: 5, scene: scene!, owningPlayer: player)
                    if(player.playerID == 2){creature.xScale = -1}
                    spawnIndex += 1
                    
                    player.creatures.append(creature)
                }
            }
        }
    }
    
    func GetTurnOrder(isFirstTimeRun: Bool) -> [Creature]{
        var creaturesInOrder : [Creature] = []
        
        for i in 0..<(player1?.creatures.count)!{
            guard let creature = player1?.creatures[i] else {continue}
            
            if(creaturesInOrder.count <= 0) {creaturesInOrder.append(creature)}
            else{
                for j in 0..<creaturesInOrder.count{
                    print(creature.speed)
                    print(creaturesInOrder[j].speed)
                    if(creature.creatureData.speed > creaturesInOrder[j].creatureData.speed){
                        creaturesInOrder.insert(creature, at: creaturesInOrder.index(before: j <= 0 ? 1 : j))
                         print(creaturesInOrder.count)
                        break
                    }
                    else {creaturesInOrder.append(creature)
                        break
                    }
//                    if(creature.speed > creaturesInOrder[j].speed){
//                        creaturesInOrder.insert(creature, at: creaturesInOrder.index(before: j))
//                        break
//                    }
//                    else if(creature.speed == creaturesInOrder[j].speed){
//                        if(creature.creatureCount > creaturesInOrder[j].creatureCount){
//                            creaturesInOrder.insert(creature, at: creaturesInOrder.index(before: j))
//                            break
//                        }
//                        else if(creature.creatureCount == creaturesInOrder[j].creatureCount){
//                            //EVENTUALLY RANDOMLY PICK
//                            print("index" + String(j))
//                            creaturesInOrder.insert(creature, at: creaturesInOrder.index(before: j <= 0 ? 1 : j))
//                            break
//                        }
//                        else {creaturesInOrder.append(creature)
//                            break
//                        }
//                    }
//                    else {
//                        creaturesInOrder.append(creature)
//                        break
//                    }
                }
            }
        }
        
        //IF FIRST RUN THAN ACTIVE CREATURE = 0 index
        if(isFirstTimeRun){
            activeCreatureIndex = 0;
            activeCreature = creaturesInOrder[activeCreatureIndex]
        }
        
        return creaturesInOrder
    }
    
    func GetTileDistanceFromActiveCreature(touchPos : CGPoint) -> TileCoords{
        let newPosition = GetTileCoordsAtPosition(tilemap: gridLayout!, position: touchPos)
        let columnDistance = abs((activeCreature?.tileCoords.column)! - newPosition.column)
        let rowDistance = abs((activeCreature?.tileCoords.row)! - newPosition.row)
        
        return (columnDistance, rowDistance)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let position = touches.first?.location(in: self) else {return}
        
//        var tex = SKTexture(pixelImagedNamed: "gridHallow")
//        var tile = SKTileDefinition(texture: tex)
//        //var rule = SKTileGroupRule(adjacency: .adjacencyAll, tileDefinitions: [tile])
//
//        var tileset = gridLayout!.tileSet.tileGroups
//        for i in 0..<tileset.count{
//            print(tileset[i].name)
//        }
//
//
//
//        gridLayout!.setTileGroup(gridLayout!.tileSet.tileGroups[1], forColumn: 1, row: 1)

        //var asdasd = SKTileGroup(tileDefinition: tile!)
        //print(asdasd.)
        if(battleState == eBattleState.PLAYER_TURN) { MoveCreature(clickPos: position) }
    }
    
    func MoveCreature(clickPos: CGPoint){
        let distanceCoords = GetTileDistanceFromActiveCreature(touchPos: clickPos)
        //print(distanceCoords)
        if(distanceCoords.column <= creaturesInBattleInOrder![activeCreatureIndex].creatureData.moveDistance &&
            distanceCoords.row <= creaturesInBattleInOrder![activeCreatureIndex].creatureData.moveDistance){
            //creaturesInBattleInOrder![activeCreatureIndex].MoveToNewGridspot(position: clickPos, scene: self)
            
            let clickCoords = GetTileCoordsAtPosition(tilemap: gridLayout!, position: clickPos)
            let tileCenter = gridLayout?.centerOfTile(atColumn: clickCoords.column, row: clickCoords.row)
            
            let moveCreatureAction = SKAction.move(to: tileCenter!, duration: 0.25 * Double(distanceCoords.column))
            
            ChangeState(newState: .WAIT_FOR_ACTION)
            
            activeCreature?.run(moveCreatureAction){
                self.ChangeState(newState: .UPDATE_ACTIVE_CREATURE)
            }
        }
    }
    
    //Change active reference to next creature in the list
    func UpdateActiveCreature(){
        activeCreatureIndex += 1
        if(activeCreatureIndex >= creaturesInBattleInOrder!.count){
            activeCreatureIndex = 0
        }
        activeCreature = creaturesInBattleInOrder?[activeCreatureIndex]
    }
   
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        CreatureManager.instance.UpdateAllActiveCreatures()
        //print(battleState)
        //print(activeCreature)
    }
}
