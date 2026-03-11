# 🚛 TransitTracer

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" />
  <img src="https://img.shields.io/badge/BLoC-5eb1ff?style=for-the-badge&logo=bloc&logoColor=white" />
</p>

**TransitTracer** is a robust logistics platform built with Flutter, designed to connect clients with cargo drivers. It provides a seamless experience for creating, managing, and tracking transport orders across the EU, Italy, and Ukraine.

---

## ✨ Key Features

* 🌍 **Multi-language Support:** Native localization for **English, Ukrainian, and Italian** using `intl`.
* 📶 **Smart Offline Mode:** Utilizes Firebase Persistence and `internet_connection_checker_plus` to handle unstable connections gracefully with specialized UI banners.
* 📍 **Advanced Location Services:** Integrated city search and autocomplete features for precise logistics routing.
* 👤 **Profile Management:** Full user profile customization, including image uploading and cropping (`image_picker` & `image_cropper`).
* 🌓 **Modern UI/UX:** Responsive design using `auto_size_text` and `cached_network_image` for a polished look.

---

## 🏗 Architecture & Engineering

The project follows a **Feature-First Clean Architecture** approach, ensuring the codebase is scalable, testable, and maintainable.

### Technical Excellence:
* **State Management:** Powered by **BLoC/Cubit** for clear separation of business logic and UI.
* **Dependency Injection:** Managed via **GetIt** for efficient service decoupling.
* **Type-Safe Routing:** Implementation of **AutoRoute** for declarative and compile-time safe navigation.
* **Enum-Based Validation:** A custom, scalable validation engine for forms (Auth, Orders) that supports localized error handling.
* **Network Layer:** Robust API communication handled by **Dio** with centralized error interceptors.

---

## 🛠 Tech Stack

| Category | Technology |
| :--- | :--- |
| **Framework** | Flutter |
| **State Management** | BLoC / Cubit / Equatable |
| **Backend** | Firebase (Auth, Firestore, Storage) |
| **Navigation** | AutoRoute |
| **Local Storage** | Shared Preferences |
| **DI** | GetIt |
| **Networking** | Dio |

---

## 📂 Project Structure

```text
lib/
 ├── app/             # App entry, DI setup (GetIt), and AutoRouter
 ├── core/            # Global shared resources
 │    ├── data/       # Global Repositories & Models
 │    ├── services/   # Network, Env, Geo, and AppInfo services
 │    ├── error_handlers/ # Specialized Firebase & Geo error logic
 │    ├── validators/ # Enum-based type-safe validation system
 │    └── theme/      # Custom design system & styles
 ├── features/        # Business logic modules
 │    ├── auth/       # Authentication & Authorization
 │    ├── orders/     # Complex order management (CRUD)
 │    ├── profile/    # User settings and profile data
 │    └── settings/   # Localization and theme toggling
 └── l10n/            # Localization files (.arb)

---

## 📸 Application Demo

<p align="center">
  <img src=".github\assets\auth_validation_demo.gif" width="350" alt="Auth & Validation Demo">
</p>

<p align="center">
  <i>Example: Comprehensive form validation and Firebase Auth flow.</i>
</p>

---

## 🚀 Getting Started

1. **Clone the repository:**
   git clone https://github.com/slavean-dev/transit_tracer

2. **Install dependencies:**
   flutter pub get

3. **Generate Routes:**
   dart run build_runner build --delete-conflicting-outputs