import 'package:travel_app/features/trip/domain/entities/trip.dart';

import '../../../../core.error/failures.dart';

abstract class TripRepository{
  Future<Either<Failure,List<Trip>>>getTrip();
  Future<void>addTrip(Trip trip);
  Future<void>deleteTrip(int index);
}