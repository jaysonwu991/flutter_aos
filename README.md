# flutter_aos

A professionally-architected Flutter authentication application featuring clean code architecture, state management, and modern Flutter best practices.

## Project Overview

This Flutter application provides a complete authentication user interface with login and registration pages. The project has been completely refactored to follow **expert-level Flutter development practices** including:

- ✅ **Clean Architecture** - Layered structure with clear separation of concerns
- ✅ **State Management** - Provider pattern for reactive state handling
- ✅ **Modern Routing** - go_router for type-safe navigation
- ✅ **Comprehensive Validation** - Regex-based form validation
- ✅ **Reusable Components** - DRY principles with shared widgets
- ✅ **Constants Management** - Centralized strings, colors, and dimensions
- ✅ **Professional Logging** - Structured logging with the logger package
- ✅ **Responsive Design** - MediaQuery-based layouts that adapt to screen sizes
- ✅ **Type Safety** - Full null safety with proper typing
- ✅ **Code Quality** - Comprehensive linting with analysis_options.yaml

## Features

### Authentication Flow
- **Registration Page** - Complete signup flow with phone number, password confirmation, and verification code
- **Login Page** - Streamlined login with phone and password
- **Area Code Selection** - Support for multiple regions (+86, +852, +853, +886)
- **Password Visibility Toggle** - User-friendly password input
- **Form Validation** - Real-time validation with helpful error messages
- **Loading States** - Visual feedback during async operations
- **Error Handling** - User-friendly error messages via SnackBars

### Technical Features
- Provider-based state management
- Named route navigation with go_router
- Proper form validation (phone numbers, passwords, verification codes)
- Responsive UI with ConstrainedBox and MediaQuery
- Professional logging system
- Material Design 3 theming

## Project Structure

```
lib/
├── main.dart                                  # Application entry point
├── app.dart                                   # Root widget with Provider & Router setup
├── config/
│   └── routes/
│       └── app_router.dart                    # go_router configuration
├── constants/
│   ├── app_strings.dart                       # All UI strings (42 constants)
│   ├── app_colors.dart                        # Color palette and theming
│   ├── app_dimens.dart                        # Spacing & sizing constants
│   └── area_codes.dart                        # Country/region codes
├── utils/
│   ├── validators.dart                        # Form validation logic (6 validators)
│   └── app_logger.dart                        # Logging utility
└── presentation/
    ├── pages/
    │   ├── login/
    │   │   ├── login_page.dart                # Login page layout
    │   │   ├── login_form.dart                # Login form widget
    │   │   └── login_image.dart               # Login branding
    │   └── register/
    │       ├── register_page.dart             # Registration page layout
    │       ├── register_form.dart             # Registration form widget
    │       └── register_image.dart            # Registration branding
    ├── providers/
    │   ├── auth_provider.dart                 # Authentication state management
    │   └── form_provider.dart                 # Form state management
    └── widgets/
        └── common/
            ├── custom_text_form_field.dart    # Styled text input
            ├── custom_button.dart             # Styled buttons
            └── area_code_picker.dart          # Reusable area code dropdown
```

## Requirements

- **Flutter SDK**: 3.0.0 or higher
- **Dart SDK**: 3.0.0 or higher
- iOS 11.0+ / Android API Level 21+

## Getting Started

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd flutter_aos
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run
```

### Building for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## Dependencies

### Core Dependencies
- `flutter` - Flutter SDK
- `cupertino_icons` (^1.0.8) - iOS-style icons
- `provider` (^6.1.1) - State management
- `go_router` (^14.6.2) - Declarative routing
- `logger` (^2.0.2+1) - Structured logging

### Dev Dependencies
- `flutter_test` - Flutter testing framework
- `flutter_lints` (^5.0.0) - Recommended linting rules

## Architecture Highlights

### State Management with Provider

The app uses Provider for state management with two main providers:

- **AuthProvider** - Manages authentication state (login, register, logout)
- **FormProvider** - Manages form-specific state (area code, password visibility)

### Routing with go_router

Named routes for type-safe navigation:
```dart
context.go(AppRoutes.login);    // Navigate to login
context.go(AppRoutes.register); // Navigate to register
```

### Form Validation

Comprehensive validators in [lib/utils/validators.dart](lib/utils/validators.dart):
- Phone number validation (8-15 digits)
- Password strength (6+ chars, letters + numbers)
- Password confirmation matching
- 6-digit verification code validation
- Email validation
- Required field validation

### Reusable Widgets

All common UI components are extracted:
- `CustomTextFormField` - Consistent styled input fields
- `CustomButton` - Styled buttons with loading states
- `AreaCodePicker` - Dropdown for country/region selection

## Development

### Running Tests
```bash
flutter test
```

### Code Analysis
```bash
flutter analyze
```

### Code Formatting
```bash
flutter format lib/
```

## Code Quality

This project follows Flutter best practices:

✅ No code duplication
✅ Package imports (not relative imports)
✅ Proper null safety
✅ const constructors where possible
✅ Trailing commas for better formatting
✅ Comprehensive documentation
✅ Alphabetically sorted imports
✅ Proper error handling
✅ No debug print() statements in production

## Assets

Custom image assets located in:
- `assets/imgs/` - Contains login logo and UI images

## Refactoring Changes

This project was completely refactored from a basic proof-of-concept to expert-level code:

### What Was Improved
1. **Architecture** - From flat structure to clean layered architecture
2. **State Management** - From setState() to Provider pattern
3. **Routing** - From manual Navigator.push to go_router with named routes
4. **Code Reuse** - Eliminated duplicate AreaCodePicker and form widgets
5. **Constants** - Extracted all hardcoded values to constants files
6. **Validation** - From empty checks to comprehensive regex validation
7. **Logging** - Replaced print() with professional Logger
8. **Responsive Design** - From fixed 800px to responsive ConstrainedBox
9. **Type Safety** - Removed force unwraps and improved typing
10. **Code Quality** - Added analysis_options.yaml with 150+ lint rules

## Resources

For Flutter development resources:

- [Flutter Documentation](https://flutter.dev/docs) - Official documentation
- [Provider Package](https://pub.dev/packages/provider) - State management
- [go_router Package](https://pub.dev/packages/go_router) - Routing
- [Flutter Cookbook](https://flutter.dev/docs/cookbook) - Useful Flutter samples
- [API Reference](https://api.flutter.dev/) - Complete API documentation

## Version

Current version: **2.0.0+1**

See [CHANGELOG.md](CHANGELOG.md) for detailed version history and migration guide.

## License

This project is a Flutter application template. Please add your license information here.
