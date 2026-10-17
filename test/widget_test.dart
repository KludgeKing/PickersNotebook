import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pickers_notebook/main.dart';
import 'package:pickers_notebook/src/stuffed_binder.dart';

void main() {
  testWidgets('landing screen shows the binder, title, and menu', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PickersNotebookApp());

    expect(find.text("Picker's Notebook"), findsOneWidget);
    expect(find.text('Open'), findsNothing);
    expect(find.byType(StuffedBinder), findsOneWidget);
    expect(find.byTooltip('Open navigation menu'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    expect(find.text('Songs'), findsOneWidget);
    expect(find.text('Song List'), findsNothing);
    expect(find.text('Set Lists'), findsOneWidget);
    expect(
      tester
          .widgetList<ListTile>(find.byType(ListTile))
          .map((tile) => (tile.title! as Text).data)
          .toList(),
      ['Songs', 'Set Lists', 'Calendar', 'Home'],
    );
    expect(find.text('Calendar'), findsOneWidget);
    expect(find.text('Notes'), findsNothing);
    expect(find.text('Home'), findsOneWidget);

    await tester.tap(find.text('Songs'));
    await tester.pumpAndSettle();

    expect(find.byType(StuffedBinder), findsNothing);
    expect(find.text('Songs'), findsOneWidget);

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.byType(StuffedBinder), findsOneWidget);
    expect(find.text("Picker's Notebook"), findsOneWidget);
  });

  testWidgets('landing screen fits a short window', (tester) async {
    tester.view.physicalSize = const Size(800, 520);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PickersNotebookApp());

    expect(find.text("Picker's Notebook"), findsOneWidget);
    expect(find.text('Open'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
