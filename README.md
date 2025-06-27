# MTS: My TVmaze Shows

| Light & Dark Themes   |      Basic Flow      |
|----------|-------------|
| <img width=300px src="https://github.com/Bressam/mts-ios-app/blob/hotfix/updated-readme-and-resources/Resources/mts-dark-light-mode.gif"> |  <img width=300px src="https://github.com/Bressam/mts-ios-app/blob/main/Resources/mts-listing-details.gif"> |

## Project Features
* Series Listing View:
    * **Seamless Infinite scroll**: Displays all series using API paging.
    * **Complete Search** for series by name
         * Search results combine local and remote results for improved UX.
         * Includes debounce for improved performance.
    * Includes series name, poster image, rating and current status.
* Serie's Detail View:
    * Includes name, poster, airing days/times, genres, summary.
    * Lists episodes, grouped by season, including thumbnail and description.
* Episode Details View:
    * Displays episode name, number, season, summary, and image (if available).
* PIN Security & Settings View:
    * User can enable PIN security on Settings and set a PIN.
    * If enabled, blocks the app until the user authenticates using PIN or Biometric.
    * PIN Validation uses device biometrics (FaceID or TouchID) + manual PIN fallback.

## Archtectural Benefits (TMA/Features + Clean + MVVM-C)
* Scalable Design: The application is highly scalable, designed to accommodate future growth without sacrificing performance or maintainability, containing modules completely decoupled from each other behavior and details.
* Top-notch modular architecture to optimize build times and ensure full decoupling. By depending solely on interfaces, implementation modules can leverage build cache, significantly reducing build times, improving pipelines times and development team productivity.
* Testing Modules: A module exclusively used to expose test doubles, mocks, and utilities, making module testing straightforward and enabling easy preview stubbing for consistent behavior.

## Modules created and its benefits
* TVShowListingFeature: A fully decoupled feature responsible for displaying the series list and detailed show information.
* SecurityFramework: Enables any feature to easily request user authentication, either using biometrics or PIN.
* ValidationKit: Provides a simple way for any feature to present the default authentication view, blocking current flow until authentication is performed.
* NetworkCore: Centralizes request creation and logic, making it easy to maintain and extend.
* CoordinatorKit: Establishes a standard for navigation, making it extremely easy to present child flows (features presenting other features) while only knowing their interfaces.

## GitFlow Used
* Branching Strategy:

  * `main` - Production-ready code.
  * `develop` - Ongoing development.
  * `feat/{feature_description}` - Feature branches.
  * `task/{feature_description}/{task_description}` - Task branches.
* Feature branches are merged into `develop`.
* Task branches are merged into their respective feature branches.

<img width=720px src="https://github.com/Bressam/mts-ios-app/blob/main/Resources/gitflow.png">

## Architecture

### TMA Dependency Table

| Target               | Dependencies            | Content                        |
| -------------------- | ----------------------- | ------------------------------ |
| **Feature**          | FeatureInterface        | Source code and resources      |
| **FeatureInterface** | -                       | Public interface and models    |
| **FeatureTests**     | Feature, FeatureTesting | Unit and integration tests     |
| **FeatureTesting**   | FeatureInterface        | Testing data, mocks, and spies |
| **FeatureExample**   | FeatureTesting, Feature | Example app for manual testing |

* A hybrid architecture using best practices:

  * **MVVM + Coordinators:** Manages UI and flow logic.
  * **Clean Architecture:** Splits each feature into Domain, Data, and Feature.
  * **Modularization (TMA/uFeatures):** Each feature is divided into Interface, Implementation, and Testing modules.
  * **Decoupled Features:** Each feature knows only the interfaces of other features or frameworks, improving build time.
  * **TMA Design:** Domain and Data are separate modules, making imports minimal and controlled.

## How to Run

1. Open the MTS.xcworkspace project in Xcode.
2. Select the MTS target and the desired device (Simulator or Physical Device).
3. Build and Run (`Cmd + R`).

## How to install on Simulator

1. Open the "Distribution" Folder:
    - Locate the Distribution folder at the root of the repository.
2. Launch iOS Simulator:
    - Open Xcode, then go to "Xcode > Open Developer Tool > Simulator".
3. Drag the App:
    - Drag the MTS.app file from the Distribution folder directly into the open Simulator window.
4. Run the App:
    - Once installation is complete, the app icon will appear on the Simulator's home screen.
    - Tap the app icon to launch it.
