# Challenge Project - MTS: My TVmaze Shows

## Giovanne Bressam Gaspareto

Email: [giovannebressam@gmail.com](mailto:giovannebressam@gmail.com)

## Challenge Topics Done

* All required topics.
    * Series Listing:
        * Displays all series using API paging.
        * Seamless infinite scroll.
        * Allows searching for series by name (combining local and remote fallback results).
        * Shows series name and poster image.
    * Series Details:
        * Shows name, poster, airing days/times, genres, summary.
        * Lists episodes, grouped by season.
    * Episode Details:
        * Displays episode name, number, season, summary, and image (if available).

## Bonus Topics Done

* PIN Security.
* PIN Validation: Biometric + PIN Lock fallback.

## Personal Bonus Topics & Improvements

* Scalable Design: The application is highly scalable, designed to accommodate future growth without sacrificing performance or maintainability, containing modules completely decoupled from each other behavior and details.
* Top-notch modular architecture to optimize build times and ensure full decoupling. By depending solely on interfaces, implementation modules can leverage build cache, significantly reducing build times, improving pipelines times and development team productivity.
* Settings View: allow user to set or remove a PIN.
* Testing Modules: Exposed test doubles, mocks, and utilities, making module testing straightforward and enabling easy preview stubbing for consistent behavior.
* Extra details on Shows Listing, including: categories, status and rating.

## Modules created and its benefits

* TVShowListingFeature: A fully decoupled feature responsible for displaying the series list and detailed show information.
* SecurityFramework: Enables any feature to easily request user authentication, either using biometrics or PIN.
* ValidationKit: Provides a simple way for any feature to present the default authentication view.
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
