import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/features/trip/domain/entities/trip.dart';
import 'package:travel_app/features/trip/presentation/providers/trip_provider.dart';

class AddTripPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController(text: "City");
  final _descController = TextEditingController(text: "Best City ever");
  final _locationController = TextEditingController(text: "Paris");
  final _pictureController =
  TextEditingController(text: "https://res.klook.com/image/upload/Mobile/City/swox6wjsl5ndvkv5jvum.jpg");

  List<String> pictures = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Trip")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                            labelText: "Title", prefixIcon: Icon(Icons.title)),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _descController,
                        decoration: const InputDecoration(
                            labelText: "Description",
                            prefixIcon: Icon(Icons.description)),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _locationController,
                        decoration: const InputDecoration(
                            labelText: "Location",
                            prefixIcon: Icon(Icons.location_on)),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _pictureController,
                        decoration: const InputDecoration(
                            labelText: "Pictures",
                            prefixIcon: Icon(Icons.image)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          pictures.add(_pictureController.text);
          if (_formKey.currentState!.validate()) {
            final newTrip = Trip(
              title: _titleController.text,
              description: _descController.text,
              date: DateTime.now(),
              location: _locationController.text,
              photos: pictures,
            );
            ref.read(tripListNotifierProvider.notifier).addNewTrip(newTrip);
            ref.watch(tripListNotifierProvider.notifier).loadTrips();
          }
        },
      ),
    );
  }
}
