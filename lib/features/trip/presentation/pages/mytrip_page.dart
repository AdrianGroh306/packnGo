import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/features/trip/presentation/providers/trip_provider.dart';

class MyTripPage extends ConsumerWidget {
  const MyTripPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final tripList = ref.watch(tripListNotifierProvider);


    return ListView.builder(itemBuilder: (context, index){
      final trip = tripList[index];
      return Text(trip.title);
    });
  }
}
