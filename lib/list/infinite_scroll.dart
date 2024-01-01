// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tools/size_plus.dart';
import '../text.dart';

class ToolsListViewData<T> {
  List<T>? data;
  final bool isLastPage;

  ToolsListViewData({required this.data, this.isLastPage = false});
}

class ToolMyPagingController<T> {
  late PagingController<int, T>? controller;
  late bool hasListener;
  ToolMyPagingController({required this.controller, this.hasListener = false});
}

class ToolsListView<T> extends StatefulWidget {
  const ToolsListView({
    Key? key,
    required this.onLoad,
    required this.itemBuilder,
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
    this.pageController,
  }) : super(key: key);
  final Future<ToolsListViewData<T>> Function(int page) onLoad;
  final Widget Function(
    BuildContext context,
    int index,
  )? separatorBuilder;
  final Widget Function(
          BuildContext context, int index, T item, PagingController<int, T> pagingController)
      itemBuilder;
  final int firstPage;
  final bool animateTransitions, reverse, shrinkWrap, separated;
  final Duration transitionDuration;
  final Axis scrollDirection;
  final EdgeInsets padding;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
  final Widget? firstPageProgressIndicatorBuilder,
      newPageProgressIndicatorBuilder,
      noItemsFoundIndicatorBuilder,
      noMoreItemsIndicatorBuilder;
  final ToolMyPagingController<T>? pageController;

  @override
  State<ToolsListView<T>> createState() => _ToolsListViewState<T>();
}

class _ToolsListViewState<T> extends State<ToolsListView<T>> {
  late PagingController<int, T> _pagingController;
  // static const _pageSize = 10;

  @override
  void initState() {
    if (widget.pageController != null && widget.pageController!.controller != null) {
      _pagingController = widget.pageController!.controller!;
      _pagingController.refresh();
    } else {
      _pagingController = PagingController(firstPageKey: widget.firstPage);
    }
    if (widget.pageController != null) {
      if (widget.pageController!.hasListener == false) {
        widget.pageController!.hasListener = true;
        _pagingController.addPageRequestListener((pageKey) async {
          if (pageKey == 1) _pagingController.itemList?.clear();
          ToolsListViewData<T> data = await widget.onLoad(pageKey);
          if (data.data == null) {
            _pagingController.error = 'error';
          } else {
            if (data.isLastPage) {
              _pagingController.appendLastPage(data.data!);
            } else if (data.data!.isEmpty) {
              _pagingController.appendLastPage(data.data!);
            } else {
              _pagingController.appendPage(data.data!, pageKey + 1);
            }
          }
        });
      }
    } else {
      _pagingController.addPageRequestListener((pageKey) async {
        if (pageKey == 1) _pagingController.itemList?.clear();
        ToolsListViewData<T> data = await widget.onLoad(pageKey);
        if (data.data == null) {
          _pagingController.error = 'error';
        } else {
          if (data.isLastPage) {
            _pagingController.appendLastPage(data.data!);
          } else if (data.data!.isEmpty) {
            _pagingController.appendLastPage(data.data!);
          } else {
            _pagingController.appendPage(data.data!, pageKey + 1);
          }
        }
      });
    }
    super.initState();
  }

  // Future<void> _fetchPage(int pageKey) async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   print('pageKey $pageKey');
  //   try {
  //     List<String> newItems = List.generate(_pageSize, (index) => '$pageKey$index');
  //     final isLastPage = newItems.length < _pageSize;
  //     if (isLastPage) {
  //       _pagingController.appendLastPage(newItems);
  //     } else {
  //       final nextPageKey = pageKey +1;
  //       _pagingController.appendPage(newItems, nextPageKey);
  //     }
  //   } catch (error) {
  //     _pagingController.error = error;
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: () async {
          _pagingController.refresh();
        },
        child: widget.separated
            ? PagedListView.separated(
                physics: widget.physics,
                scrollController: widget.scrollController,
                padding: widget.padding,
                reverse: widget.reverse,
                shrinkWrap: widget.shrinkWrap,
                scrollDirection: widget.scrollDirection,
                pagingController: _pagingController,
                separatorBuilder: (BuildContext context, int index) {
                  return widget.separatorBuilder!(context, index);
                },
                builderDelegate: PagedChildBuilderDelegate(
                  firstPageProgressIndicatorBuilder:
                      widget.firstPageProgressIndicatorBuilder != null
                          ? (context) => widget.firstPageProgressIndicatorBuilder!
                          : null,
                  newPageProgressIndicatorBuilder: widget.newPageProgressIndicatorBuilder != null
                      ? (context) => widget.newPageProgressIndicatorBuilder!
                      : null,
                  noItemsFoundIndicatorBuilder: (context) =>
                      widget.noItemsFoundIndicatorBuilder != null
                          ? widget.noItemsFoundIndicatorBuilder!
                          : SizedBox(
                              width: double.maxFinite,
                              height: 100.h,
                              child: Center(
                                  child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ToolsText(
                                    'متاسفانه محتوایی جهت نمایش وجود ندارد',
                                    style: toolstitleStyle(),
                                  ),
                                  TextButton.icon(
                                      onPressed: () {
                                        _pagingController.refresh();
                                      },
                                      icon: const Icon(Icons.refresh),
                                      label: ToolsText(
                                        'تلاش دوباره',
                                        style: toolscontentStyle(color: Colors.blue),
                                      ))
                                ],
                              ))),
                  noMoreItemsIndicatorBuilder: widget.noMoreItemsIndicatorBuilder != null
                      ? (context) => widget.noMoreItemsIndicatorBuilder!
                      : null,
                  animateTransitions: widget.animateTransitions,
                  transitionDuration: widget.transitionDuration,
                  itemBuilder: (context, T item, index) {
                    return widget.itemBuilder(context, index, item, _pagingController);
                  },
                ))
            : PagedListView<int, T>(
                physics: widget.physics,
                scrollController: widget.scrollController,
                padding: widget.padding,
                reverse: widget.reverse,
                shrinkWrap: widget.shrinkWrap,
                scrollDirection: widget.scrollDirection,
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate(
                  firstPageProgressIndicatorBuilder:
                      widget.firstPageProgressIndicatorBuilder != null
                          ? (context) => widget.firstPageProgressIndicatorBuilder!
                          : null,
                  newPageProgressIndicatorBuilder: widget.newPageProgressIndicatorBuilder != null
                      ? (context) => widget.newPageProgressIndicatorBuilder!
                      : null,
                  noItemsFoundIndicatorBuilder: (context) =>
                      widget.noItemsFoundIndicatorBuilder != null
                          ? widget.noItemsFoundIndicatorBuilder!
                          : SizedBox(
                              width: double.maxFinite,
                              height: 100.h,
                              child: Center(
                                  child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ToolsText(
                                    'متاسفانه محتوایی جهت نمایش وجود ندارد',
                                    style: toolstitleStyle(),
                                  ),
                                  TextButton.icon(
                                      onPressed: () {
                                        _pagingController.refresh();
                                      },
                                      icon: const Icon(Icons.refresh),
                                      label: ToolsText(
                                        'تلاش دوباره',
                                        style: toolscontentStyle(color: Colors.blue),
                                      ))
                                ],
                              ))),
                  noMoreItemsIndicatorBuilder: widget.noMoreItemsIndicatorBuilder != null
                      ? (context) => widget.noMoreItemsIndicatorBuilder!
                      : null,
                  animateTransitions: widget.animateTransitions,
                  transitionDuration: widget.transitionDuration,
                  itemBuilder: (context, T item, index) {
                    return widget.itemBuilder(context, index, item, _pagingController);
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

class ToolsGridView<T> extends StatefulWidget {
  const ToolsGridView(
      {Key? key,
      required this.onLoad,
      required this.itemBuilder,
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
      this.pageController,
      this.mainAxisSpacing = 10})
      : super(key: key);
  final Future<ToolsListViewData<T>> Function(int page) onLoad;

  final Widget Function(
    BuildContext context,
    int index,
  )? separatorBuilder;
  final Widget Function(
          BuildContext context, int index, T item, PagingController<int, T> pagingController)
      itemBuilder;
  final int firstPage;
  final bool animateTransitions, reverse, shrinkWrap, separated;
  final Duration transitionDuration;
  final Axis scrollDirection;
  final EdgeInsets padding;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
  final Widget? firstPageProgressIndicatorBuilder,
      newPageProgressIndicatorBuilder,
      noItemsFoundIndicatorBuilder,
      noMoreItemsIndicatorBuilder;

  final int crossAxisCount;
  final double childAspectRatio, crossAxisSpacing, mainAxisSpacing;
  final ToolMyPagingController<T>? pageController;
  @override
  State<ToolsGridView<T>> createState() => _ToolsGridViewState<T>();
}

class _ToolsGridViewState<T> extends State<ToolsGridView<T>> {
  late PagingController<int, T> _pagingController;

  @override
  void initState() {
    if (widget.pageController != null && widget.pageController!.controller != null) {
      _pagingController = widget.pageController!.controller!;
      _pagingController.refresh();
    } else {
      _pagingController = PagingController(firstPageKey: widget.firstPage);
    }
    if (widget.pageController != null) {
      if (widget.pageController!.hasListener == false) {
        widget.pageController!.hasListener = true;
        _pagingController.addPageRequestListener((pageKey) async {
          if (pageKey == 1) _pagingController.itemList?.clear();
          ToolsListViewData<T> data = await widget.onLoad(pageKey);
          if (data.data == null) {
            _pagingController.error = 'error';
          } else {
            if (data.isLastPage) {
              _pagingController.appendLastPage(data.data!);
            } else if (data.data!.isEmpty) {
              _pagingController.appendLastPage(data.data!);
            } else {
              _pagingController.appendPage(data.data!, pageKey + 1);
            }
          }
        });
      }
    } else {
      _pagingController.addPageRequestListener((pageKey) async {
        if (pageKey == 1) _pagingController.itemList?.clear();
        ToolsListViewData<T> data = await widget.onLoad(pageKey);
        if (data.data == null) {
          _pagingController.error = 'error';
        } else {
          if (data.isLastPage) {
            _pagingController.appendLastPage(data.data!);
          } else if (data.data!.isEmpty) {
            _pagingController.appendLastPage(data.data!);
          } else {
            _pagingController.appendPage(data.data!, pageKey + 1);
          }
        }
      });
    }

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
        child: PagedGridView<int, T>(
            showNewPageProgressIndicatorAsGridChild: false,
            showNewPageErrorIndicatorAsGridChild: false,
            showNoMoreItemsIndicatorAsGridChild: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: widget.childAspectRatio,
              crossAxisSpacing: widget.crossAxisSpacing,
              mainAxisSpacing: widget.mainAxisSpacing,
              crossAxisCount: widget.crossAxisCount,
            ),
            physics: widget.physics,
            scrollController: widget.scrollController,
            padding: widget.padding,
            reverse: widget.reverse,
            shrinkWrap: widget.shrinkWrap,
            scrollDirection: widget.scrollDirection,
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate(
              firstPageProgressIndicatorBuilder: widget.firstPageProgressIndicatorBuilder != null
                  ? (context) => widget.firstPageProgressIndicatorBuilder!
                  : null,
              newPageProgressIndicatorBuilder: widget.newPageProgressIndicatorBuilder != null
                  ? (context) => widget.newPageProgressIndicatorBuilder!
                  : null,
              noItemsFoundIndicatorBuilder: (context) => widget.noItemsFoundIndicatorBuilder != null
                  ? widget.noItemsFoundIndicatorBuilder!
                  : SizedBox(
                      width: double.maxFinite,
                      height: 100.h,
                      child: Center(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ToolsText(
                            'متاسفانه محتوایی جهت نمایش وجود ندارد',
                            style: toolstitleStyle(),
                          ),
                          TextButton.icon(
                              onPressed: () {
                                _pagingController.refresh();
                              },
                              icon: const Icon(Icons.refresh),
                              label: ToolsText(
                                'تلاش دوباره',
                                style: toolscontentStyle(color: Colors.blue),
                              ))
                        ],
                      ))),
              noMoreItemsIndicatorBuilder: widget.noMoreItemsIndicatorBuilder != null
                  ? (context) => widget.noMoreItemsIndicatorBuilder!
                  : null,
              animateTransitions: widget.animateTransitions,
              transitionDuration: widget.transitionDuration,
              itemBuilder: (context, T item, index) {
                return widget.itemBuilder(context, index, item, _pagingController);
              },
            )),
      ),
    );
  }

  // @override
  // void dispose() {
  //   _pagingController.dispose();
  //   super.dispose();
  // }
}
