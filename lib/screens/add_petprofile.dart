import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dashboard.dart';

class AddPetProfilePage extends StatelessWidget {
  const AddPetProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          title: const Text(
            'Add Pet Profile',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PetForm(),
        ),
      ),
    );
  }
}

class PetForm extends StatefulWidget {
  @override
  createState() => _PetFormState();
}

class _PetFormState extends State<PetForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _speciesController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  void _addPet() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Dashboard()),
    );

    String name = _nameController.text;
    String breed = _breedController.text;
    String species = _speciesController.text;
    String age = _ageController.text;
    String gender = _genderController.text;

    // Create a map to represent your data
    final Map<String, dynamic> data = {
      "name": name,
      "species": species,
      "breed": breed,
      "age": age,
      "gender": gender
    };

    final response = await http.post(
      Uri.parse('http://127.0.0.1:8080/furry/profile'),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      // Successful login
      final responseJson = json.decode(response.body);
      print("Register successful: $responseJson");

      // Navigate to the Dashboard or perform other actions

    } else {
      print("pet adding failed with status code ${response.statusCode}");
    }

  }


  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: SingleChildScrollView(
        child: Container(
          width: 300,
          height: 500,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/add_image.png',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
                TextFormField(
                  controller: _nameController,
                  decoration:
                  const InputDecoration(labelText: 'Pet Name'),
                  validator: (value) {
                    return null;
                  },
                ),
                TextFormField(
                  controller: _speciesController,
                  decoration:
                  const InputDecoration(labelText: 'Species'),
                  validator: (value) {
                    return null;
                  },
                ),
                TextFormField(
                  controller: _breedController,
                  decoration: const InputDecoration(labelText: 'Breed'),
                  validator: (value) {
                    return null;
                  },
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  validator: (value) {
                    return null;
                  },
                ),
                TextFormField(
                  controller: _genderController,
                  decoration: const InputDecoration(labelText: 'Gender'),
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA6CF6F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    minimumSize: const Size(100, 50),
                  ),
                  onPressed: _addPet,
                  child: const Text('Add Pet'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}