import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scroll_pagination_flutter/src/core/paged_child_builder_delegate.dart';
import 'package:scroll_pagination_flutter/src/core/paging_controller.dart';
import 'package:scroll_pagination_flutter/src/utils/appended_sliver_child_builder_delegate.dart';
import 'package:scroll_pagination_flutter/src/widgets/helpers/paged_layout_builder.dart';
import 'package:scroll_pagination_flutter/src/widgets/layouts/paged_list_view.dart';

/// A [SliverList] with pagination capabilities.
///
/// To include separators, use [PagedSliverList.separated].
///
/// Similar to [PagedListView] but needs to be wrapped by a
/// [CustomScrollView] when added to the screen.
/// Useful for combining multiple scrollable pieces in your UI or if you need
/// to add some widgets preceding or following your paged list.
class PagedSliverList<PageKeyType, ItemType> extends StatelessWidget {
  const PagedSliverList({
    required this.pagingController,
    required this.builderDelegate,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.itemExtent,
    this.prototypeItem,
    this.semanticIndexCallback,
    this.shrinkWrapFirstPageIndicators = false,
    Key? key,
  })  : assert(
          itemExtent == null || prototypeItem == null,
          'You can only pass itemExtent or prototypeItem, not both',
        ),
        _separatorBuilder = null,
        super(key: key);

  const PagedSliverList.separated({
    required this.pagingController,
    required this.builderDelegate,
    required IndexedWidgetBuilder separatorBuilder,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.itemExtent,
    this.semanticIndexCallback,
    this.shrinkWrapFirstPageIndicators = false,
    Key? key,
  })  : prototypeItem = null,
        _separatorBuilder = separatorBuilder,
        super(key: key);

  /// Matches [PagedLayoutBuilder.pagingController].
  final PagingController<PageKeyType, ItemType> pagingController;

  /// Matches [PagedLayoutBuilder.builderDelegate].
  final PagedChildBuilderDelegate<ItemType> builderDelegate;

  /// The builder for list item separators, just like in [ListView.separated].
  final IndexedWidgetBuilder? _separatorBuilder;

  /// Matches [SliverChildBuilderDelegate.addAutomaticKeepAlives].
  final bool addAutomaticKeepAlives;

  /// Matches [SliverChildBuilderDelegate.addRepaintBoundaries].
  final bool addRepaintBoundaries;

  /// Matches [SliverChildBuilderDelegate.addSemanticIndexes].
  final bool addSemanticIndexes;

  /// Matches [SliverChildBuilderDelegate.semanticIndexCallback].
  final SemanticIndexCallback? semanticIndexCallback;

  /// Matches [SliverFixedExtentList.itemExtent].
  ///
  /// If this is not null, [prototypeItem] must be null, and vice versa.
  final double? itemExtent;

  /// Matches [SliverPrototypeExtentList.prototypeItem].
  ///
  /// If this is not null, [itemExtent] must be null, and vice versa.
  final Widget? prototypeItem;

  /// Matches [PagedLayoutBuilder.shrinkWrapFirstPageIndicators].
  final bool shrinkWrapFirstPageIndicators;

  @override
  Widget build(BuildContext context) =>
      PagedLayoutBuilder<PageKeyType, ItemType>(
        layoutProtocol: PagedLayoutProtocol.sliver,
        pagingController: pagingController,
        builderDelegate: builderDelegate,
        completedListingBuilder: (
          context,
          singleitemBuilder,
          itemCount,
          noMoreItemsIndicatorWidget,
        ) =>
            _buildSliverList(
          singleitemBuilder,
          itemCount,
          statusIndicatorBuilder: noMoreItemsIndicatorWidget,
        ),
        loadingListingBuilder: (
          context,
          singleitemBuilder,
          itemCount,
          progressIndicatorBuilder,
        ) =>
            _buildSliverList(
          singleitemBuilder,
          itemCount,
          statusIndicatorBuilder: progressIndicatorBuilder,
        ),
        errorListingBuilder: (
          context,
          singleitemBuilder,
          itemCount,
          errorIndicatorBuilder,
        ) =>
            _buildSliverList(
          singleitemBuilder,
          itemCount,
          statusIndicatorBuilder: errorIndicatorBuilder,
        ),
        shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
      );

  SliverMultiBoxAdaptorWidget _buildSliverList(
    IndexedWidgetBuilder singleitemBuilder,
    int itemCount, {
    WidgetBuilder? statusIndicatorBuilder,
  }) {
    final delegate = _buildSliverDelegate(
      singleitemBuilder,
      itemCount,
      statusIndicatorBuilder: statusIndicatorBuilder,
    );

    final itemExtent = this.itemExtent;

    return ((itemExtent == null && prototypeItem == null) ||
            _separatorBuilder != null)
        ? SliverList(
            delegate: delegate,
          )
        : (itemExtent != null)
            ? SliverFixedExtentList(
                delegate: delegate,
                itemExtent: itemExtent,
              )
            : SliverPrototypeExtentList(
                delegate: delegate,
                prototypeItem: prototypeItem!,
              );
  }

  SliverChildBuilderDelegate _buildSliverDelegate(
    IndexedWidgetBuilder singleitemBuilder,
    int itemCount, {
    WidgetBuilder? statusIndicatorBuilder,
  }) {
    final separatorBuilder = _separatorBuilder;
    return separatorBuilder == null
        ? AppendedSliverChildBuilderDelegate(
            builder: singleitemBuilder,
            childCount: itemCount,
            appendixBuilder: statusIndicatorBuilder,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            semanticIndexCallback: semanticIndexCallback,
          )
        : AppendedSliverChildBuilderDelegate.separated(
            builder: singleitemBuilder,
            childCount: itemCount,
            appendixBuilder: statusIndicatorBuilder,
            separatorBuilder: separatorBuilder,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
          );
  }
}
