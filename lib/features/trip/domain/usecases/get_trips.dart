import 'package:travel_app/features/trip/domain/entities/trip.dart';
import 'package:travel_app/features/trip/domain/repositories/trip_repository.dart';

class GetTrips{
  final TripRepository repository;

  GetTrips({required this.repository});

  Future<List<Trip>> call(){
    return repository.getTrip();
  }
}