import 'dart:io';

import 'package:devoir/form/boutons.dart';
import 'package:devoir/form/les_input.dart';
import 'package:devoir/les_models/cands.dart';
import 'package:flutter/material.dart';

class FormulaireCandidat extends StatefulWidget {
  const FormulaireCandidat({super.key});

  @override
  State<FormulaireCandidat> createState() => _FormulaireCandidatState();
}

class _FormulaireCandidatState extends State<FormulaireCandidat> {
  final _formKey = GlobalKey<FormState>();
  final Candidate candidate = Candidate();
  List<File> files = [];

  void takeImage() async {
    final ImagePicker picker = ImagePicker();
    final File? image = await picker.pickImage(source: ImageSource.gallery);
    print("Image ${image!.path}");
    var file = File(image.path);
    setState(() {
      candidate.imageFile = file;
      files.add(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un candidat'),
      ),
      body: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          child: Form(
              key: _formKey,
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.brown.shade50,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: candidate.imageFile == null
                            ? const AssetImage('assets/images/default_image.png')
                            : FileImage(candidate.imageFile!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: IconButton(
                        onPressed: () {
                          takeImage();
                        },
                        icon: Icon(Icons.photo)),
                  ),
                ),
                SizedBox(height: 20),
                InputForm(
                  name: 'Nom',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Champ obligatoire";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    candidate.name = value;
                  },
                  prefixIcon: Icon(Icons.person),
                ),
                SizedBox(height: 20),
                InputForm(
                  name: 'Prénom',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Champ obligatoire";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    candidate.surname = value;
                  },
                  prefixIcon: Icon(Icons.person),
                ),
                SizedBox(height: 20),
                InputForm(
                  name: 'Parti politique',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Champ obligatoire";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    candidate.parti_politique = value;
                  },
                  prefixIcon: Icon(Icons.flag),
                ),
                SizedBox(height: 20),
                InputForm(
                  name: 'Description',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Champ obligatoire";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    candidate.describe = value;
                  },
                  prefixIcon: Icon(Icons.info),
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text("Date de naissance"),
                  subtitle: Text("${candidate.birthdate}"),
                  trailing: Icon(Icons.calendar_month),
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      cancelText: "Annuler",
                      confirmText: "Confirmer",
                      barrierColor: Colors.green.shade50,
                      context: context,
                      firstDate: DateTime(1990),
                      lastDate: DateTime.now(),
                    );

                    if (selectedDate != null) {
                      setState(() {
                        candidate.birthdate = selectedDate;
                      });
                    }
                  },
                ),
              ]))),
      bottomNavigationBar: BottomAppBar(
        child: ButtonForm(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Navigator.pop(context, candidate);
            }
          },
          text: 'ajouter',
        ),
      ),
    );
  }
}

