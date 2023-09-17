import 'package:bio2/other/AboutUs.dart';
import 'package:bio2/other/papers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class Fab extends StatelessWidget {
  final _counter = ValueNotifier(0);

  Fab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = GlobalObjectKey<ExpandableFabState>(context);
    return ExpandableFab(
        key: key,
        // duration: const Duration(seconds: 1),
        // distance: 60.0,
        // type: ExpandableFabType.up,
        // fanAngle: 70,
        child: const Icon(
          Icons.menu,
          size: 30,
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        closeButtonStyle: const ExpandableFabCloseButtonStyle(
          child: Icon(Icons.close),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
        ),
        overlayStyle: ExpandableFabOverlayStyle(
          // color: Colors.black.withOpacity(0.5),
          blur: 5,
        ),
        onOpen: () {
          debugPrint('onOpen');
        },
        afterOpen: () {
          debugPrint('afterOpen');
        },
        onClose: () {
          debugPrint('onClose');
        },
        afterClose: () {
          debugPrint('afterClose');
        },
        children: [
          FloatingActionButton.large(
            foregroundColor: Colors.blue,
            backgroundColor: Colors.white,
            heroTag: null,
            child: const Icon(
              Icons.info_outline_rounded,
              size: 50,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUs()),
              );
            },
          ),
          FloatingActionButton.large(
            foregroundColor: Colors.blue,
            backgroundColor: Colors.white,
            heroTag: null,
            child: const Icon(Icons.newspaper_rounded, size: 50),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => const Papers())));
            },
          ),
        ]);
  }
}
