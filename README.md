# pain_drain_mobile_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

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
├── services
│   │   All API functions and logic.
│
├── utils
│   │   Functions used throughout the app like global functions. Examples: input validation, image capture, themes, global variables, etc.
│
└── widgets
    │   These are global widgets used throughout the app multiple times. Examples: buttons, text fields, etc.

main.dart
│   Entry point for app.
```


