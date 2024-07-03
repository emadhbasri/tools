import 'package:flutter/material.dart';
export 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ToolsTableCellPadding extends StatelessWidget {
  const ToolsTableCellPadding(
      {super.key, required this.child, this.padding = const EdgeInsets.all(8)});
  final Widget child;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

class ToolsTableCellCenter extends StatelessWidget {
  const ToolsTableCellCenter({super.key, required this.child, this.alignment = Alignment.center});
  final Widget child;
  final Alignment alignment;
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Align(
        alignment: alignment,
        child: child,
      ),
    );
  }
}

class ToolsTableCellCenterPadding extends StatelessWidget {
  const ToolsTableCellCenterPadding(
      {super.key,
      required this.child,
      this.alignment = Alignment.center,
      this.padding = const EdgeInsets.all(5)});
  final Widget child;
  final EdgeInsets padding;
  final Alignment alignment;
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: padding,
        child: Align(
          alignment: alignment,
          child: child,
        ),
      ),
    );
  }
}

class ToolsCenterPadding extends StatelessWidget {
  const ToolsCenterPadding(
      {super.key,
      required this.child,
      this.alignment = Alignment.center,
      this.padding = const EdgeInsets.all(5)});
  final Widget child;
  final EdgeInsets padding;
  final Alignment alignment;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Align(
        alignment: alignment,
        child: child,
      ),
    );
  }
}

abstract class ToolsTableData {
  List<DataTableMy> headers(int index);
}

class ToolsTableList extends StatefulWidget {
  const ToolsTableList({
    Key? key,
    required this.list,
    this.step = 20,
    required this.isLastPage,
    required this.loadMore,
    this.onLongPress,
    this.onTap,
  }) : super(key: key);
  final List<ToolsTableData> list;
  final bool isLastPage;
  final int step;
  final VoidCallback loadMore;
  final Function(int)? onLongPress;
  final Function(int)? onTap;
  @override
  State<ToolsTableList> createState() => _ToolsTableListState();
}

class _ToolsTableListState extends State<ToolsTableList> with AutomaticKeepAliveClientMixin {
  late ScrollController horizontal;
  late ScrollController vertical;

  @override
  void initState() {
    super.initState();
    horizontal = ScrollController();
    vertical = ScrollController();
    if (widget.list.length >= widget.step) {
      pages = widget.list.length ~/ widget.step;
      out = widget.list.sublist(page * widget.step, (page * widget.step) + widget.step);
      page++;

      vertical.addListener(() {
        if (widget.list.isNotEmpty) {
          if (vertical.position.atEdge && vertical.offset != 0.0) {
            if (pages > page) {
              setState(() {
                out.addAll(
                    widget.list.sublist(page * widget.step, (page * widget.step) + widget.step));
                page++;
              });
            } else if (pages == page) {
              setState(() {
                out.addAll(widget.list.sublist(page * widget.step, widget.list.length));
                page++;
              });
            }
          }
        }
      });
    } else {
      if (widget.isLastPage == false) {
        widget.loadMore();
      } else {
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
          style: Theme.of(context).textTheme.headlineSmall,
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
                return makeRow(item.headers(index), index,
                    onLongPress: widget.onLongPress, onTap: widget.onTap);
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

class ScrollViewHV extends StatelessWidget {
  const ScrollViewHV({
    super.key,
    required this.horizontalController,
    required this.verticalController,
    required this.child,
  });
  final Widget child;
  final ScrollController horizontalController, verticalController;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        controller: horizontalController,
        child: SingleChildScrollView(
            controller: horizontalController,
            scrollDirection: Axis.horizontal,
            child: Scrollbar(
                controller: verticalController,
                child: SingleChildScrollView(controller: verticalController, child: child))));
  }
}

List<DataColumn> makeColumn(List<DataTableMy> data) => data
    .map(
      (e) => DataColumn(
        label: Text(
          e.head,
          style: e.style,
        ),
        numeric: e.numeric,
      ),
    )
    .toList();

DataRow makeRow(
  List<DataTableMy> data,
  int index, {
  Function(int)? onTap,
  List<DataCell>? firstCells,
  List<DataCell>? addCells,
  ValueChanged<bool?>? onSelectChanged,
  Function(int)? onLongPress,
  bool selected = false,
  Color? color,
}) =>
    DataRow(
        selected: selected,
        onLongPress: () {
          if (onLongPress != null) {
            onLongPress(index);
          }
        },
        onSelectChanged: onSelectChanged,
        color: color != null ? MaterialStatePropertyAll(color) : null,
        cells: [
          if (firstCells != null) ...firstCells,
          ...data
              .map((e) => DataCell(
                  e.child == null
                      ? Text(
                          e.content,
                          style: e.style,
                        )
                      : e.child!,
                  onTap: e.doIt != null
                      ? () {
                          e.doIt!();
                        }
                      : e.click == true || onTap !=null
                          ? () {
                              onTap!(index);
                            }
                          : null,
                  showEditIcon: e.editIcon))
              .toList(),
          if (addCells != null) ...addCells
        ]);

class DataTableMy {
  final Function? doIt;
  final String head;
  final String content;
  final Widget? child;
  final bool numeric, editIcon, click;
  final String tooltip;
  final TextStyle? style;

  DataTableMy(this.head, this.content,
      {this.numeric = false,
      this.click = false,
      this.style,
      this.child,
      this.tooltip = '',
      this.doIt,
      this.editIcon = false});
}
