import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scroll_pagination_flutter/pagination_flutter.dart';
import 'package:scroll_pagination_flutter/src/widgets/helpers/default_status_indicators/first_page_error_indicator.dart';
import 'package:scroll_pagination_flutter/src/widgets/helpers/default_status_indicators/first_page_progress_indicator.dart';
import 'package:scroll_pagination_flutter/src/widgets/helpers/default_status_indicators/new_page_error_indicator.dart';
import 'package:scroll_pagination_flutter/src/widgets/helpers/default_status_indicators/new_page_progress_indicator.dart';
import 'package:scroll_pagination_flutter/src/widgets/helpers/default_status_indicators/no_items_found_indicator.dart';

import 'utils/paging_controller_utils.dart';

void main() {
  group('PagingStatus.loadingFirstPage', () {
    late PagingController pagingController;
    setUp(() {
      pagingController = PagingController(firstPageKey: 1);
    });

    testWidgets(
        'When no custom first page progress indicator is provided, '
        'a FirstPageProgressIndicator widget is shown.', (tester) async {
      // given
      final builderDelegate = PagedChildBuilderDelegate<int>(
        singleitemBuilder: (_, __, ___) => Container(),
      );

      // when
      await _pumpPagedLayoutBuilder(
        tester: tester,
        pagingController: pagingController,
        builderDelegate: builderDelegate,
      );

      // then
      _expectOneWidgetOfType(FirstPageProgressIndicator);
    });

    testWidgets(
        'Uses the custom first page progress indicator when one is provided.',
        (tester) async {
      // given
      final customIndicatorKey = UniqueKey();
      final builderDelegate = PagedChildBuilderDelegate<int>(
        singleitemBuilder: (_, __, ___) => Container(),
        firstPageProgressIndicatorWidget: (context) => Container(
          key: customIndicatorKey,
        ),
      );

      // when
      await _pumpPagedLayoutBuilder(
        tester: tester,
        pagingController: pagingController,
        builderDelegate: builderDelegate,
      );

      // then
      _expectWidgetWithKey(customIndicatorKey);
    });
  });

  group('PagingStatus.firstPageError', () {
    late PagingController pagingController;

    setUp(() {
      pagingController = buildPagingControllerWithPopulatedState(
        PopulatedStateOption.errorOnFirstPage,
      );
    });

    testWidgets(
        'When no custom first page error indicator is provided, '
        'a FirstPageErrorIndicator widget is shown.', (tester) async {
      // given
      final builderDelegate = PagedChildBuilderDelegate<int>(
        singleitemBuilder: (_, __, ___) => Container(),
      );

      // when
      await _pumpPagedLayoutBuilder(
        tester: tester,
        pagingController: pagingController,
        builderDelegate: builderDelegate,
      );

      // then
      _expectOneWidgetOfType(FirstPageErrorIndicator);
    });

    testWidgets(
        'Uses the custom first page error indicator when one is provided.',
        (tester) async {
      // given
      final customIndicatorKey = UniqueKey();
      final builderDelegate = PagedChildBuilderDelegate<int>(
        singleitemBuilder: (_, __, ___) => Container(),
        firstPageErrorIndicatorWidget: (context) => Container(
          key: customIndicatorKey,
        ),
      );

      // when
      await _pumpPagedLayoutBuilder(
        tester: tester,
        pagingController: pagingController,
        builderDelegate: builderDelegate,
      );

      // then
      _expectWidgetWithKey(customIndicatorKey);
    });
  });

  group('PagingStatus.noItemsFound', () {
    late PagingController pagingController;
    setUp(() {
      pagingController = buildPagingControllerWithPopulatedState(
        PopulatedStateOption.noItemsFound,
      );
    });

    testWidgets(
        'When no custom no items found indicator is provided, '
        'a NoItemsFoundIndicator widget is shown.', (tester) async {
      // given
      final builderDelegate = PagedChildBuilderDelegate<int>(
        singleitemBuilder: (_, __, ___) => Container(),
      );

      // when
      await _pumpPagedLayoutBuilder(
        tester: tester,
        pagingController: pagingController,
        builderDelegate: builderDelegate,
      );

      // then
      _expectOneWidgetOfType(NoItemsFoundIndicator);
    });

    testWidgets(
        'Uses the custom no items found indicator when one is provided.',
        (tester) async {
      // given
      final customIndicatorKey = UniqueKey();
      final builderDelegate = PagedChildBuilderDelegate<int>(
        singleitemBuilder: (_, __, ___) => Container(),
        noItemsFoundIndicatorWidget: (context) => Container(
          key: customIndicatorKey,
        ),
      );

      // when
      await _pumpPagedLayoutBuilder(
        tester: tester,
        pagingController: pagingController,
        builderDelegate: builderDelegate,
      );

      // then
      _expectWidgetWithKey(customIndicatorKey);
    });
  });

  group('PagingStatus.subsequentPageError', () {
    late PagingController pagingController;
    setUp(() {
      pagingController = buildPagingControllerWithPopulatedState(
        PopulatedStateOption.errorOnSecondPage,
      );
    });

    testWidgets(
        'When no custom new page error indicator is provided, '
        'a NewPageErrorIndicator widget is shown.', (tester) async {
      // given
      final builderDelegate = PagedChildBuilderDelegate<int>(
        singleitemBuilder: (_, __, ___) => Container(),
      );

      // when
      await _pumpPagedLayoutBuilder(
        tester: tester,
        pagingController: pagingController,
        builderDelegate: builderDelegate,
      );

      await tester.pump();

      // then
      _expectOneWidgetOfType(NewPageErrorIndicator);
    });

    testWidgets(
        'Uses the custom new page error indicator when one is provided.',
        (tester) async {
      // given
      final customIndicatorKey = UniqueKey();
      final builderDelegate = PagedChildBuilderDelegate<int>(
        singleitemBuilder: (_, __, ___) => Container(),
        newPageErrorIndicatorWidget: (context) => Text(
          'Error',
          key: customIndicatorKey,
        ),
      );

      // when
      await _pumpPagedLayoutBuilder(
        tester: tester,
        pagingController: pagingController,
        builderDelegate: builderDelegate,
      );

      await tester.pump();

      // then
      _expectWidgetWithKey(customIndicatorKey);
    });
  });

  group('PagingStatus.ongoing', () {
    late PagingController pagingController;
    setUp(() {
      pagingController = buildPagingControllerWithPopulatedState(
        PopulatedStateOption.ongoingWithTwoPages,
      );
    });

    testWidgets(
        'When no custom new page progress indicator is provided, '
        'a NewPageProgressIndicator widget is shown.', (tester) async {
      // given
      final builderDelegate = PagedChildBuilderDelegate<int>(
        singleitemBuilder: (_, __, ___) => Container(),
      );

      // when
      await _pumpPagedLayoutBuilder(
        tester: tester,
        pagingController: pagingController,
        builderDelegate: builderDelegate,
      );

      await tester.pump();

      // then
      _expectOneWidgetOfType(NewPageProgressIndicator);
    });

    testWidgets(
        'Uses the custom new page progress indicator when one is provided.',
        (tester) async {
      // given
      final customIndicatorKey = UniqueKey();
      final builderDelegate = PagedChildBuilderDelegate<int>(
        singleitemBuilder: (_, __, ___) => Container(),
        newPageProgressIndicatorWidget: (context) => CircularProgressIndicator(
          key: customIndicatorKey,
        ),
      );

      // when
      await _pumpPagedLayoutBuilder(
        tester: tester,
        pagingController: pagingController,
        builderDelegate: builderDelegate,
      );

      await tester.pump();

      // then
      _expectWidgetWithKey(customIndicatorKey);
    });
  });

  group('PagingStatus.completed', () {
    late PagingController pagingController;
    setUp(() {
      pagingController = buildPagingControllerWithPopulatedState(
        PopulatedStateOption.completedWithOnePage,
      );
    });

    testWidgets('Uses the custom no more items indicator when one is provided.',
        (tester) async {
      // given
      final customIndicatorKey = UniqueKey();
      final builderDelegate = PagedChildBuilderDelegate<int>(
        singleitemBuilder: (_, __, ___) => Container(),
        noMoreItemsIndicatorWidget: (context) => Text(
          'No more items.',
          key: customIndicatorKey,
        ),
      );

      // when
      await _pumpPagedLayoutBuilder(
        tester: tester,
        pagingController: pagingController,
        builderDelegate: builderDelegate,
      );

      await tester.pump();

      // then
      _expectWidgetWithKey(customIndicatorKey);
    });
  });

  group('First page indicators\' height', () {
    final pagingController = PagingController(firstPageKey: 1);
    const indicatorHeight = 100.0;
    late Key indicatorKey;
    late Widget progressIndicator;
    late PagedChildBuilderDelegate builderDelegate;
    late Finder indicatorFinder;

    setUp(() {
      indicatorKey = UniqueKey();
      progressIndicator = SizedBox(
        height: indicatorHeight,
        key: indicatorKey,
      );
      indicatorFinder = find.byKey(indicatorKey);

      builderDelegate = PagedChildBuilderDelegate<int>(
        singleitemBuilder: (_, __, ___) => Container(),
        firstPageProgressIndicatorWidget: (_) => progressIndicator,
      );
    });

    testWidgets(
        'By default, first page indicators are expanded to fill the '
        'remaining space', (tester) async {
      // when
      await _pumpPagedLayoutBuilder(
        tester: tester,
        pagingController: pagingController,
        builderDelegate: builderDelegate,
        shrinkWrapFirstPageIndicators: false,
      );

      // then
      final indicatorSize = tester.getSize(indicatorFinder);
      expect(indicatorSize.height, isNot(indicatorHeight));
    });

    testWidgets(
        'Setting [shrinkWrapFirstPageIndicators] to true '
        'preserves the indicator height', (tester) async {
      // when
      await _pumpPagedLayoutBuilder(
        tester: tester,
        pagingController: pagingController,
        builderDelegate: builderDelegate,
        shrinkWrapFirstPageIndicators: true,
      );

      // then
      final indicatorSize = tester.getSize(indicatorFinder);
      expect(indicatorSize.height, indicatorHeight);
    });
  });
}

void _expectWidgetWithKey(Key key) {
  final finder = find.byKey(key);
  expect(finder, findsOneWidget);
}

void _expectOneWidgetOfType(Type type) {
  final finder = find.byType(type);
  expect(finder, findsOneWidget);
}

Future<void> _pumpPagedLayoutBuilder({
  required WidgetTester tester,
  required PagingController pagingController,
  required PagedChildBuilderDelegate builderDelegate,
  bool shrinkWrapFirstPageIndicators = false,
}) =>
    _pumpSliver(
      sliver: PagedLayoutBuilder(
        layoutProtocol: PagedLayoutProtocol.sliver,
        pagingController: pagingController,
        builderDelegate: builderDelegate,
        shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
        errorListingBuilder: (
          context,
          __,
          ___,
          newPageErrorIndicatorWidget,
        ) =>
            SliverToBoxAdapter(
          child: newPageErrorIndicatorWidget(
            context,
          ),
        ),
        loadingListingBuilder: (
          context,
          __,
          ___,
          newPageProgressIndicatorWidget,
        ) =>
            SliverToBoxAdapter(
          child: newPageProgressIndicatorWidget(
            context,
          ),
        ),
        completedListingBuilder: (
          context,
          __,
          ___,
          noMoreItemsIndicatorWidget,
        ) =>
            SliverToBoxAdapter(
          child: noMoreItemsIndicatorWidget?.call(
            context,
          ),
        ),
      ),
      tester: tester,
    );

Future<void> _pumpSliver({
  required Widget sliver,
  required WidgetTester tester,
}) =>
    tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              sliver,
            ],
          ),
        ),
      ),
    );
