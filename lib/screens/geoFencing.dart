import 'package:flutter/material.dart';

import 'add_petProfile.dart';
import 'custom_drawer.dart';

class GeoFencingPage extends StatelessWidget {
  const GeoFencingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeoFencing'),
      ),

      drawer: const CustomDrawer(),

      body: Stack(
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addGeofence(context);
        },
        child: Icon(Icons.add), // You can change the icon as needed
      ),
    );
  }
  Future<void> _addGeofence(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add geofence'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Longitude'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Latitude'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Radious'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                // Add logic to handle adding the meal here
                // Extract the values from the text fields and process accordingly
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
