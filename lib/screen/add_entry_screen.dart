// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journal_app/components.dart';
import '../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AddEntryScreen extends StatefulWidget {
  AddEntryScreen({super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  TextEditingController titleControl = TextEditingController();
  TextEditingController entryControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: kScreenBg,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: prefer_const_constructors
              SizedBox(
                height: 10,
              ),
              // ignore: prefer_const_constructors
              JournyTitle(),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 10,
              ),
              Container(
                width: w * 0.8,
                // ignore: prefer_const_constructors
                padding: EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                decoration: kTextField,
                child: Center(
                  child: TextFormField(
                    controller: titleControl,
                    cursorColor: Colors.white,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Entery Title*',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Container(
                  width: w * 0.8,
                  padding: EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.5,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        15,
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                    reverse: entryControl.text.length > 20 ? true : false,
                    child: Center(
                      child: TextFormField(
                        controller: entryControl,
                        cursorColor: Colors.white,
                        maxLines: 20,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Create new Entry',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              JourneyButton(
                  label: "SAVE",
                  fn: () async {
                    if (titleControl.text.isEmpty == null ||
                        entryControl.text.isEmpty) {
                      print("Please enter titleand entry");
                    } else {
                      await FirebaseFirestore.instance
                          .collection('entries')
                          .add({
                            'Title': titleControl.text,
                            'Entry': entryControl.text,
                            'Date': DateFormat.yMMMEd()
                                .add_jm()
                                .format(DateTime.now())
                          })
                          .then((value) => showFireBaseAlert(context))
                          .catchError((error) => showErrorAlert(context));
                      titleControl.clear();
                      entryControl.clear();
                    }
                  }),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  showFireBaseAlert(BuildContext context) {
    Widget okButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('OK'),
    );
    AlertDialog alert = AlertDialog(
      title: Text('Data Upload Status'),
      content: Text("Entry Added Successfully"),
      actions: [
        okButton,
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  showErrorAlert(BuildContext context) {
    Widget okButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('OK'),
    );
    AlertDialog alert = AlertDialog(
      title: Text('Something Went Wrong'),
      content: Text("Entry not Added Successfully"),
      actions: [
        okButton,
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleControl.dispose();
    entryControl.dispose();
    super.dispose();
  }
}
