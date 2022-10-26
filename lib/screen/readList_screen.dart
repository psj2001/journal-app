// ignore_for_file: prefer_const_constructors
import 'add_entry_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:journal_app/components.dart';
import '../constants.dart';

class ReadEntryScreen extends StatefulWidget {
  final List<QueryDocumentSnapshot> docs;

  const ReadEntryScreen({
    super.key,
    required this.docs,
  });

  @override
  State<ReadEntryScreen> createState() => _ReadEntryScreenState();
}

class _ReadEntryScreenState extends State<ReadEntryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: kScreenBg,
          child: widget.docs.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    JournyTitle(),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Please Add Entry ',
                          style: KButtonText,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    JourneyButton(
                      label: 'Add Entry',
                      fn: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddEntryScreen()),
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    JournyTitle(),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return EntryTile(
                            title: widget.docs.elementAt(index)['Title'],
                            entry: widget.docs.elementAt(index)['Entry'],
                            dateTime: widget.docs.elementAt(index)['Date'],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 20,
                          );
                        },
                        itemCount: widget.docs.length,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    JourneyButton(
                      label: "BACK",
                      fn: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
