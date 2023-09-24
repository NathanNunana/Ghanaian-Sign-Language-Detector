import 'package:ghana_sl/utils/_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    const ProviderScope(child: GSLDetector()),
  );
}

class GSLDetector extends ConsumerWidget {
  const GSLDetector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'GhanaSL',
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'US'),
      theme: ThemeData(
        primaryColor: AppTheme.appTheme(context).primaryColor,
        textTheme: GoogleFonts.urbanistTextTheme(),
        scaffoldBackgroundColor: AppTheme.appTheme(context).bgColor,
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRoutes.wrapperRoute,
    );
  }
}
