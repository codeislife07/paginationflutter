import 'package:flutter/widgets.dart';

typedef ItemWidgetBuilder<ItemType> = Widget Function(
  BuildContext context,
  ItemType item,
  int index,
);

/// Supplies builders for the visual components of paged views.
///
/// The generic type [ItemType] must be specified in order to properly identify
/// the list item’s type.
class PagedChildBuilderDelegate<ItemType> {
  PagedChildBuilderDelegate({
    required this.singleitemBuilder,
    this.firstPageErrorIndicatorWidget,
    this.newPageErrorIndicatorWidget,
    this.firstPageProgressIndicatorWidget,
    this.newPageProgressIndicatorWidget,
    this.noItemsFoundIndicatorWidget,
    this.noMoreItemsIndicatorWidget,
    this.animateTransitions = false,
    this.transitionDuration = const Duration(milliseconds: 250),
  });

  /// The builder for list items.
  final ItemWidgetBuilder<ItemType> singleitemBuilder;

  /// The builder for the first page's error indicator.
  final WidgetBuilder? firstPageErrorIndicatorWidget;

  /// The builder for a new page's error indicator.
  final WidgetBuilder? newPageErrorIndicatorWidget;

  /// The builder for the first page's progress indicator.
  final WidgetBuilder? firstPageProgressIndicatorWidget;

  /// The builder for a new page's progress indicator.
  final WidgetBuilder? newPageProgressIndicatorWidget;

  /// The builder for a no items list indicator.
  final WidgetBuilder? noItemsFoundIndicatorWidget;

  /// The builder for an indicator that all items have been fetched.
  final WidgetBuilder? noMoreItemsIndicatorWidget;

  /// Whether status transitions should be animated.
  final bool animateTransitions;

  /// The duration of animated transitions when [animateTransitions] is `true`.
  final Duration transitionDuration;
}
