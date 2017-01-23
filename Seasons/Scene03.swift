import SpriteKit

class Scene03: GameScene {
  

  override func getNextScene() -> SKScene? {
    return SKScene(fileNamed: "Scene04") as! Scene04
  }
  
  override func getPreviousScene() -> SKScene? {
    return SKScene(fileNamed: "Scene02") as! Scene02
  }

}
