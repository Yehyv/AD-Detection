import 'package:bio2/ObjectDetection.dart';
import 'package:bio2/custom%20widgets/Disease_card.dart';
import 'package:bio2/custom%20widgets/FAB.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool firststate = false;
  bool message = true;
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    // detectionScreen().init();
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/home3.png',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ObjectDetection(
                                title: 'Detection',
                              )
                          // detectionScreen()
                          // HomeScreen()
                          ),
                    );
                  },
                  child: DiseaseCard(
                    image: 'Brain Tumour.jpg',
                    diseaseName: "AD Detection",
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: Fab(),
      ),
    );
  }
}
