import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              onPressed: () {

              },
              label: const Text('Get current location'),
            ),
            TextButton.icon(
              icon: const Icon(Icons.map_outlined),
              onPressed: () {
                
              },
              label: const Text('Select on Map'),
            ),
          ],
        ),
      ],
    );
  }
}
