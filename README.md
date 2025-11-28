# Flutter Guest Book - EI Digital Assignment

A responsive Flutter tablet application demonstrating Clean Architecture, BLoC pattern, and pixel-perfect UI implementation based on provided design screenshots.

## 🚀 Features

### ✨ UI & Design

- **Pixel-Perfect Implementation**: Exactly matches the provided screenshots
- **Responsive Design**: Works seamlessly across tablet sizes (600dp to 1366dp+)
- **Two-Panel Layout**: Left guest list panel and right detail panel
- **Interactive Panel**: Left panel collapses on right panel tap, expands with back button
- **Material Design**: Follows Flutter Material Design guidelines strictly

### 🏗️ Architecture

- **Clean Architecture**: Complete 3-layer separation (Data → Domain → Presentation)
- **BLoC Pattern**: State management with flutter_bloc
- **Dependency Injection**: get_it for complete DI setup
- **Functional Programming**: dartz for Either types and robust error handling

### 📱 Responsive System

- **4 Breakpoints**: Small (600-800dp), Medium (800-1024dp), Large (1024-1366dp), XL (1366dp+)
- **Auto-Scaling Text**: All text sizes scale automatically based on screen size
- **Responsive Spacing**: Padding and margins adapt to screen size
- **Dynamic Layout**: Panel sizes adjust based on available space

### 👥 Guest Management

- **Mock Data**: Realistic guest data matching screenshots (Lia Thomas, Bergnaum, etc.)
- **Search Functionality**: Real-time guest search with debouncing
- **Guest Selection**: Click to view detailed guest information
- **Rich Data Display**: Statistics, contact info, allergies, visit history

### 🏛️ Architecture Layers

#### Domain Layer (Business Logic)

```
lib/domain/
├── entities/guest_entity.dart          # Core Guest business object
├── repositories/guest_repository.dart  # Abstract repository interface
└── usecases/get_guests_usecase.dart   # Business logic operations
```

#### Data Layer (Data Access)

```
lib/data/
├── models/guest_model.dart                    # Data model with JSON serialization
├── datasources/guest_local_datasource.dart   # Mock data matching screenshots
└── repositories/guest_repository_impl.dart   # Repository implementation
```

#### Presentation Layer (UI & State)

```
lib/presentation/
├── bloc/                           # BLoC state management
│   ├── panel_bloc/                # Left panel expand/collapse
│   ├── guest_list_bloc/           # Guest data & selection
│   └── tab_bloc/                  # Tab navigation
├── pages/main_screen.dart         # Main application screen
└── widgets/                       # Reusable UI components
    ├── common/                    # DRY-compliant widgets
    ├── guest_list_panel.dart     # Left panel implementation
    ├── detail_panel.dart         # Right panel implementation
    └── guest_list_item.dart      # Individual guest items
```

### 🎯 Code Quality

#### DRY (Don't Repeat Yourself)

- **Reusable Widgets**: `ResponsiveText`, `ResponsivePadding`, `CustomCard`
- **Constants Extraction**: All colors, spacing, animations centralized
- **Utility Functions**: `DesignUtils`, `ResponsiveHelper` for common operations
- **Extension Methods**: Context and Widget extensions for DRY compliance

#### KISS (Keep It Simple, Stupid)

- **Single Responsibility**: Every class/function has one clear purpose
- **Readable Code**: Self-documenting with descriptive names
- **Simple Architecture**: Clean separation without over-engineering
- **Manageable Complexity**: Functions under 30 lines, widgets under 100 lines

## 🛠️ Technical Stack

### Dependencies

```yaml
dependencies:
  flutter_bloc: ^8.1.3 # State management
  get_it: ^7.6.4 # Dependency injection
  dartz: ^0.10.1 # Functional programming
  equatable: ^2.0.5 # Value equality
  google_fonts: ^6.1.0 # Montserrat typography
```

### Core Components

- **State Management**: BLoC pattern with proper event/state handling
- **Dependency Injection**: Complete get_it setup with proper scoping
- **Error Handling**: Functional approach with Either types
- **Responsive Design**: Automatic scaling across all screen sizes

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/          # All design constants extracted from screenshots
│   ├── di/                 # Dependency injection setup
│   ├── theme/              # Material theme matching design
│   ├── utils/              # Utility functions and helpers
│   └── extensions/         # Context and widget extensions
├── data/                   # Data layer implementation
├── domain/                 # Business logic layer
└── presentation/           # UI layer with BLoCs and widgets
```

## 🎨 Screenshots Match

The implementation exactly replicates the provided screenshots:

### Left Panel (Guest List)

- ✅ Dark sidebar with gradient background
- ✅ Guest list with avatars and names
- ✅ Search functionality
- ✅ Clean, minimal list design
- ✅ Selection highlighting with left border

### Right Panel (Guest Details)

- ✅ Guest Book icon and title
- ✅ Tab navigation (Profile, Reservation, Payment, Feedback, Order History)
- ✅ Guest profile header with avatar
- ✅ Statistics grid layout
- ✅ Loyalty and Visits metrics
- ✅ Notes sections with icons
- ✅ Proper spacing and typography

### Interactive Features

- ✅ Panel collapse/expand with smooth animation
- ✅ Guest selection and highlighting
- ✅ Tab navigation
- ✅ Search functionality
- ✅ Responsive behavior

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.10.1 or higher)
- Dart SDK
- Android Studio / VS Code

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```

### Typography

The application uses **Montserrat** font family throughout for a modern, clean appearance:

- All text styles utilize GoogleFonts.montserrat()
- Responsive text scaling maintains proper proportions
- Consistent font weights: Light (300), Regular (400), Medium (500), Semi-Bold (600), Bold (700)

### Running on Different Devices

The app is optimized for tablets but works on various screen sizes:

- **Small Tablets**: 600-800dp (iPad Mini portrait)
- **Medium Tablets**: 800-1024dp (iPad portrait)
- **Large Tablets**: 1024-1366dp (iPad Pro)
- **Extra Large**: 1366dp+ (iPad Pro landscape)

## 📱 Usage

1. **Launch the app** - See welcome screen with guest book information
2. **Select a guest** - Click on any guest from the left panel list
3. **View details** - Guest information displays in the right panel
4. **Navigate tabs** - Switch between Profile, Reservation, Payment, etc.
5. **Panel interaction** - Tap right panel to hide left panel, use back button to show
6. **Search guests** - Use the search bar to filter guests in real-time

## 🎯 Key Features Demonstrated

- **Clean Architecture**: Proper layer separation and dependency flow
- **BLoC Pattern**: Reactive state management with events and states
- **Responsive Design**: Automatic adaptation to different screen sizes
- **Design System**: Consistent styling extracted from screenshots
- **Error Handling**: Robust error handling with user feedback
- **Performance**: Optimized rendering and smooth animations
- **Code Quality**: DRY/KISS principles with comprehensive documentation

## 🏆 Production Ready

This implementation demonstrates:

- **Industry Best Practices**: Clean Architecture, SOLID principles
- **Maintainable Code**: Well-documented, properly structured
- **Scalable Architecture**: Easy to extend with new features
- **Testable Design**: Clean interfaces and dependency injection
- **Responsive Excellence**: Works beautifully across all tablet sizes
- **Pixel-Perfect UI**: Exactly matches provided design screenshots

---

## 🎨 **Typography Enhancement**

The application now uses the elegant **Montserrat** font family throughout for enhanced readability and modern aesthetic:

- ✅ **Google Fonts Integration**: Complete google_fonts package implementation
- ✅ **Consistent Typography**: All text styles use Montserrat with proper weights
- ✅ **Responsive Scaling**: Font sizes scale automatically across all screen sizes
- ✅ **Professional Appearance**: Clean, modern typography enhances the overall design

**Ready for immediate deployment and further development! 🚀**
