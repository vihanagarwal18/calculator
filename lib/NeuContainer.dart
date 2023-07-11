import 'package:calculator/homepage.dart';
import 'package:flutter/material.dart';
import 'package:calculator/calculator_logic.dart';
class NeuContainer extends StatefulWidget {
  final bool darkMode;
  final Widget child;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  NeuContainer(
      {this.darkMode = false, required this.child,required this.borderRadius,required this.padding});
  @override
  _NeuContainerState createState() => _NeuContainerState();
}
class _NeuContainerState extends State<NeuContainer> {
  bool _isPressed = false;
  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }
  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    bool darkMode = widget.darkMode;
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
            color: darkMode ? colorDark : colorLight,
            borderRadius: widget.borderRadius,
            boxShadow: _isPressed
                ? null
                : [
              BoxShadow(
                color:
                darkMode ? Colors.black54 : Colors.blueGrey.shade200,
                offset: Offset(4.0, 4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
              BoxShadow(
                  color:
                  darkMode ? Colors.blueGrey.shade700 : Colors.white,
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0)
            ]),
        child: widget.child,
      ),
    );
  }
}
// class NeuContainer extends StatefulWidget {
//   final bool darkMode;
//   final Widget child;
//   final BorderRadius borderRadius;
//   final EdgeInsetsGeometry padding;
//
//   NeuContainer({this.darkMode=false,required this.child,required this.borderRadius,required this.padding})
//   //const NeuContainer({Key? key}) : super(key: key);
//   @override
//   State<NeuContainer> createState() => _NeuContainerState();
// }
// class _NeuContainerState extends State<NeuContainer> {
//   bool _isPressed=false;
//   void _onPointerDown(PointerDownEvent event) {
//     setState(() {
//       _isPressed = true;
//     });
//   }
//   void _onPointerUp(PointerUpEvent event){
//     setState(() {
//       _isPressed=false;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     bool darkMode=widget.darkMode;
//     return Listener(
//       onPointerDown: _onPointerDown,
//       onPointerUp: _onPointerUp,
//       child: Container(
//         padding: widget.padding,//EdgeInsets.all(20.0),
//         decoration:BoxDecoration(
//           color: darkMode ? colorDark :colorLight,
//           borderRadius: widget.borderRadius,//BorderRadius.circular(10),
//           boxShadow: _isPressed
//               ? null
//                 : [
//                     BoxShadow(
//                       color: darkMode ? Colors.black54 : Colors.blueGrey.shade200,
//                       offset: Offset(4.0,4.0), //shadow aur object ke beech ka distance (x,y)
//                       blurRadius: 15.0,
//                       spreadRadius: 1.0,
//                     ),
//                     BoxShadow(
//                       color: darkMode ? Colors.blueGrey.shade700 : Colors.white,
//                       offset: Offset(-4.0,-4.0),
//                       blurRadius: 15.0,
//                       spreadRadius: 1.0,
//                     )
//                   ]
//         ),
//         child: widget.child,//Icon(Icons.android,size:100),
//       ),
//     );
//   }
// }
