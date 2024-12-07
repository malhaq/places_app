import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places_app/providers/user_places.dart';
import 'package:places_app/screens/add_place.dart';
import 'package:places_app/widgets/place_list.dart';

class PlaceScreen extends ConsumerWidget {
  const PlaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesList = ref.watch(userPlacesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const AddPlaceScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0,left: 8.0,bottom: 8.0,right:8.0),
        child: PlaceList(places: placesList),
      ),
    );
  }
}
