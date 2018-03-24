import SpriteKit
import PlaygroundSupport

/*:
 # Welcome to "Who Wants to Be a Developer"
 
 In this playground you will learn about the programming language [Swift](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/), as well as about Apple development frameworks,
 by playing a variation of the popular _Who Wants to Be a Millionaire_ game format. If you have 3 minutes everyday to answer some questions, you will solidify your knowledge and/or be inspired to do some additional research.
 
 My personal journey has taught me that anyone can achieve their goals, when they are taught in a fashion that suits their personal learning style. What's more, breaking the ice is essential. Beginning easy but challenging and increasing the difficulty gradually will trigger the thirst for more, instead of creating frustration.
 
With this playful approach to learning [Swift](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/) and the basics about devloping for Apple's platforms, anyone who enjoys diving into a new topic via a quiz like fashion, will feel right at home.
 
 > __IMPORTANT:__ To use the "_resume game_" and the "_highscores_" feature you need to create a directory with the name `Shared Playground Data` inside `~/Documents`. This directory needs to be created manually, Xcode cannot assist you due to sandboxing.

> __DID YOU KNOW?:__ You can also add your own questions by hacking the `Questions.json` file.
 
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
