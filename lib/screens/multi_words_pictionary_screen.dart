import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../interfaces/iword_repository.dart';
import '../widgets/cards_stack_widget.dart';
import '../widgets/count_down_widget.dart';
import '../widgets/drag_widget.dart';
import '../words_repository.dart';
import 'times_up_screen.dart';

class MultiWordsPictionaryScreen extends StatefulWidget {
  const MultiWordsPictionaryScreen({Key? key}) : super(key: key);

  @override
  State<MultiWordsPictionaryScreen> createState() =>
      _MultiWordsPictionaryScreenState();
}

class _MultiWordsPictionaryScreenState
    extends State<MultiWordsPictionaryScreen> {
  IWordsRepository _wordsRepository = WordsRepository();
  ValueNotifier<Swipe> _swipeNotifier = ValueNotifier(Swipe.none);
  List<String> _words = [];
  List<String> _rejected = [];
  List<String> _accepted = [];

  @override
  void initState() {
    _wordsRepository
        .init()
        .then((repository) => {
              repository
                  .getSelectedCategories()
                  .then((categories) => categories.forEach((category) => {
                        repository
                            .getWords(categoryName: category)
                            .then((value) => {_words.addAll(value)})
                      }))
            })
        .then((value) => setState(() {
              _words = _words;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        ValueListenableBuilder(
          valueListenable: _swipeNotifier,
          builder: (context, swipe, _) => Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: buildWords(),
          ),
        ),
        Positioned(
          right: 0,
          child: createTarget(_accepted),
        ),
        Positioned(
          left: 0,
          child: createTarget(_rejected),
        ),
        Positioned(
          child: CountdownWidget(() {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TimeupScreen(_accepted, _rejected)),
              );
            });
          }),
          bottom: 15,
        )
      ],
    )));
  }

  List<Widget> buildWords() {
    var words = List.generate(_words.length, (index) {
      return DragWidget(
        word: _words[index],
        swipeNotifier: _swipeNotifier,
      );
    });
    return [
      Center(child: Container(child: Text("No more words"))),
      ...words,
    ];
  }

  Widget createTarget(List<String> resultList) {
    return DragTarget<int>(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return IgnorePointer(
          child: Container(
            height: 700.0,
            width: 100.0,
            // color: Colors.red,
          ),
        );
      },
      onAccept: (int index) {
        setState(() {
          resultList.add(_words.last);
          _words.removeLast();
        });
      },
    );
  }
}
