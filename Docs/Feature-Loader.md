## About

The loader feature is used to retrieve all the configuration files hosted in the server. Then, it converts each configuration into a poster and its layers, ready to be used by the AR feature.

## Dependencies

* `Alamofire`


## Structure
### Services

* `NetworkManager`: Retrieve the JSON data response from a given url.
* `ConvertToNodeLayer`: Convert JSON data to poster and its layers and populate them.

### Models

Contains the models expected from the JSON responses.