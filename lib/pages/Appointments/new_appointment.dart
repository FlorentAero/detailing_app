import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewAppointment extends StatefulWidget {
  const NewAppointment({super.key});

  @override
  State<NewAppointment> createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController description = TextEditingController();
  TextEditingController _date = TextEditingController();
  FirebaseApp defaultApp = Firebase.app();
  CollectionReference Appointment =
      FirebaseFirestore.instance.collection('appointment');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Prendre rendez-vous"),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  controller: description,
                  decoration: const InputDecoration(
                      hintText: 'Description',
                      labelText: 'Description',
                      prefixIcon: Icon(Icons.newspaper_outlined)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez renseigner ce champ.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _date,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today_rounded),
                      labelText: "Choisissez la date"),
                  onTap: () async {
                    DateTime? pickeddate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2100));

                    if (pickeddate != null) {
                      setState(() {
                        _date.text =
                            DateFormat('yyyy-MM-dd').format(pickeddate);
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez renseigner ce champ.';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await Appointment.add({
                        'date': _date.text,
                        'description': description.text,
                      });
                      _formKey.currentState!.reset();
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Valider'),
                ),
              ],
            ),
          )),
    );
  }
}
