# DemoProject
A JSON Parsing iOS framework with Showcase App
built by Manenga Mungandi


## Purpose
DemoSDK is a framework that loads JSON files either locally or by url. It parses the json and creates models for city, 
mall and shop. The SDK provides methods to query data 

## Usage
```swift

let cities = DemoSDK.shared.getCities()
let shops  = DemoSDK.shared.get(object: .shops, cityName: "Durban")) // get all shops in Durban

```

## Running the Showcase App
Open the DemoProject.xcodeproj file and run the project.

## Contributing
Pull requests are welcome. 
For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
