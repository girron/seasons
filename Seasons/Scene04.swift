
import SpriteKit

class Scene04: GameScene {

  override func getPreviousScene() -> SKScene? {
    return SKScene(fileNamed: "Scene03") as! Scene03
  }

}
