import SpriteKit
import PlaygroundSupport

/*:
 # Welcome to "Who Wants to Be a Developer"
 
 ### Dear Player, welcome to this Xcode Playground 🤗
 
 My personal journey has taught me that anyone can achieve their goals when their urge to find out more is tickled. Breaking the ice is essential. Beginning easy but challenging and increasing the difficulty gradually will create motivation, instead of frustration. This Playground aims at emulating such an experience.
 
You will be learning about object-oriented software development with [Swift](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/), by playing a variation of the popular _Who Wants to Be a Millionaire_ game format. This Playground is aimed at those who are just beginning to learn to code and want to solidify their knowledge in a playful way. Three minutes every day will already make a difference. The questions should inspire you to do some additional reading. Once you become more experienced you can dive into the underlying code itself and start altering the program to your liking or extend its functionality.
 
 However, this Playground is not limited to programming, but to your interests only. Due to its modularity, substituting your own set of questions is trivial. Pursue the instructions below to find out more.
 
 - IMPORTANT:
In order to use the "_Resume Game_" and "_Highscores_" features you need to create a directory with the name `Shared Playground Data` inside `~/Documents`. This directory needs to be created manually, Playgrounds cannot assist you due to [sandboxing](https://en.wikipedia.org/wiki/Sandbox_(computer_security)). Alternatively, you may execute the following 2 commands within a new _Terminal_ session:

- `cd ./Documents`
- `mkdir Shared\ Playground\ Data`
 
> __SETTING A USER NAME:__
 If you want to use your own name for highscore entries, you can modify the `PlayerName.txt` file, which is located inside the package contents of this playground at `WhotWantsToBeADeveloper/Resources/Data/PlayerName.txt`
 
 > __ADDING YOUR OWN QUESTIONS:__ You can also add your own questions by hacking the `Questions.json` file. The use of this human readable format enables you to create your personalized flashcard based learning experience. __*Pro Tip*__: Keep different files handy, so you can interchange them to study for all of your subjects.
 
 ### Enjoy and hopefully see you at WWDC 18 💜
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
