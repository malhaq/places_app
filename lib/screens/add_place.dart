import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places_app/providers/user_places.dart';
import 'package:places_app/widgets/image_input.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();

  void _savePlace(){
    final enteredName =_titleController.text;
    if(enteredName.isEmpty){
      return;
    } 
    ref.read(userPlacesProvider.notifier).addPlace(enteredName);
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
            const ImageInput(),
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
