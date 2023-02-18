import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screens/note_reader.dart';
import 'package:note_app/style/app_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'FireNotes',
          style: TextStyle(),
        ),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your recent Notes',
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Notes').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapShot) {
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapShot.hasData) {
                    return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      children: snapShot.data!.docs
                          .map((note) => noteCard(() {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return NoteReaderScreen(note);
                                }));
                              }, note))
                          .toList(),
                    );
                  }
                  return Text(
                    "There's No Notes",
                    style: GoogleFonts.nunito(color: Colors.white),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Add Note'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
