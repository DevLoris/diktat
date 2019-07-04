## About

The AR feature contains all the poster detection, AR render process and interactions with the AR view. 

## Dependencies

* `ARKit`
* `SceneKit`
* `UIKit`


## Structure
### View Controllers

The main view controller and its extensions (ARSCNViewDelegate, ARSessionDelegate, TouchEvent). Executes following steps:

* Call the Loader feature to load the posters
* Init and start the ARSession 
* Listen to AR events (poster detections, focus left...)
* Render the layers of a detected poster
* Remove the layers of a lost poster
* Add detected poster to the history

### Models

All the models of each AR element and their data. Contains also some ARUtils used for position, size, touch events...

* `ImageNode`: Represents a poster. It contains the poster reference and all its layers.
* `CustomNodeLayer`: Base class for all the layers. Contains the initializers and some generic functions.


### Services

Contains the singleton which stores all the posters recognized by the app.