import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/di/injection_container.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'presentation/pages/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
  ]);

  try {
    await initializeDependencies();
    debugPrint('✅ Dependencies initialized successfully');
  } catch (e, stackTrace) {
    debugPrint('❌ Failed to initialize dependencies: $e');
    debugPrint('Stack trace: $stackTrace');
    return;
  }

  try {
    validateDependencies();
    debugPrint('✅ All dependencies validated successfully');
  } catch (e, stackTrace) {
    debugPrint('❌ Dependency validation failed: $e');
    debugPrint('Stack trace: $stackTrace');
    return;
  }

  runApp(const GuestBookApp());
}

class GuestBookApp extends StatelessWidget {
  const GuestBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: AppConstants.enableDebugLogging
          ? false
          : false,

      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,

      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(
              MediaQuery.of(context).textScaler.scale(0.8),
            ),
          ),
          child: child!,
        );
      },

      home: Builder(
        builder: (context) {
          try {
            return const MainScreen();
          } catch (e) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('Failed to load app: $e'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const GuestBookApp(),
                          ),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),

      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => const MainScreen(),
              settings: settings,
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const MainScreen(),
              settings: settings,
            );
        }
      },

      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const MainScreen(),
          settings: settings,
        );
      },

      supportedLocales: const [Locale('en', 'US')],
      locale: const Locale('en', 'US'),

      showSemanticsDebugger: false,
    );
  }
}
