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
  FirebaseApp defaultApp = Firebase.app();
  CollectionReference voitures =
      FirebaseFirestore.instance.collection('voitures');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ajouter une voiture"),
      ),
      body: Form(
          key: _formKey,
          child: Column(
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
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await voitures.add({
                      'model': model.text,
                    });
                    _formKey.currentState!.reset();
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Valider'),
              ),
            ],
          )),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: '',
        child: Icon(Icons.add),
      ),
    );
  }
}
