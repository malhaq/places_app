import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places_app/model/place.dart';
import 'package:places_app/providers/user_places.dart';
import 'package:places_app/widgets/image_input.dart';
import 'package:places_app/widgets/location_input.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedPicture;
  PlaceLocation? _selectedLocation;

  void _savePlace() {
    final enteredName = _titleController.text;
    if (enteredName.isEmpty ||
        _selectedPicture == null ||
        _selectedLocation == null) {
      return;
    }
    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredName, _selectedPicture!, _selectedLocation!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Place Name',
              ),
              style: const TextStyle(color: Colors.white),
              controller: _titleController,
            ),
            const SizedBox(height: 12),
            ImageInput(
              onSelectedImage: (image) {
                _selectedPicture = image;
              },
            ),
            const SizedBox(height: 12),
            LocationInput(
              onSelectLocation: (location) {
                _selectedLocation = location;
              },
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: () {
                _savePlace();
              },
              label: const Text('Add place'),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
