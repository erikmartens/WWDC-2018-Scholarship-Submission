The core technology for my quiz-game is SpriteKit. As an iOS developer with a focus on productivity apps, I did not have any prior experience with this framework. Typically I work with UIKit, CoreLocation, MapKit or Foundation. Therefore I had to get familiar with SpriteKit before crafting my idea. To keep things manageable I decided to intertwine with iOS by using its frameworks for user input and making it the platform the Playground runs on.

When developing the Playground I began by building the contents of my screens programmatically using SKSpriteKitNodes. The screens' child nodes are built with custom classes that inherit from SKNodes and their subclasses. For example, my Buttons are SKShapeNode subclasses that contain a SKLabelNode and a filltexture. This allowed me to easily reuse them and to set new backgrounds to highlight button clicks and marking answers. A cool feature I built in is that tapping a button and dragging out of it before releasing will not result in a selection. The filltextures behave accordingly.

As my plan is to release this Playground to other learners via GitHub after the scholarship judging process, I wanted to build on a solid foundation by implementing a proven architecture. Surely such a small project could be concluded with simpler means, but ensuring extendability and maintainability were important to me. My choice was the model-view-controller pattern since I am very familiar with it due to my previous projects. For a few screens of my game, it may seem to be curious (as for example a particular model class only consists of a single computed property with an implicit initializer), but I wanted to adhere to the principles throughout. 

I made use of the delegation pattern in order to correctly spread responsibilities and create a separation of concerns. The game is initialized using the ApplicationMainController class. It is the main delegate for the application and is responsible for initializing the different controllers of the game. The ApplicationMainController is injected into the game's controllers via the ApplicationDelegate protocol. The controllers then tell the delegate when they want their view to be loaded into the Playground's live-view or when they should be removed. Both the architecture the delegation of tasks make the game very modular. This coupled with the architecture should improve extendability, which would be interesting for those who would like to learn by tinkering with the game and by building upon it.

The third pillar of modularity is the use the FileStorageService, which is based on the FileManager class. With my quiz-game, I really disliked the idea of hard coding questions. Therefore they now live in a JSON-file and can easily be exchanged or added to. This is great for learners who want to take the game for what it is and study by playing it. The GameModel uses the FileStorageService to load the questions using custom DTOs and Codables and then provides them to the GameController. From there a question is randomly loaded into the view for each round.