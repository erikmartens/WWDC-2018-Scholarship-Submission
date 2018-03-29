import SpriteKit
import PlaygroundSupport

/*:
 # Welcome to "Who Wants to Be a Developer"
 
 Dear Player, welcome to this Xcode Playground 🤗
 
 In this playground you will be learning about object-oriented sowtware development [Swift](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/),
 by playing a variation of the popular _Who Wants to Be a Millionaire_ game format. Since I am personally an iOS centered developer, this Playground was built with focus on that platform, both regarding the questions you will find and the underlying code itself. But never fear, substituting your own set of questions is trivial. Pursue the instructions to find out more below.
 
 My personal journey has taught me that anyone can achieve their goals, when they are taught in a fashion that suits their personal learning style. What's more, breaking the ice is essential. Beginning easy but challenging and increasing the difficulty gradually will trigger the thirst for more, instead of creating frustration.
 
With this playful approach to learning, anyone who enjoys diving into a new topic via a quiz like fashion, will feel right at home. This Playground is only limited to your interests. You can learn just about anything else due to the modularity of this Playground. If you have 3 minutes everyday to answer some questions, you will solidify your knowledge and/or be inspired to do some additional research.
 
 - IMPORTANT:
To use the "_Resume Game_" and the "_Highscores_" feature you need to create a directory with the name `Shared Playground Data` inside `~/Documents`. This directory needs to be created manually, Playgrounds cannot assist you due to [sandboxing](https://en.wikipedia.org/wiki/Sandbox_(computer_security)). Or you execute the following 2 commands within a new _Terminal_ session:

- `cd ./Documents`
- `mkdir Shared\ Playground\ Data`

> __ADDING YOUR OWN QUESTIONS__ You can also add your own questions by hacking the `Questions.json` file. The use of this human readable format enables you to create your personalized flashcard based learning experience. __*Pro Tip*__: Keep different files handy, so you can interchange them to study for all of your subjects.
 
 __Enjoy and hopefully see you at WWDC 18__ 💜
 */

// MARK: - Implementation

// the game is best played with a 2:1 aspect ratio
let frameWidth = UIScreen.main.bounds.width
let frameHeight = frameWidth / 2
let applicationFrame = CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight)
let applicationView = SKView(frame: applicationFrame)
let mainController = ApplicationMainController(view: applicationView)

PlaygroundPage.current.liveView = applicationView
mainController.runApplication()


