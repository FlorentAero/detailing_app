import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddNewCar extends StatefulWidget {
  const AddNewCar({super.key});

  @override
  State<AddNewCar> createState() => _AddNewCarState();
}

class _AddNewCarState extends State<AddNewCar> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController model = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController registration = TextEditingController();
  FirebaseApp defaultApp = Firebase.app();
  CollectionReference cars = FirebaseFirestore.instance.collection('cars');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ajouter une voiture"),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  controller: model,
                  decoration: const InputDecoration(hintText: 'Modèle'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez renseigner ce champ.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: year,
                  maxLength: 4,
                  decoration: const InputDecoration(hintText: 'Année'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez renseigner ce champ.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: registration,
                  maxLength: 9,
                  decoration:
                      const InputDecoration(hintText: 'Immatriculation'),
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
                      await cars.add({
                        'model': model.text,
                        'year': year.text,
                        'registration': registration.text
                      });
                      _formKey.currentState!.reset();
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Ajouter'),
                ),
              ],
            ),
          )),
    );
  }
}
