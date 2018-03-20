import SpriteKit
import PlaygroundSupport

/*:
 # Welcome to "Who Wants to Be a Developer"
 
 In this playground you will learn about the programming language [Swift](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/),
 by answering questions based on a variation of the popular _Who Wants to Be a Millionaire_ game format. Whether you are a beginner, intermediary or expert, there is a game mode for you.
 
 My personal journey has taught me that anyone can achieve their goals, when they are taught in a fashion that suits their personal needs. What's more, breaking the ice is essential. Beginning easy but challenging and increasing the difficulty gradually will trigger the thirst for more, instead of creating frustration.
 
With this playful approach to learning [Swift](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/) and basics about object-oriented programming, anyone who enjoys diving into a new topic via a quiz like fashion, will feel right at home.
 If you have 3 minutes everyday to answer some questions, you will go far.
 
 > To get started open the live view inside the assistant editor. You can also add your own questions through the game interface, in order to get a more personalized learning experience. Or you hack the `Questions.json` file directly.
 
 __Enjoy and hopefully see you at WWDC 18__ ❤️
 */

// MARK: - Implementation

// the game is best played with a 2:1 aspect ratio
let frameWidth = UIScreen.main.bounds.width
let frameHeight = UIScreen.main.bounds.width / 2
let applicationFrame = CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight)
let applicationView = SKView(frame: applicationFrame)

let applicationScene = ApplicationScene()
applicationScene.scaleMode = .aspectFit
applicationView.presentScene(applicationScene)

PlaygroundPage.current.liveView = applicationView
