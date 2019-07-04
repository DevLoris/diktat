> This page explains how to add a new poster in the app.

## Assets

Each poster is composed of:
* The base poster (any width/height ratio)
* The different layers which will appear in AR

### Base poster
In `Resources/Assets.xcassets`:
* Put your base poster in the `AR Resources` folder and set its width to `1`
* Put your base poster in the `Posters` folder and append `__poster` to the resource name

### Image layers (include images used for Particles layers)
In `Resources/Assets.xcassets`:
* Create a new folder in the `Layers` folder with se same name as your poster (starting with a capital letter)
* Put all your image layers in this folder
* Prepend your resources name by `[poster_name]_`

### GIFs layers
In `Resources`:
* Create a new folder in the `Gifs` folder with se same name as your poster (starting with a capital letter)
* Put all your GIFs layers in this folder
* Prepend your resources name by `[poster_name]_`

### Videos layers
> Not yet implemented


## Config
The poster config files are hosted with the website of the project. So, you need to clone the website repository.

```shell
$ git clone https://github.com/Hugotgot/diktat-website.git
```

Create a new JSON file in the `public/api` folder.

### Config file template
```javascript
{
    "name": "[YOUR_POSTER_IDENTIFIER]", // Should be the name of the resource you had put in the assets 'AR Resource' folder
    "title": "[YOUR_POSTER_TITLE]",
    "subtitle": "[YOUR_POSTER_SUBTITLE]",
    "text": "[YOUR_POSTER_TEXT]",
    "layers": [
        {
            "id": "[LAYER_ID]",
            "type": "image", // Should be "image", "gif" or "particles"
            "material": "[LAYER_RESOURCE_NAME]", // Should be the name of the resource you had put in the assets folder
            "position": [0,0.1,0], // [x,y,z] values. Y axis is used for layer depth position
            "rotation": [0,0,0,0] ,
            "size": [1,1],
            "opacity": 1,
            "animation": null,
            "hidden_default": false,
            "click_event": []
        },
        // ...
    ]
}
```