/// Core application configuration constants
class AppConstants {
  AppConstants._();

  static const String appName = 'Guest Book';
  static const String appVersion = '1.0.0';

  /// Copyright information
  static const String copyright = '© 2024 EI Digital Assignment';

  // ========== GUEST BOOK CONFIGURATION ==========

  /// Guest book feature description displayed in UI
  static const String guestBookDescription =
      'The guest book feature remembers your guests\' dietary needs, allergies, '
      'and favorite dishes. It organizes dining preferences for a customized '
      'and memorable experience, ensuring each visit is tailored to their '
      'individual needs.';

  /// Tab navigation labels (extracted from screenshots)
  static const List<String> navigationTabs = [
    'Profile',
    'Reservation',
    'Payment',
    'Feedback',
    'Order History',
  ];

  /// Default selected tab index
  static const int defaultTabIndex = 0; // Profile tab

  // ========== GUEST PROFILE SECTIONS ==========

  /// Loyalty section fields
  static const String loyaltyLabel = 'LOYALTY';
  static const String visitsLabel = 'VISITS';

  /// Statistics labels (extracted from screenshot)
  static const List<String> statisticsLabels = [
    'Last Visit',
    'Average Spend',
    'Lifetime Spend',
    'Total Orders',
    'Average Tip',
  ];

  /// Loyalty metrics labels
  static const List<String> loyaltyLabels = [
    'Earned',
    'Redeemed',
    'Available',
    'Amount',
  ];

  /// Visits metrics labels
  static const List<String> visitsLabels = [
    'Total Visits',
    'Upcoming',
    'Cancelled',
    'No Shows',
  ];

  // ========== NOTES SECTIONS ==========

  /// Notes section titles (extracted from screenshots)
  static const List<String> notesSections = [
    'General',
    'Special Relation',
    'Seating Preferences',
    'Special Note*',
    'Allergies',
  ];

  /// Default note placeholder text
  static const String addNotesPlaceholder = 'Add notes...';

  // ========== STATUS MESSAGES ==========

  /// No data messages
  static const String noUpcomingVisits = 'No Upcoming Visits';
  static const String noOrderedItems = 'No Ordered Items';
  static const String noRecentVehicle = 'No Recent Vehicle to Show';
  static const String noRecentOrders = 'No Recent Orders to Show';
  static const String noOnlineReview = 'No Online Review to Show';
  static const String noAllergies = 'No Allergies';

  // ========== BUTTON LABELS ==========

  /// Action button labels
  static const String addButton = 'Add';
  static const String addTags = 'Add Tags';
  static const String bookAVisit = 'Book A Visit';
  static const String backButton = 'Back';

  // ========== VALIDATION CONSTANTS ==========

  /// Maximum length for text inputs
  static const int maxNameLength = 50;
  static const int maxEmailLength = 254;
  static const int maxPhoneLength = 20;
  static const int maxNotesLength = 500;

  /// Regular expressions for validation
  static const String emailRegex =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String phoneRegex =
      r'^\+?1?[-.\s]?\(?[2-9]\d{2}\)?[-.\s]?\d{3}[-.\s]?\d{4}$';

  // ========== RESPONSIVE BEHAVIOR ==========

  /// Panel behavior configuration
  static const bool autoCollapsePanel = true;
  static const bool enablePanelGestures = true;

  /// Default panel state on app start
  static const bool defaultPanelExpanded = true;

  /// Minimum screen width to show dual panel layout
  static const double minDualPanelWidth = 600.0;

  // ========== PERFORMANCE CONSTANTS ==========

  /// List view performance settings
  static const int listCacheExtent = 100;
  static const double listItemExtent = 80.0;

  /// Image loading settings
  static const double avatarCacheWidth = 100.0;
  static const double avatarCacheHeight = 100.0;

  // ========== DEBUG SETTINGS ==========

  /// Debug mode flags (should be false in production)
  static const bool enableDebugLogging = true;
  static const bool showPerformanceOverlay = false;
  static const bool enableBlocObserver = true;
}
