import 'package:flutter/material.dart';

class ToolsSelectableScale extends StatefulWidget {
  const ToolsSelectableScale(
      {Key? key,
      required this.child,
      this.onTap,
      this.reverse = false,
      this.startScale = .85,
      this.endScale = 1.15,
      this.duration = const Duration(milliseconds: 300)})
      : super(key: key);
  final Widget child;
  final Function? onTap;
  final double startScale, endScale;
  final bool reverse;
  final Duration duration;
  @override
  State<ToolsSelectableScale> createState() => _ToolsSelectableScaleState();
}

class _ToolsSelectableScaleState extends State<ToolsSelectableScale>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        value: .5,
        duration: widget.duration,
        reverseDuration: widget.duration);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.reverse) {
          _controller.forward().then((value) => _controller.reverse().then(
              (value) => _controller
                      .animateTo(.5, duration: widget.duration)
                      .then((value) {
                    if (widget.onTap != null) {
                      widget.onTap!();
                    }
                  })));
        } else {
          _controller.reverse().then((value) => _controller.forward().then(
              (value) => _controller
                      .animateTo(.5, duration: widget.duration)
                      .then((value) {
                    if (widget.onTap != null) {
                      widget.onTap!();
                    }
                  })));
        }
      },
      child: ScaleTransition(
        alignment: Alignment.center,
        scale: Tween<double>(begin: widget.startScale, end: widget.endScale)
            .animate(_controller),
        child: widget.child,
      ),
    );
  }
}
