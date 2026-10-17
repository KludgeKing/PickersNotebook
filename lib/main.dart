import 'package:flutter/material.dart';

import 'src/landing_screen.dart';
import 'src/notebook_colors.dart';
import 'src/notebook_menu.dart';
import 'src/section_screen.dart';

void main() {
  runApp(const PickersNotebookApp());
}

class PickersNotebookApp extends StatelessWidget {
  const PickersNotebookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Picker's Notebook",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: NotebookColors.paper,
        colorScheme: const ColorScheme.light(
          primary: NotebookColors.ink,
          onPrimary: NotebookColors.paper,
          surface: NotebookColors.paper,
          onSurface: NotebookColors.ink,
        ),
      ),
      initialRoute: NotebookSection.home.route,
      routes: {
        for (final section in NotebookSection.values)
          section.route: (_) => section == NotebookSection.home
              ? const LandingScreen()
              : SectionScreen(section: section),
      },
    );
  }
}
