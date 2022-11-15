// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:pictionary2/widgets/count_down_widget.dart';
// import '../screens/times_up_screen.dart';
// import 'drag_widget.dart';
//
// class CardsStackWidget extends StatefulWidget {
//   const CardsStackWidget({Key? key}) : super(key: key);
//
//   @override
//   State<CardsStackWidget> createState() => _CardsStackWidgetState();
// }
//
// class _CardsStackWidgetState extends State<CardsStackWidget> {
//   ValueNotifier<Swipe> _swipeNotifier = ValueNotifier(Swipe.none);
//   List<String> _words = ["apple", "dog", "cat"];
//   List<String> _rejected = [];
//   List<String> _accepted = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return
//
//   List<Widget> buildWords() {
//     var words = List.generate(_words.length, (index) {
//       return DragWidget(
//         word: _words[index],
//         swipeNotifier: _swipeNotifier,
//       );
//     });
//     return [
//       Center(child: Container(child: Text("No more words"))),
//       ...words,
//     ];
//   }
//
//   Widget createTarget(List<String> resultList) {
//     return DragTarget<int>(
//       builder: (
//         BuildContext context,
//         List<dynamic> accepted,
//         List<dynamic> rejected,
//       ) {
//         return IgnorePointer(
//           child: Container(
//             height: 700.0,
//             width: 100.0,
//             // color: Colors.red,
//           ),
//         );
//       },
//       onAccept: (int index) {
//         setState(() {
//           resultList.add(_words.last);
//           _words.removeLast();
//         });
//       },
//     );
//   }
// }
