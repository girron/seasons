
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
