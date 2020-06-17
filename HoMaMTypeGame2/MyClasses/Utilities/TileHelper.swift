//
//  TileHelper.swift
//  HoMaMTypeGame2
//
//  Created by Scott Vander Pryt on 2020-06-15.
//  Copyright © 2020 Scott Vander Pryt. All rights reserved.
//

import SpriteKit

func GetTile(tileMap: SKTileMapNode, coords: TileCoords) -> SKTileDefinition?{
    return tileMap.tileDefinition(atColumn: coords.column, row: coords.row)
}

func GetTile(tileMap: SKTileMapNode, position : CGPoint) -> SKTileDefinition?{
    let coords = GetTileCoordsAtPosition(tilemap: tileMap, position: position)
    return GetTile(tileMap: tileMap, coords: coords)
}

func GetTileCoordsAtPosition(tilemap: SKTileMapNode, position : CGPoint) -> TileCoords {
    let column = tilemap.tileColumnIndex(fromPosition: position)
    let row = tilemap.tileRowIndex(fromPosition: position)
    return (column, row)
}
