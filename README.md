# watch-mode-movies-tvshows
This SwiftUI-based iOS application fetches and displays a list of movies and TV shows using the WatchMode API. The app follows the MVVM architecture and utilizes Combine for efficient data fetching and error handling.
Architecture

Implements MVVM (Model-View-ViewModel) architecture for separation of concerns.

Features

Home Screen

Fetch and display a list of movies & TV shows from the WatchMode API.

Toggle button or tab navigation to switch between Movies and TV Shows.

Uses LazyVStack for smooth scrolling performance.

Shimmer/redacted effect for skeleton loading state.

Details Screen

Clicking on an item navigates to a detailed view.

Displays title, description, release date, and poster image.

API Integration

url session to perform two API calls simultaneously (fetching movies and shows together).

Error Handling

Handles errors gracefully using SwiftUI alerts.
