import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'notebook_colors.dart';

enum NotebookSection {
  songs('Songs', '/songs'),
  setLists('Set Lists', '/set-lists'),
  calendar('Calendar', '/calendar'),
  home('Home', '/');

  const NotebookSection(this.label, this.route);

  final String label;
  final String route;
}

class NotebookScaffold extends StatelessWidget {
  const NotebookScaffold({
    super.key,
    required this.section,
    required this.body,
  });

  final NotebookSection section;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: notebookOverlay(NotebookColors.paperDeep),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        drawer: NotebookDrawer(current: section),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          foregroundColor: NotebookColors.ink,
          iconTheme: const IconThemeData(color: NotebookColors.ink),
        ),
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0, -0.35),
              radius: 1.15,
              colors: [Color(0xFFF8F4EC), NotebookColors.paperDeep],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: kToolbarHeight),
              child: body,
            ),
          ),
        ),
      ),
    );
  }
}

class NotebookDrawer extends StatelessWidget {
  const NotebookDrawer({super.key, required this.current});

  final NotebookSection current;

  void _select(BuildContext context, NotebookSection section) {
    final navigator = Navigator.of(context);
    navigator.pop();
    if (section == current) {
      return;
    }

    if (section == NotebookSection.home) {
      navigator.pushNamedAndRemoveUntil(section.route, (_) => false);
    } else if (current == NotebookSection.home) {
      navigator.pushNamed(section.route);
    } else {
      navigator.pushReplacementNamed(section.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: NotebookColors.paper,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          children: [
            for (final section in NotebookSection.values)
              ListTile(
                selected: section == current,
                selectedTileColor: NotebookColors.paperDeep,
                selectedColor: NotebookColors.ink,
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                title: Text(
                  section.label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: section == current
                        ? FontWeight.w600
                        : FontWeight.w400,
                    color: NotebookColors.ink,
                  ),
                ),
                onTap: () => _select(context, section),
              ),
          ],
        ),
      ),
    );
  }
}
