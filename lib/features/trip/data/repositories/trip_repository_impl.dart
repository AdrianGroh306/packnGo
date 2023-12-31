import 'package:dartz/dartz.dart';
import 'package:travel_app/core.error/failures.dart';
import 'package:travel_app/features/trip/data/datasources/trip_local_datasource.dart';
import 'package:travel_app/features/trip/data/models/trip_model.dart';
import 'package:travel_app/features/trip/domain/entities/trip.dart';
import 'package:travel_app/features/trip/domain/repositories/trip_repository.dart';

class TripRepositoryImpl implements TripRepository{
  final TripLocalDataSource localDataSource;

  TripRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addTrip(Trip trip) async{
    final tripModel = TripModel.fromEntity(trip);
    localDataSource.addTrip(tripModel);
  }

  @override
  Future<void> deleteTrip(int index)async {
    localDataSource.deleteTrip(index);
  }

  @override
  Future<Either<Failure, List<Trip>>> getTrips()async{
    try{
      final tripModels = localDataSource.getTrip();
      List<Trip> res = tripModels.map((model) => model.toEntity()).toList();
      return Right(res);
    }
   catch(err){
      return Left(SomeSpecificError(err.toString()));
   }
  }
}