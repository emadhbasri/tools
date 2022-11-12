import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
export 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ToolsListViewData<T> {
  List<T>? data;
  final bool isLastPage;

  ToolsListViewData({required this.data, this.isLastPage = false});
}

class ToolsListView<T> extends StatefulWidget {
  const ToolsListView(
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
      this.noMoreItemsIndicatorBuilder})
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
  final ScrollController? scrollController;
  final Widget? firstPageProgressIndicatorBuilder,
      newPageProgressIndicatorBuilder,
      noItemsFoundIndicatorBuilder,
      noMoreItemsIndicatorBuilder;

  @override
  State<ToolsListView<T>> createState() => _ToolsListViewState<T>();
}

class _ToolsListViewState<T> extends State<ToolsListView<T>> {
  late PagingController<int, T> _pagingController;
  // static const _pageSize = 10;

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
                          ? (context) =>
                              widget.firstPageProgressIndicatorBuilder!
                          : null,
                  newPageProgressIndicatorBuilder:
                      widget.newPageProgressIndicatorBuilder != null
                          ? (context) => widget.newPageProgressIndicatorBuilder!
                          : null,
                  noItemsFoundIndicatorBuilder:
                      widget.noItemsFoundIndicatorBuilder != null
                          ? (context) => widget.noItemsFoundIndicatorBuilder!
                          : null,
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
                          ? (context) =>
                              widget.firstPageProgressIndicatorBuilder!
                          : null,
                  newPageProgressIndicatorBuilder:
                      widget.newPageProgressIndicatorBuilder != null
                          ? (context) => widget.newPageProgressIndicatorBuilder!
                          : null,
                  noItemsFoundIndicatorBuilder:
                      widget.noItemsFoundIndicatorBuilder != null
                          ? (context) => widget.noItemsFoundIndicatorBuilder!
                          : null,
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





abstract class ToolsTableData {
  List<DataTableMy> headers(int index);
}

class ToolsTableList extends StatefulWidget {
  const ToolsTableList(
      {Key? key, required this.list, this.step = 20, required this.isLastPage, required this.loadMore})
      : super(key: key);
  final List<ToolsTableData> list;
  final bool isLastPage;
  final int step;
  final VoidCallback loadMore;
  @override
  State<ToolsTableList> createState() => _ToolsTableListState();
}

class _ToolsTableListState extends State<ToolsTableList>
    with AutomaticKeepAliveClientMixin {
  late ScrollController horizontal;
  late ScrollController vertical;

  @override
  void initState() {
    super.initState();
    horizontal = ScrollController();
    vertical = ScrollController();
    if (widget.list.length >= widget.step) {
      pages = widget.list.length ~/ widget.step;
      out = widget.list
          .sublist(page * widget.step, (page * widget.step) + widget.step);
      page++;

      vertical.addListener(() {
        if (widget.list.isNotEmpty) {
          if (vertical.position.atEdge && vertical.offset != 0.0) {
            if (pages > page) {
              setState(() {
                out.addAll(widget.list.sublist(
                    page * widget.step, (page * widget.step) + widget.step));
                page++;
              });
            } else if (pages == page) {
              setState(() {
                out.addAll(widget.list
                    .sublist(page * widget.step, widget.list.length));
                page++;
              });
            }
          }
        }
      });
    } else {
      if(widget.isLastPage==false){
        widget.loadMore();
      }else{
        out = widget.list;
      }
    }
  }

  List<ToolsTableData> out = [];
  int page = 0;
  late int pages;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (out.isEmpty) {
      return Center(
        child: Text(
          'دیتا ای برای نمایش وجود ندارد',
          style: Theme.of(context).textTheme.headline5,
        ),
      );
    }
    return Scrollbar(
      scrollbarOrientation: ScrollbarOrientation.bottom,
      thumbVisibility: true,
      trackVisibility: true,
      controller: horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: horizontal,
        child: Scrollbar(
          controller: vertical,
          scrollbarOrientation: ScrollbarOrientation.right,
          thumbVisibility: true,
          trackVisibility: true,
          child: SingleChildScrollView(
            controller: vertical,
            child: DataTable(
              columns: makeColumn(widget.list.first.headers(0)),
              rows: List.generate(out.length, (index) {
                ToolsTableData item = out[index];
                return makeRow(item.headers(index));
                // DataRow(cells: [
                //   DataCell(Text((index + 1).toString())),
                //   DataCell(Text(item.id.toString())),
                //   DataCell(Text(item.name ?? '')),
                //   DataCell(SelectableText(item.family ?? '')),
                //   DataCell(Text(item.tedadSefaresh.toString().toPrice)),
                //   DataCell(Text(item.tedadSahmBuy.toString().toPrice)),
                //   DataCell(Text(item.priceBuy.toString().toPrice)),
                //   DataCell(Text((item.realPriceBuy/item.tedadSahmBuy).toStringAsFixed(1).toPrice)),
                //   DataCell(Text(item.realPriceBuy.toString().toPrice)),
                //   DataCell(Text(item.tedadSahmSell.toString().toPrice)),
                //   DataCell(Text(item.priceSell.toString().toPrice)),
                //   DataCell(Text((item.realPriceSell/item.tedadSahmSell).toStringAsFixed(1).toPrice)),
                //   DataCell(Text(item.realPriceSell.toString().toPrice)),
                //   DataCell(Text(item.tedadSahm.toString().toPrice)),
                // ]);
              }),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

List<DataColumn> makeColumn(List<DataTableMy> data) => data
    .map(
      (e) => DataColumn(
          label: Text(e.head),
          numeric: e.numeric,
          tooltip: e.tooltip != '' ? e.tooltip : e.head),
    )
    .toList();

DataRow makeRow(
  List<DataTableMy> data, {
  ValueChanged<bool?>? onSelectChanged,
  GestureLongPressCallback? onLongPress,
  bool selected = false,
  Color? color,
}) =>
    DataRow(
        selected: selected,
        onLongPress: onLongPress,
        onSelectChanged: onSelectChanged,
        color: color != null ? MaterialStatePropertyAll(color) : null,
        cells: data
            .map((e) => DataCell(Text(e.content), showEditIcon: e.editIcon))
            .toList());

class DataTableMy {
  final String head;
  final String content;
  final bool numeric, editIcon;
  final String tooltip;

  DataTableMy(this.head, this.content,
      {this.numeric = false, this.tooltip = '', this.editIcon = false});
}
