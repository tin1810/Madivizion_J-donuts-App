import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/catalog/presentation/catalog_image.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

void main() {
  testWidgets('a bundled asset paints without a network call', (tester) async {
    await tester.pumpWidget(
      _host(const CatalogImage(url: 'assets/catalog/p_coconut.png')),
    );
    await tester.pump();

    expect(find.byType(Image), findsOneWidget);
    expect(find.byKey(CatalogImage.errorKey), findsNothing);
  });

  testWidgets('a remote image shows a placeholder until bytes arrive', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        CatalogImage(
          url: 'https://example.com/donut.png',
          load: (_) => Completer<Result<Uint8List>>().future,
        ),
      ),
    );
    await tester.pump();

    expect(find.byKey(CatalogImage.placeholderKey), findsOneWidget);
  });

  testWidgets('a failed remote image shows the error state', (tester) async {
    await tester.pumpWidget(
      _host(
        CatalogImage(
          url: 'https://example.com/donut.png',
          load: (_) async => const Failure<Uint8List>(NetworkFailure()),
        ),
      ),
    );
    await tester.pump();

    expect(find.byKey(CatalogImage.errorKey), findsOneWidget);
  });
}

Widget _host(Widget child) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: SizedBox(width: 80, height: 80, child: child)),
  );
}
