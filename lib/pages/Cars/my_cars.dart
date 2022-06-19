import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detailing_app/pages/Cars/add_new_car.dart';
import 'package:flutter/material.dart';

class MyCars extends StatefulWidget {
  const MyCars({super.key});

  @override
  State<MyCars> createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Mes voitures"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('cars').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Container(
                        decoration: new BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Color.fromARGB(255, 249, 255, 193)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(document['model']),
                                Text(document['year']),
                                Text(document['registration'])
                              ],
                            ),
                            SizedBox(height: 1, width: double.infinity)
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNewCar()),
          );
        },
        tooltip: 'Ajouter une voiture',
        child: const Icon(Icons.add),
      ),
    );
  }
}
