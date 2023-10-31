import 'package:travel_app/features/trip/domain/entities/trip.dart';

abstract class TripRepository{
  Future<List<Trip>>getTrip();
  Future<void>addTrip(Trip trip);
  Future<void>deleteTrip(int index);
}