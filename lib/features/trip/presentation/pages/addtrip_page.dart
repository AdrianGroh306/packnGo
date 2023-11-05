import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/features/trip/domain/entities/trip.dart';
import 'package:travel_app/features/trip/presentation/providers/trip_provider.dart';

class AddTripPage extends ConsumerWidget{
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController(text: "City");
  final _descController = TextEditingController(text: "Desc...");
  final _locationController = TextEditingController(text: "Location...");
  final _pictureController = TextEditingController(text: "Picture...");

  List<String> pictures =[];


  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
          controller: _titleController,
          decoration: InputDecoration(labelText: "Title"),
        ),
        TextFormField(
          controller: _descController,
          decoration: InputDecoration(labelText: "Description"),
        ),
        TextFormField(
          controller: _locationController,
          decoration: InputDecoration(labelText: "Location"),
        ),
        TextFormField(
          controller: _pictureController,
          decoration: InputDecoration(labelText: "Pictures"),
        ),
        ElevatedButton(onPressed: (){
          pictures.add(_pictureController.text);
          if(_formKey.currentState!.validate()){
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
        }, child: Text("Add Trip"))
      ],),
    );
  }





}