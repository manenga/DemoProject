# DemoProject
A JSON Parsing iOS framework with Showcase App
built by Manenga Mungandi


## Purpose
DemoSDK is a framework that loads JSON files either locally or by url. It parses the json and creates models for city, 
mall and shop. The SDK provides methods to query data 

## Usage
```swift
let demo = DemoSDK.createSDK(from: "sample") // loading a JSON file locally

let cities = demo.getCities()
let shops  = demo.get(object: .shops, cityName: "Durban")) // get all shops in Durban
```

## Running the Showcase App
Open the DemoProject.xcodeproj file and run the project.
