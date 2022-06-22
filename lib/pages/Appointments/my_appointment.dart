import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detailing_app/pages/Appointments/new_appointment.dart';
import 'package:flutter/material.dart';

class MyAppointment extends StatefulWidget {
  const MyAppointment({super.key});

  @override
  State<MyAppointment> createState() => _MyAppointmentState();
}

class _MyAppointmentState extends State<MyAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Prendre rendez-vous"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('appointment').snapshots(),
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
                                Text(document['description']),
                                Text(document['date']),
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
            MaterialPageRoute(builder: (context) => const NewAppointment()),
          );
        },
        tooltip: 'Ajouter un rendez-vous',
        child: const Icon(Icons.add),
      ),
    );
  }
}


