# task_project

### E-Commerce Product Listing App

A Flutter e-commerce application that displays products from FakeStoreAPI
with search, filtering, and sorting capabilities. The app implements pagination, 
offline caching, and follows a clean architecture pattern using GetX for state management.

## Getting Started

### E-Commerce Product Listing App

A Flutter e-commerce application that displays products from FakeStoreAPI with search, filtering, and sorting capabilities. The app implements pagination, offline caching, and follows a clean architecture pattern using GetX for state management.


## Features

- **Product List**

- Fetches products from FakeStoreAPI
- Displays products in a responsive grid layout
- Implements pagination with "load more" on scroll
![Product list](https://github.com/user-attachments/assets/d2f914a7-c02f-4046-abb8-a3eba274f31f)



- **Search & Filters**

- Search products by name in real-time
- Sort products by:

- Price (Low to High)
- Price (High to Low)
- Rating

![search](https://github.com/user-attachments/assets/21eb00f5-b7ba-4daf-8514-8b931e306250)

![sorting by filter](https://github.com/user-attachments/assets/9cb0e41e-658b-4096-a2b2-dc6fdf904348)




- **State Management**

- Uses GetX for reactive state management
- Minimizes rebuilds with Obx and .obs variables



- **Offline-First Approach**

- Caches API responses using Hive
- Shows cached data when offline
- Displays offline notification via snackbar
Technical Implementation

### Key Components

- **HomeController**: Manages product state, search, filtering, and pagination
- **NetworkCaller**: Handles API requests with proper error handling
- **LocalStorageService**: Manages caching with Hive
- **Custom Widgets**: Reusable components for consistent UI


## Getting Started

### Prerequisites

- Flutter SDK 
- Dart SDK 
- An IDE (Android Studio)


### Installation

1. Clone the repository:git clone https://github.com/zihadsikder/task_project
- cd task_project

