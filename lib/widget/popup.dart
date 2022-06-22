import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Popup extends StatelessWidget {
  final id;
  const Popup({super.key, required this.id});
  dialogContent(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<DocumentSnapshot>(
          future:
              FirebaseFirestore.instance.collection('formula').doc(id).get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text("Formule : ${snapshot.data!['title']}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Oswald', fontSize: 24)),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10.0),
                      child: SizedBox(
                        height: 1,
                        width: 200,
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text("Prix : ${snapshot.data!['price']}"),
                    Text(snapshot.data!['description']),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: 1,
                        width: 200,
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: SizedBox(
                        height: 25,
                        width: 100,
                        child: ElevatedButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Fermer")),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}
