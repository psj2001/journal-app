import 'package:flutter/material.dart';
import 'package:journal_app/screen/add_entry_screen.dart';
import 'package:journal_app/screen/readList_screen.dart';
import '../constants.dart';
import '../components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: w,
          height: h,
          decoration: kScreenBg,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              JournyTitle(),
              SizedBox(
                height: h * 0.045,
              ),
              Image(
                image: AssetImage('images/journal.png'),
                width: w * 0.51,
                height: h * 0.23,
              ),
              SizedBox(
                height: h * 0.08,
              ),
              JourneyButton(
                label: 'Read Entry',
                fn: () async {
                  await FirebaseFirestore.instance
                      .collection('entries')
                      .get()
                      .then(
                    (snapshot) {
                      List<QueryDocumentSnapshot> docList = snapshot.docs;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReadEntryScreen(docs: docList),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              JourneyButton(
                label: 'Add Entry',
                fn: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddEntryScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
