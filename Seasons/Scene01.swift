/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import SpriteKit

class Scene01: GameScene {
    
    var hat: SKSpriteNode!
    var touchPoint: CGPoint?
    
    override func getNextScene() -> SKScene? {
        return SKScene(fileNamed: "Scene02") as! Scene02
    }
    override func getPreviousScene() -> SKScene? {
        
        return SKScene(fileNamed: "TitlePage") as! TitlePage
    }
    
    override func sceneDidLoad() {
        
        super.sceneDidLoad()
        hat = childNode(withName: "hat") as! SKSpriteNode
        
        var bounds = CGRect.zero
        bounds.origin.x = -size.width/2
        bounds.origin.y = -size.height/2 + 110
        bounds.size = size
        physicsBody = SKPhysicsBody(edgeLoopFrom: bounds)
    }
    
    override func touchDown(at point: CGPoint) {
        
        if hat.contains(point) {
            touchPoint = point
            
            hat.physicsBody?.velocity = CGVector.zero
            hat.physicsBody?.angularVelocity = 0
            hat.physicsBody?.affectedByGravity = false
            
        }
    }
    
    override func touchMoved(to point: CGPoint) {
        
        if touchPoint != nil {
            touchPoint = point
        }
    }
    
    override func touchUp(at point: CGPoint) {
        
        if let touchPoint = touchPoint {
            hat.physicsBody?.affectedByGravity = true
            
            if let hatPosition = childNode(withName: "hatPosition") {
                if hatPosition.contains(touchPoint) {
                    hat.position = hatPosition.position
                    hat.physicsBody?.affectedByGravity = false
                    hat.run(SKAction.playSoundFileNamed("thompsonman_pop.mp3", waitForCompletion: false))
                }
            }
        }
        
        touchPoint = nil
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if let touchPoint = touchPoint {
            hat.position = touchPoint
        }
    }
}
