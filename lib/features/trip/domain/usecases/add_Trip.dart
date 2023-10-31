import 'package:travel_app/features/trip/domain/entities/trip.dart';
import 'package:travel_app/features/trip/domain/repositories/trip_repository.dart';

class AddTrips{
  final TripRepository repository;

  AddTrips({required this.repository});

  Future<void> call(Trip trip){
   return repository.addTrip(trip);
  }
}