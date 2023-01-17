import 'package:flutter/material.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart'
    as shadow;

class NeonButton extends StatefulWidget {
  const NeonButton({Key? key}) : super(key: key);

  @override
  State<NeonButton> createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    Color shadowColor = Colors.red;
    // Color shadowColor = Colors.blueAccent.shade700;
    // Color shadowColor = Colors.purpleAccent.shade700;
    // Color shadowColor = Colors.greenAccent.shade700;
    Color backgroundColor = shadowColor.withOpacity(.7);
    return Scaffold(
      backgroundColor: const Color(0xFF00000f),
      body: Center(
        child: Listener(
          onPointerDown: (_) {
            setState(() {
              isPressed = true;
            });
          },
          onPointerUp: (_) {
            setState(() {
              isPressed = false;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            decoration: shadow.BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isPressed?backgroundColor:null,
                boxShadow: [
                  for (double j = 1; j < 5; j++)
                    shadow.BoxShadow(
                        blurRadius: (isPressed?5:3) * j,
                        color: shadowColor,
                        inset: true,
                        ),

                        for (double j = 1; j < 5; j++)
                    shadow.BoxShadow(
                        blurRadius: (isPressed?5:3) * j,
                        color: shadowColor,
                        spreadRadius: -1,
                        blurStyle: BlurStyle.outer),
                ]),
            child: TextButton(
              onHover: (hovered) {
                setState(() {
                  isPressed = hovered;
                });
              },
              style: TextButton.styleFrom(
                  side: const BorderSide(color: Colors.white, width: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              onPressed: () {},
              child: Text(
                'Neon Button',
                style: TextStyle(color: Colors.white, shadows: [
                  for (double j = 1; j < (isPressed ? 8 : 4); j++)
                    Shadow(blurRadius: 3 * j, color: shadowColor),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
