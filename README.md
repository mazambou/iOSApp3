
# iOSApp3 – Museum Navigation App

## Overview

This project was developed as part of the **MWD3A (iOS Development)** course at triOS College.

The application allows users to search and browse information from a museum collection using a public API. Visitors can discover artworks, view details, and navigate through museum content in a simple and intuitive interface.

## Features

- Search museum collections
- Retrieve data from an online API
- Display artwork information
- View artwork details
- Display artwork images
- Navigation between screens using SwiftUI
- Error handling for network requests
- Clean and commented code

## Technologies Used

- Swift
- SwiftUI
- Xcode
- REST API
- JSON Decoding
- URLSession
- Git & GitHub

## Project Structure

```text
iOSApp3
│
├── Models
│   ├── Artwork.swift
│   ├── SearchResponse.swift
│
├── Services
│   ├── MuseumService.swift
│
├── Views
│   ├── HomeView.swift
│   ├── SearchResultsView.swift
│   ├── ArtworkDetailView.swift
│
├── Resources
│
└── App Entry
    └── iOSApp3App.swift
```

## How It Works

1. The user enters a search term.
2. The app sends a request to the museum API.
3. Results are retrieved and decoded from JSON.
4. A list of artworks is displayed.
5. Selecting an artwork opens a detailed view with additional information.

## Learning Objectives

This project demonstrates:

- API integration
- Network requests using URLSession
- JSON parsing with Codable
- SwiftUI navigation
- State management
- Building reusable views
- Debugging and testing API-based applications



## Author

Marcel Azambou

## License

This project was created for educational purposes only.
