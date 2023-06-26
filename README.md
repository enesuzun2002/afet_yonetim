# Disaster Management App

This Flutter application is designed to provide a disaster management solution that allows users to report their location along with relevant information such as phone number and photos. It utilizes various packages to enhance functionality, including Firebase, Flutter Riverpod, Geolocator, and ObjectBox.

## Features
The Disaster Management App offers the following key features:

### 1. Location Reporting

📍 Users can report their current location in the event of a disaster or emergency situation. The app utilizes the Geolocator package to retrieve the user's GPS coordinates. Additionally, users can provide their phone number and attach relevant photos to provide more information about the situation.

### 2. Location Reports Listing

📋 The app allows users to view a list of location reports submitted by themselves and others. This feature enables users to stay informed about ongoing situations and helps authorities efficiently manage resources and response efforts.

### 3. Personal Information Validation

🔍 The app includes a feature for validating personal information using the Nüfus ve Vatandaşlık İşlemleri Müdürlüğü API. This API provides a service to validate Turkish citizens' identification numbers (T.C. Kimlik No) using the TCKimlikNoDogrula method. This validation feature ensures that the provided personal information is accurate and helps maintain the integrity of user data. Our backend calls this API.

## Packages Used

The Disaster Management App integrates the following Flutter packages:

### 1. Firebase

🔥 Firebase provides a comprehensive suite of tools and services for building mobile applications. In this app, Firebase is utilized for various purposes such as user authentication, storage of location reports, and real-time updates.

### 2. Flutter Riverpod

🌊 Flutter Riverpod is a state management library that simplifies the process of managing and sharing application state in Flutter. It helps organize and maintain the app's data flow, ensuring efficient and scalable development.

### 3. Geolocator

🌍 The Geolocator package offers a simple yet powerful API to retrieve the device's location using GPS or network providers. It enables accurate location reporting functionality in the app.

### 4. ObjectBox

📦 ObjectBox is a fast and efficient NoSQL database for Flutter. It provides a scalable and performant solution for storing and retrieving data. In this app, ObjectBox is used to store and manage location reports.

## Getting Started

To get started with the Disaster Management App, follow the steps below:

1. Clone the repository to your local machine:

    	git clone https://github.com/enesuzun2002/afet_yonetim.git

2. Ensure you have Flutter and Dart installed on your machine. If not, refer to the Flutter documentation for installation instructions.

3. Install the project dependencies by running the following command in the project's root directory:

        flutter pub get

4. Configure Firebase for your project by creating a new Firebase project and setting up the necessary services, Storage (Only used for saving the photos). Refer to the Firebase documentation for detailed instructions.

5. Update the Firebase configuration file in the project to connect to your Firebase project. The file is typically located at ./android/app/google-services.json for Android and ./ios/Runner/GoogleService-Info.plist for iOS.

6. Run the app on a simulator or physical device using the following command:

        flutter run

## Contributing

Contributions to the Disaster Management App are welcome! If you encounter any issues or have suggestions for improvements, please open an issue in the GitHub repository. Additionally, feel free to submit pull requests to contribute new features or bug fixes.

When contributing, please ensure that you follow the existing code style and guidelines. Add appropriate tests for new features and ensure that all existing tests pass successfully.

## License

The Disaster Management App is released under the MIT License. You are free to modify and distribute this software for both commercial and non-commercial purposes. Refer to the LICENSE file for more information.

## Acknowledgments

We would like to express our gratitude to the contributors of the packages used in this project, as their work greatly enhances the functionality and development experience of the Disaster Management App.
