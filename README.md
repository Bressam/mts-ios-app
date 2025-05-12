# Challenge Project - MTS: My TVmaze Shows

## Giovanne Bressam Gaspareto

Email: [giovannebressam@gmail.com](mailto:giovannebressam@gmail.com)

## Challenge Topics Done

* All required topics.
    * Series Listing:
        * Displays all series using API paging.
        * Allows searching for series by name.
        * Shows series name and poster image.
    * Series Details:
        * Shows name, poster, airing days/times, genres, summary.
        * Lists episodes, grouped by season.
    * Episode Details:
        * Displays episode name, number, season, summary, and image (if available).

## Extra Topics Done

* PIN Security (Biometric + PIN Lock fallback).

## Personal Improvements

* Top-notch modular architecture to improve build time and maintain full decoupling.
* Testing Modules: Exposed test doubles and utils, making testing any module easy.

## GitFlow Used

* Branching Strategy:

  * `main` - Production-ready code.
  * `develop` - Ongoing development.
  * `feat/{feature_description}` - Feature branches.
  * `task/{feature_description}/{task_description}` - Task branches.
* Feature branches are merged into `develop`.
* Task branches are merged into their respective feature branches.

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

1. Open the project in Xcode.
2. Select the target device (Simulator or Physical Device).
3. Build and Run (`Cmd + R`).

