import 'package:flutter/material.dart';

import '../../sidebarx.dart';

class SidebarXCell extends StatefulWidget {
  const SidebarXCell({
    Key? key,
    required this.item,
    required this.extended,
    required this.selected,
    required this.theme,
    required this.onTap,
    required this.animationController,
  }) : super(key: key);

  final bool extended;
  final bool selected;
  final SidebarXItem item;
  final SidebarXTheme theme;
  final VoidCallback onTap;
  final AnimationController animationController;

  @override
  State<SidebarXCell> createState() => _SidebarXCellState();
}

class _SidebarXCellState extends State<SidebarXCell> {
  late Animation<double> _animation;
  var _hovered = false;

  @override
  void initState() {
    super.initState();
    _animation = CurvedAnimation(
      parent: widget.animationController,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final iconTheme = widget.selected ? theme.selectedIconTheme : theme.iconTheme;
    final textStyle = widget.selected ? theme.selectedTextStyle : theme.textStyle;
    final decoration = (widget.selected ? theme.selectedItemDecoration : theme.itemDecoration);
    final margin = (widget.selected ? theme.selectedItemMargin : theme.itemMargin);
    final padding = (widget.selected ? theme.selectedItemPadding : theme.itemPadding);
    final textPadding = widget.selected ? theme.selectedItemTextPadding : theme.itemTextPadding;

    return MouseRegion(
      onEnter: (_) => _onEnteredCellZone(),
      onExit: (_) => _onExitCellZone(),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: decoration?.copyWith(
            color: _hovered && !widget.selected ? theme.hoverColor : null,
          ),
          padding: padding ?? const EdgeInsets.all(8),
          margin: margin ?? const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: widget.extended ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, _) {
                  final value = ((1 - _animation.value) * 6).toInt();
                  if (value <= 0) {
                    return const SizedBox();
                  }
                  return Spacer(flex: value);
                },
              ),
              if (widget.item.icon != null)
                _Icon(item: widget.item, iconTheme: iconTheme)
              else if (widget.item.iconWidget != null)
                widget.item.iconWidget!,
              Flexible(
                flex: 6,
                child: FadeTransition(
                  opacity: _animation,
                  child: Padding(
                    padding: textPadding ?? EdgeInsets.zero,
                    child: Text(
                      widget.item.label ?? '',
                      style: textStyle,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onEnteredCellZone() {
    setState(() => _hovered = true);
  }

  void _onExitCellZone() {
    setState(() => _hovered = false);
  }
}

class SidebarXCellList extends StatefulWidget {
  const SidebarXCellList({
    Key? key,
    required this.item,
    required this.extended,
    required this.selected,
    required this.theme,
    required this.onTap,
    required this.animationController,
  }) : super(key: key);

  final bool extended;
  final bool selected;
  final SidebarXItemList item;
  final SidebarXTheme theme;
  final VoidCallback onTap;
  final AnimationController animationController;

  @override
  State<SidebarXCellList> createState() => _SidebarXCellListState();
}

class _SidebarXCellListState extends State<SidebarXCellList> {
  var _hovered = false;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _animation = CurvedAnimation(
      parent: widget.animationController,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final iconTheme = widget.selected ? theme.selectedIconTheme : theme.iconTheme;
    final textStyle = widget.selected ? theme.selectedTextStyle : theme.textStyle;
    final decoration = (widget.selected ? theme.selectedItemDecoration : theme.itemDecoration);
    final margin = (widget.selected ? theme.selectedItemMargin : theme.itemMargin);
    final padding = (widget.selected ? theme.selectedItemPadding : theme.itemPadding);
    final textPadding = widget.selected ? theme.selectedItemTextPadding : theme.itemTextPadding;

    return MouseRegion(
      onEnter: (_) => _onEnteredCellZone(),
      onExit: (_) => _onExitCellZone(),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: decoration?.copyWith(
            color: _hovered && !widget.selected ? theme.hoverColor : null,
          ),
          padding: padding ?? const EdgeInsets.all(8),
          margin: margin ?? const EdgeInsets.all(4),
          child:
              // SidebarXCell(
              //     item: widget.item.children.first,
              //     extended: widget.extended,
              //     selected: widget.selected,
              //     theme: theme,
              //     onTap: widget.onTap,
              //     animationController: widget.animationController)

              ExpansionTile(
            leading: Icon(
              widget.item.icon,
              color: iconTheme?.color,
              size: iconTheme?.size,
            ),
            title: Flexible(
              flex: 6,
              child: FadeTransition(
                opacity: _animation,
                child: Padding(
                  padding: textPadding ?? EdgeInsets.zero,
                  child: Text(
                    widget.item.label ?? '',
                    style: textStyle,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
            // Text(
            //   widget.item.label ?? '',
            //   style: textStyle,
            // ),
            children: widget.item.children
                .map((e) => SidebarXCell(
                    item: e,
                    extended: widget.extended,
                    selected: widget.selected,
                    theme: theme,
                    onTap: widget.onTap,
                    animationController: widget.animationController))
                .toList(),
          ),
        ),
      ),
    );
  }

  void _onEnteredCellZone() {
    setState(() => _hovered = true);
  }

  void _onExitCellZone() {
    setState(() => _hovered = false);
  }
}

class _Icon extends StatelessWidget {
  const _Icon({
    Key? key,
    required this.item,
    required this.iconTheme,
  }) : super(key: key);

  final SidebarXItem item;
  final IconThemeData? iconTheme;

  @override
  Widget build(BuildContext context) {
    return Icon(
      item.icon,
      color: iconTheme?.color,
      size: iconTheme?.size,
    );
  }
}
