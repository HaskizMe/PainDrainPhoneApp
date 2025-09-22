# Pain Drain Mobile App

A new Flutter project.

## Getting Started

Follow this guide to get started with setting up flutter on your local machine. [Flutter Setup Guide](https://docs.flutter.dev/get-started/install)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# File Structure for Pain Drain App

```plaintext
assets
│   Contains pictures, logos, etc. Mainly just static images.
    
fonts
│   Contains all fonts.
    
functions (optional)
│   Can use this for cloud functions. For example, functions for Firebase.

lib
│   Main folder for flutter code.
│
├── models
│   │   All classes and objects like event class, Bluetooth class, etc.
│
├── screens
│   │   Contains all the screens of the app.
│   │
│   ├── screen_name_1
│   │   ├── local_widgets
│   │   │   Widgets used specifically for that screen and used once throughout the app. 
│   │   │   If used more than once, then put it in the widgets folder.
│   │   └── screen_name_1.dart
│   │
│   └── screen_name_2
│       ├── local_widgets
│       └── screen_name_2.dart
│
│
├── utils
│   │   Functions used throughout the app like global functions. Examples: input validation, image capture, themes, global variables, etc.
│
└── widgets
    │   These are global widgets used throughout the app multiple times. Examples: buttons, text fields, etc.

main.dart
│   Entry point for app.
```


# Environment 

### Required
- Flutter SDK
- Android Studio
- Xcode (for iOS)

For development I use Android Studio and Xcode (for iOS). You can also use VSCode which is also very common.

### Prerequisites

Before running or contributing to this project, please review the following:

### Versions
This project was built and tested with the following versions:  
- **Flutter**: 3.24.1 (channel: stable)  
- **Dart**: 3.5.1  
- **DevTools**: 2.37.1
- **Gradle wrapper**: 8.4  
- **Kotlin**: 1.9.10  
- **Xcode**: 15.4  
- **CocoaPods**: 1.16.2  
- **Ruby**: 3.3.4 with Bundler 2.5.14  

> ⚠️ Please use these versions (or as close as possible) for the smoothest setup.

### Debug Flags
In `lib/utils/globals.dart` you will find two debug flags:

- These control whether the app actually uses Bluetooth or not **NOTE: if not in debug mode you need a physical device since you can't use Bluetooth on an emulator and won't get past the connect screen**.  
- This allows you to view and test the UI **without a physical device**.  
- Toggle these flags as needed during development.

### Code Generation
This project uses the **freezed** and **riverpod** packages, which require code generation.  
Run the following commands whenever you modify models, providers, or related annotations:

```bash
# One-time build
flutter pub run build_runner build --delete-conflicting-outputs

# Or, watch for changes
flutter pub run build_runner watch --delete-conflicting-outputs
```

Flutter has pretty good documentation so please follow it for more information. 


## Running the App

Follow these steps to run the project on your local machine:

### 1. Install Dependencies
Fetch all Dart and Flutter packages:  
```bash
flutter pub get
```

### 2. iOS Setup (macOS only)
If you are building for iOS, install CocoaPods inside the ios directory:

```bash
cd ios
pod install
cd ..
```

### 3. Run the App
```bash
flutter run
```

