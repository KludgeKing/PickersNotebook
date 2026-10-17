import 'package:flutter/material.dart';

import 'notebook_colors.dart';
import 'notebook_menu.dart';
import 'stuffed_binder.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const NotebookScaffold(
      section: NotebookSection.home,
      body: _LandingBody(),
    );
  }
}

class _LandingBody extends StatelessWidget {
  const _LandingBody();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxHeight < 640;
        final binderHeight = compact
            ? 280.0
            : (constraints.maxHeight * 0.58).clamp(300.0, 470.0);
        final content = Column(
          children: [
            if (!compact) const Spacer(flex: 3),
            SizedBox(
              height: binderHeight,
              child: const StuffedBinder(),
            ),
            const SizedBox(height: 8),
            const _NotebookTitle(),
            if (!compact) const Spacer(flex: 4),
            if (compact) const SizedBox(height: 28),
          ],
        );

        if (compact) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(28, 8, 28, 24),
            child: content,
          );
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(28, 8, 28, 24),
          child: content,
        );
      },
    );
  }
}

class _NotebookTitle extends StatelessWidget {
  const _NotebookTitle();

  @override
  Widget build(BuildContext context) {
    return const FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        "Picker's Notebook",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'LibreBaskerville',
          fontSize: 34,
          height: 1.2,
          fontWeight: FontWeight.w400,
          color: NotebookColors.ink,
          fontVariations: [FontVariation.weight(460)],
        ),
      ),
    );
  }
}
