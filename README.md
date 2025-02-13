# Flutter Todo App

A simple Flutter application following a feature-based architecture. This README describes the project's structure, how to get started, and how to run tests.

---

## Table of Contents

- [Overview](#overview)
- [Architecture Tree](#architecture-tree)
- [Getting Started](#getting-started)
- [Running the App](#running-the-app)
- [Running Tests](#running-tests)

---

## Overview

This **Todo App** demonstrates a typical Flutter architecture that separates concerns into **data**, **domain**, and **UI** layers. It uses:

- **BLoC (Business Logic Component)** for state management.
- **Repository pattern** to abstract data sources.
- **Feature-based** folder organization to keep code modular and scalable.

---

## Architecture Tree

Below is a simplified view of the folder layout:

# Project Structure

`````bash
.
├── ios/                                   # iOS platform code
├── lib/                                   # Flutter source code
│   ├── core/                              # Core functionality
│   │   └── env/                           # Environment variables, config, etc.
│   ├── feature/                           # Feature-based modules
│   │   └── todo/                          # "todo" feature
│   │       ├── data/                      # Data layer
│   │       │   ├── api/                   # API services
│   │       │   │   └── todo_api_repo.dart # Implementation of the Todo API
│   │       │   ├── model/                 # Data models
│   │       │   │   └── task_model.dart    # Task model definition
│   │       │   └── repository/            # Repository for data access
│   │       │       └── todo_repo.dart     # Implementation of the Todo repository
│   │       ├── domain/                    # Domain layer
│   │       │   └── entity/                # Domain entities
│   │       └── ui/                        # Presentation layer (UI)
│   │           ├── bloc/                  # BLoC classes
│   │           │   └── task_bloc.dart     # BLoC for tasks
│   │           ├── components/            # Reusable UI components
│   │           │   └── feedback/
│   │           │       └── add_task_dialog.dart  # Dialog for adding tasks
│   │           └── screen/                # Screens
│   │               └── todo_screen.dart    # Main Todo screen
│   ├── app_provider.dart                   # Provides app-wide dependencies
│   └── main.dart                           # Entry point of the Flutter app
├── linux/                                  # Linux platform code
├── macos/                                  # macOS platform code
└── test/                                   # Test files
    └── feature/
        └── todo/
            ├── data/
            │   └── api_test.dart          # Tests for the API layer
            └── ui/
                └── bloc/
                    └── task_bloc_test.dart # Tests for the task BLoC


### Key Folders

- **core/env**: Configuration and environment-related files.
- **feature/todo/data**: Handles data operations (APIs, models, repositories).
- **feature/todo/domain**: Contains domain entities (and potential use cases or logic not tied to UI).
- **feature/todo/ui**: UI layer, including screens, widgets, and BLoC classes for state management.
- **test/feature/todo**: Unit and widget tests for the `todo` feature.

---

## Getting Started

1. **Clone the repository**:
  ````bash
   git clone https://github.com/Makarov96/todo-list-task
`````

2.  **Navigate to the repo**:
    ```bash
    cd todo-list-task
    ```
3.  **Install depedencies**:
    ```bash
    flutter pub get
    ```
4.  **Create files**:
    ### You must to create the following files:
        *  google-services.json  -> android/app/google-services.json
        *  GoogleService-Info.plist -> ios/Runner/GoogleService-Info.plist
        *  envs.json -> todo_list/envs/env.json
    The content of the above files you will be able to check into a pdf provided by developer
5.  **Run project**:
    ```bash
    flutter run --dart-define-from-file=envs/env.json
    ```
