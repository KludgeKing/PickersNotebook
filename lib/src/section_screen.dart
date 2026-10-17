import 'package:flutter/material.dart';

import 'notebook_colors.dart';
import 'notebook_menu.dart';

class SectionScreen extends StatelessWidget {
  const SectionScreen({super.key, required this.section});

  final NotebookSection section;

  @override
  Widget build(BuildContext context) {
    return NotebookScaffold(
      section: section,
      body: Center(
        child: Text(
          section.label,
          style: const TextStyle(
            fontFamily: 'LibreBaskerville',
            fontSize: 34,
            height: 1.2,
            color: NotebookColors.ink,
            fontVariations: [FontVariation.weight(460)],
          ),
        ),
      ),
    );
  }
}
