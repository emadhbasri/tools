import 'package:flutter/material.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart'
    as shadow;

class NeumorphismButton extends StatefulWidget {
  const NeumorphismButton({Key? key}) : super(key: key);

  @override
  State<NeumorphismButton> createState() => _NeumorphismButtonState();
}

class _NeumorphismButtonState extends State<NeumorphismButton> {
  bool isPressed = false;
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        isDarkMode ? const Color(0xff2e3239) : const Color(0xFFe7ecef);
    double blur = isPressed ? 5 : 30;
    Offset distance = isPressed ? const Offset(10, 10) : const Offset(28, 28);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Listener(
          onPointerUp: (_) {
            setState(() {
              isPressed = false;
            });
          },
          onPointerDown: (_) {
            setState(() {
              isPressed = true;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            decoration: shadow.BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  shadow.BoxShadow(
                      inset: isPressed,
                      blurRadius: blur,
                      offset: -distance,
                      color:
                          isDarkMode ? const Color(0xFF35393f) : Colors.white),
                  shadow.BoxShadow(
                      inset: isPressed,
                      blurRadius: blur,
                      offset: distance,
                      color: isDarkMode
                          ? const Color(0xFF23262a)
                          : const Color(0xffa7a9af))
                ]),
            child: const SizedBox(
              height: 200,
              width: 200,
            ),
          ),
        ),
      ),
    );
  }
}
