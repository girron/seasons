//
//  TitlePage.swift
//  Seasons
//
//  Created by Jake Bush on 1/20/17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import SpriteKit

class TitlePage: GameScene {
    
    var readButton: SKSpriteNode!
    
    override func getNextScene() -> SKScene? {
        
        return SKScene(fileNamed: "Scene01") as! Scene01
    }
    
    override func sceneDidLoad() {
        
        super.sceneDidLoad()
        readButton = childNode(withName: "readButton") as! SKSpriteNode
        
        btnNext.isHidden = true
        btnPrevious.isHidden = true
    }
    
    override func touchDown(at point: CGPoint) {
        
        if readButton.contains(point) {
            
            goToScene(scene: getNextScene()!)
        }
    }
}
