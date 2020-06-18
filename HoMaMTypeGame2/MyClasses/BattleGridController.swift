//
//  BattleGridController.swift
//  HoMaMTypeGame2
//
//  Created by Scott Vander Pryt on 2020-06-17.
//  Copyright © 2020 Scott Vander Pryt. All rights reserved.
//

import SpriteKit

class BattleGridController{
    var battleGrid : SKTileMapNode
    var obstaclesGrid : SKTileMapNode?
    
    var gridHallow : SKTileGroup
    var gridFull : SKTileGroup
    
    init(scene : SKScene){
        //self.obstaclesGrid = obstaclesGrid
        
        
        let gridHallowTex = SKTexture(pixelImagedNamed: "gridHallow")
        let gridFullTex = SKTexture(pixelImagedNamed: "gridFull")
        
        let hallowTile = SKTileDefinition(texture: gridHallowTex)
        let fullTile = SKTileDefinition(texture: gridFullTex)
        
        gridHallow = SKTileGroup(tileDefinition: hallowTile)
        gridFull = SKTileGroup(tileDefinition: fullTile)
        
        let newTileSet = SKTileSet(tileGroups: [gridHallow, gridFull])
        
        battleGrid = SKTileMapNode(tileSet: newTileSet, columns: Constants.gridColumnSize, rows: Constants.gridRowSize, tileSize: CGSize(width: 16, height: 16))
        
        for i in 0..<battleGrid.numberOfColumns{
            for j in 0..<battleGrid.numberOfRows{
                print("in here")
                battleGrid.setTileGroup(gridHallow, forColumn: i, row: j)
            }
        }
        
        scene.addChild(battleGrid)
        
        let highlightTiles = GetAllTilesInArea(tileDistance: 3, coords: (column:6, row:6))
        
        //let coords = GetTile
        for i in 0..<highlightTiles.count{
            battleGrid.setTileGroup(gridFull, forColumn: highlightTiles[i].column, row: highlightTiles[i].row)
        }
        
        
    }
    
    func GetAllTilesInArea(tileDistance : Int, coords : TileCoords)->[TileCoords]{
        var tiles : [TileCoords] = []
        //tiles.append(coords)
        
        //let creatureTileDef = battleGrid.tileDefinition(atColumn: coords.column, row: coords.row)
        //tiles.append(creatureTileDef!)
        
        //var startCoords = (column: )
        for i in 0..<battleGrid.numberOfColumns{
            for j in 0..<battleGrid.numberOfRows{
                if(coords == (column:i, row: j)) {continue}
                
                let columnDistance = abs(coords.column - i)
                let rowDistance = abs(coords.row - j)
                             
                if(columnDistance+rowDistance <= tileDistance) {
                    
                    tiles.append((column : i, row : j))
                }
            }
        }
        
        return tiles
    }
    
    func DoesIndexExist(x: Int, y:Int) -> Bool{
        if(x < 0 || x >= battleGrid.numberOfColumns) {return false}
        if(y < 0 || y >= battleGrid.numberOfRows) {return false}
        
        return true
    }
    
}


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
