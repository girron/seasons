
import SpriteKit

class GameScene: SKScene {
    
    var footer: SKNode!
    var btnNext: SKSpriteNode!
    var btnPrevious: SKSpriteNode!
    var btnSound: SKSpriteNode!
    var btnHome: SKSpriteNode!
    
    var backgroundMusic: SKAudioNode?
    var textAudio: SKAudioNode?
    var soundOff = false {
        
        didSet {
            
            // Change texture of the image depending on the value of soundOff
            
            let imageName = soundOff ? "button_sound_off" : "button_sound_on"
            btnSound.texture = SKTexture(imageNamed: imageName)
            
            let action = soundOff ? SKAction.pause() : SKAction.play()
            backgroundMusic?.run(action)
            backgroundMusic?.autoplayLooped = !soundOff
            
            UserDefaults.standard.set(soundOff, forKey: "pref_sound")
            UserDefaults.standard.synchronize()
        }
    }

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    touchMoved(to: touch.location(in: self))
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    touchUp(at: touch.location(in: self))
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    touchUp(at: touch.location(in: self))
  }
  
  // MARK:- Stub methods - override these in sub classes
  func touchDown(at point: CGPoint) {}
  func touchMoved(to point: CGPoint) {}
  func touchUp(at point: CGPoint) {}
  func getNextScene() -> SKScene? {
    return nil
  }
  func getPreviousScene() -> SKScene? {
    return nil
  }
    
    override func sceneDidLoad() {
        
        super.sceneDidLoad()
        footer = childNode(withName: "footer")
        
        btnNext = childNode(withName: "//buttonNext") as! SKSpriteNode
        btnPrevious = childNode(withName: "//buttonPrevious") as! SKSpriteNode
        btnSound = childNode(withName: "//buttonSound") as! SKSpriteNode
        btnHome = childNode(withName: "//buttonHome") as! SKSpriteNode
        
        backgroundMusic = childNode(withName: "backgroundMusic") as? SKAudioNode
        textAudio = childNode(withName: "textAudio") as? SKAudioNode
        
        soundOff = UserDefaults.standard.bool(forKey: "pref_sound")
        
    }
    
    func goToScene(scene: SKScene) {
        
        let sceneTransition = SKTransition.fade(with: UIColor.darkGray, duration: 1)
        scene.scaleMode = .aspectFill
        self.view?.presentScene(scene, transition: sceneTransition)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        
        if footer.contains(touchLocation) {
            
            let location = touch.location(in: footer)
            
            
            if btnNext.contains(location) {
                
                goToScene(scene: getNextScene()!)
            
            } else if btnPrevious.contains(location) {
                
                goToScene(scene: getPreviousScene()!)
                
            } else if btnHome.contains(location) {
                
                goToScene(scene: SKScene(fileNamed: "TitlePage") as! TitlePage)
            
            } else if btnSound.contains(location) {
                
                soundOff = !soundOff
            }
        
        } else {
            
            touchDown(at: touchLocation)
        }
    }
    
    override func didMove(to view: SKView) {
        
        if let textAudio = textAudio {
            
            let wait = SKAction.wait(forDuration: 0.2)
            let play = SKAction.play()
            textAudio.run(SKAction.sequence([wait, play]))
        }
    }
}
