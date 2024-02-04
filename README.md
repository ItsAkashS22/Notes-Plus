<div align="center">
  <img src="https://github.com/ItsAkashS22/Notes-Plus/blob/main/assets/logo.png?raw=true" alt="Project Image">
</div>

# Notes Plus - Unleash Your Creativity, Capture Your Ideas
*Effortlessly capture thoughts, plans, and more – online or offline – with Notes Plus, a modern note-taking app built for seamless organization and cloud synchronization.*

* **Always accessible:** Capture and edit notes even without an internet connection.
* **Never lose a thought:** Notes automatically sync across devices when you reconnect.
* **Personalize your environment:** Choose between light and dark themes.
* **Sign in with ease:** Use your existing Google account for secure and convenient access.
* **Reliable storage:** Enjoy peace of mind with local data management using SQLite.
* **Cloud backups:** Ensure your notes are always accessible with Firebase Firestore.
* **Express yourself:** Choose from a variety of fonts to suit your style.
* **Find notes instantly:** Leverage the powerful search bar to pinpoint specific content.


# Download APK(s)

| Type                        | Description                                       | Download Link                                     |
| --------------------------- | ------------------------------------------------- | ------------------------------------------------- |
| **app-arm64-v8a-release.apk** | For ARM 64-bit architecture devices.            | [Download ARM64 APK](https://github.com/ItsAkashS22/Notes-Plus/raw/main/APKs/app-arm64-v8a-release.apk)               |
| **app-armeabi-v7a-release.apk** | For ARM 32-bit architecture devices.          | [Download ARMv7 APK](https://github.com/ItsAkashS22/Notes-Plus/raw/main/APKs/app-armeabi-v7a-release.apk)               |
| **app-x86_64-release.apk**   | For x86 64-bit architecture devices.             | [Download x86_64 APK](https://github.com/ItsAkashS22/Notes-Plus/raw/main/APKs/app-x86_64-release.apk)             |


# Key Features

* **Offline-first:** Create and edit notes even without an internet connection.
* **Cloud sync:** Your notes automatically sync across devices when you reconnect.
* **Light & Dark Mode:** Choose a theme that suits your environment and preferences.
* **Google Sign-in:** Sign in quickly and securely with your existing Google account.
* **SQLite Storage:** Reliable local storage for peace of mind.
* **Firebase Integration:** Scalable cloud infrastructure for future growth.
* **Font Customization:** Express yourself with a variety of font options.
* **Powerful Search:** Instantly find notes using keywords or phrases.

# Built Using Flutter
Native performance on Android and iOS with cross-platform development.

* **SQLite:** Reliable and efficient local data storage.
* **Firebase Firestore:** Scalable cloud storage and synchronization.
* **Google Sign-in:** Secure and convenient authentication.


# State Management with Flutter Bloc

Notes Plus utilizes the Flutter Bloc library for efficient state management. Flutter Bloc is a predictable state management library that helps in organizing and managing the state of the application, making it easier to handle complex UI interactions. The use of Flutter Bloc ensures a clear and maintainable separation of concerns in the app's architecture, enhancing code readability and scalability.


# Get Started

1. **Prerequisites:**

    * Flutter development environment - [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
    * Firebase project with enabled Firestore and Authentication - [https://console.firebase.google.com/](https://console.firebase.google.com/)
    * Flutter Bloc for state management - [https://pub.dev/packages/flutter_bloc](https://pub.dev/packages/flutter_bloc)


2. **Clone the repository:**
    ```bash
    git clone https://github.com/ItsAkashS22/Notes-Plus.git
    ```

3. **Install dependencies:**
    ```bash
    cd notes-plus
    flutter pub get
    ```

4. **Configure Firebase:**

    - Create a new project on [Firebase](https://console.firebase.google.com/).
    - Obtain the ```google-services.json``` file and place it in the android/app directory.
    - Enable Firestore and Authentication in the Firebase console.


5. **Run the app:**
    ```bash
    flutter run
    
# Folder Structure

- **`core/`:** Core functionality or business logic not specific to a feature. Common utilities, extensions, or base classes may reside here.

- **`models/`:** Contains data models representing the structure of the application's data.

- **`repositories/`:** Manages data fetching, storage, and communication with external sources. Repositories abstract the data layer.

- **`services/`:** Holds code related to various services, such as API calls, authentication, or other business logic not tied to a UI component.

- **`utils/`:** Includes utility functions or helper classes used throughout the application.

- **`views/`:** Houses UI components or screens of the application. Each screen may have its own Dart file within this folder.
    - **`<view>/bloc/`:** Contains Business Logic Components (BLoCs) associated with each view.

- **`widgets/`:** For reusable UI components or widgets shared across multiple screens.

- **`app.dart`:** Main application class or configuration, defining the top-level widget for the app.

- **`firebase_options.dart`:** Contains configuration options for Firebase services.

- **`main.dart`:** Entry point of the Flutter application. Contains the `main` function that kicks off the app.

# What Next

- [ ] Implement `BackgroundColor` & `TextColor` for Notes
- [ ] Refactor code & extract widgets in `views/`
- [ ] Logging of errors to `crashlytics`