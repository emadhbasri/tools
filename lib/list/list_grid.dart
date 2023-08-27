import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../text.dart';
import '../size.dart';
import 'infinite_scroll.dart';
import 'dart:math' as math;

class ToolsSliverBuilder<T> extends StatefulWidget {
  const ToolsSliverBuilder(
      {Key? key,
      required this.onLoad,
      required this.itemBuilder,
      required this.realHeight,
      required this.screenWidth,
      this.separatorBuilder,
      this.animateTransitions = false,
      this.transitionDuration = const Duration(milliseconds: 500),
      this.firstPage = 0,
      this.reverse = false,
      this.shrinkWrap = false,
      this.separated = false,
      this.scrollDirection = Axis.vertical,
      this.padding = EdgeInsets.zero,
      this.physics,
      this.scrollController,
      this.firstPageProgressIndicatorBuilder,
      this.newPageProgressIndicatorBuilder,
      this.noItemsFoundIndicatorBuilder,
      this.noMoreItemsIndicatorBuilder,
      this.crossAxisCount = 3,
      this.childAspectRatio = 3,
      this.crossAxisSpacing = 10,
      this.mainAxisSpacing = 10})
      : super(key: key);
  final Future<ToolsListViewData<T>> Function(int page) onLoad;

  final Widget Function(
    BuildContext context,
    int index,
  )? separatorBuilder;
  final Widget Function(BuildContext context, int index, T item,
      PagingController<int, T> pagingController) itemBuilder;
  final int firstPage;
  final bool animateTransitions, reverse, shrinkWrap, separated;
  final Duration transitionDuration;
  final Axis scrollDirection;
  final EdgeInsets padding;
  final ScrollPhysics? physics;
  final double realHeight, screenWidth;
  final ScrollController? scrollController;
  final Widget? firstPageProgressIndicatorBuilder,
      newPageProgressIndicatorBuilder,
      noItemsFoundIndicatorBuilder,
      noMoreItemsIndicatorBuilder;

  final int crossAxisCount;
  final double childAspectRatio, crossAxisSpacing, mainAxisSpacing;

  @override
  State<ToolsSliverBuilder<T>> createState() => _ToolsSliverBuilderState<T>();
}

class _ToolsSliverBuilderState<T> extends State<ToolsSliverBuilder<T>> {
  late PagingController<int, T> _pagingController;

  @override
  void initState() {
    _pagingController = PagingController(firstPageKey: widget.firstPage);

    _pagingController.addPageRequestListener((pageKey) async {
      ToolsListViewData<T> data = await widget.onLoad(pageKey);
      if (data.data == null) {
        _pagingController.error = 'error';
      } else {
        if (data.isLastPage) {
          _pagingController.appendLastPage(data.data!);
        } else {
          _pagingController.appendPage(data.data!, pageKey + 1);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: () async {
          _pagingController.refresh();
        },
        child: PagedSliverBuilder<int, T>(
            pagingController: _pagingController,
            completedListingBuilder: (context, itemWidgetBuilder, itemCount,
                noMoreItemsIndicatorBuilder) {
              return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: widget.childAspectRatio,
                    crossAxisSpacing: widget.crossAxisSpacing,
                    mainAxisSpacing: widget.mainAxisSpacing,
                    crossAxisCount: widget.crossAxisCount,
                  ),
                  delegate: AppendedSliverChildBuilderDelegate(
                    builder: itemWidgetBuilder,
                    childCount: itemCount,
                  )
                  // SliverChildBuilderDelegate(
                  //     (context, index) =>
                  //     itemWidgetBuilder(context, index))
                  );
              // _buildSliverDelegate(
              //   itemBuilder,
              //   itemCount,
              //   statusIndicatorBuilder: noMoreItemsIndicatorBuilder,
              // ),
              // return const Text(
              //   'completedListingBuilder',
              //   style: TextStyle(fontSize: 60),
              // );
            },
            errorListingBuilder: (context, itemWidgetBuilder, itemCount,
                newPageErrorIndicatorBuilder) {
              return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: widget.childAspectRatio,
                    crossAxisSpacing: widget.crossAxisSpacing,
                    mainAxisSpacing: widget.mainAxisSpacing,
                    crossAxisCount: widget.crossAxisCount,
                  ),
                  delegate: AppendedSliverChildBuilderDelegate(
                    builder: itemWidgetBuilder,
                    childCount: itemCount,
                  ));
              // return const Text(
              //   'errorListingBuilder',
              //   style: TextStyle(fontSize: 60),
              // );
            },
            loadingListingBuilder: (context, itemWidgetBuilder, itemCount,
                newPageProgressIndicatorBuilder) {
              return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: widget.childAspectRatio,
                    crossAxisSpacing: widget.crossAxisSpacing,
                    mainAxisSpacing: widget.mainAxisSpacing,
                    crossAxisCount: widget.crossAxisCount,
                  ),
                  delegate: AppendedSliverChildBuilderDelegate(
                    builder: itemWidgetBuilder,
                    childCount: itemCount,
                  ));
              // return const Text(
              //   'loading...',
              //   style: TextStyle(fontSize: 60),
              // );
            },
            builderDelegate: PagedChildBuilderDelegate(
              firstPageProgressIndicatorBuilder:
                  widget.firstPageProgressIndicatorBuilder != null
                      ? (context) => widget.firstPageProgressIndicatorBuilder!
                      : null,
              newPageProgressIndicatorBuilder:
                  widget.newPageProgressIndicatorBuilder != null
                      ? (context) => widget.newPageProgressIndicatorBuilder!
                      : null,
              noItemsFoundIndicatorBuilder: (context) =>
                  widget.noItemsFoundIndicatorBuilder != null
                      ? widget.noItemsFoundIndicatorBuilder!
                      : SizedBox(
                          width: double.maxFinite,
                          height: doubleHeight(100, widget.realHeight),
                          child: Center(
                              child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ToolsText(
                                'متاسفانه محتوایی جهت نمایش وجود ندارد',
                                style: toolstitleStyle(
                                    screenWidth: widget.screenWidth),
                              ),
                              TextButton.icon(
                                  onPressed: () {
                                    _pagingController.refresh();
                                  },
                                  icon: const Icon(Icons.refresh),
                                  label: ToolsText(
                                    'تلاش دوباره',
                                    style: toolscontentStyle(
                                        screenWidth: widget.screenWidth,
                                        color: Colors.blue),
                                  ))
                            ],
                          ))),
              noMoreItemsIndicatorBuilder:
                  widget.noMoreItemsIndicatorBuilder != null
                      ? (context) => widget.noMoreItemsIndicatorBuilder!
                      : null,
              animateTransitions: widget.animateTransitions,
              transitionDuration: widget.transitionDuration,
              itemBuilder: (context, T item, index) {
                return widget.itemBuilder(
                    context, index, item, _pagingController);
              },
            )),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class AppendedSliverChildBuilderDelegate extends SliverChildBuilderDelegate {
  AppendedSliverChildBuilderDelegate({
    required IndexedWidgetBuilder builder,
    required int childCount,
    WidgetBuilder? appendixBuilder,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    SemanticIndexCallback? semanticIndexCallback,
  }) : super(
          appendixBuilder == null
              ? builder
              : (context, index) {
                  if (index == childCount) {
                    return appendixBuilder(context);
                  }
                  return builder(context, index);
                },
          childCount: appendixBuilder == null ? childCount : childCount + 1,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          semanticIndexCallback: semanticIndexCallback ?? (_, index) => index,
        );

  AppendedSliverChildBuilderDelegate.separated({
    required IndexedWidgetBuilder builder,
    required int childCount,
    required IndexedWidgetBuilder separatorBuilder,
    WidgetBuilder? appendixBuilder,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
  }) : this(
          builder: (context, index) {
            final itemIndex = index ~/ 2;
            if (index.isEven) {
              return builder(context, itemIndex);
            }

            return separatorBuilder(context, itemIndex);
          },
          childCount: math.max(
            0,
            childCount * 2 - (appendixBuilder != null ? 0 : 1),
          ),
          appendixBuilder: appendixBuilder,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          semanticIndexCallback: (_, index) => index.isEven ? index ~/ 2 : null,
        );
}
