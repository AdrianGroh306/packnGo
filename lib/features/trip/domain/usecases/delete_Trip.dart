import 'package:travel_app/features/trip/domain/entities/trip.dart';
import 'package:travel_app/features/trip/domain/repositories/trip_repository.dart';

class DeleteTrips{
  final TripRepository repository;

  DeleteTrips({required this.repository});

  Future<void> call(int index){
    return repository.deleteTrip(index);
  }
}