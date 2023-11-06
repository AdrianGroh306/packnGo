import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:travel_app/features/trip/data/datasources/trip_local_datasource.dart';
import 'package:travel_app/features/trip/data/models/trip_model.dart';
import 'package:travel_app/features/trip/data/repositories/trip_repository_impl.dart';
import 'package:travel_app/features/trip/domain/entities/trip.dart';
import 'package:travel_app/features/trip/domain/repositories/trip_repository.dart';
import 'package:travel_app/features/trip/domain/usecases/add_Trip.dart';
import 'package:travel_app/features/trip/domain/usecases/delete_Trip.dart';
import 'package:travel_app/features/trip/domain/usecases/get_trips.dart';

final tripLocalDataSourceProvider = Provider<TripLocalDataSource>((ref) {
  final Box<TripModel> tripBox = Hive.box("trips");
  return TripLocalDataSource(tripBox: tripBox);
});

final tripRepositoryProvider = Provider<TripRepository>((ref) {
  final localDataSource = ref.read(tripLocalDataSourceProvider);
  return TripRepositoryImpl(localDataSource: localDataSource);
});

// add Provider
final addTripsProvider = Provider<AddTrips>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return AddTrips(repository: repository);
});

// get Provider
final getTripsProvider = Provider<GetTrips>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return GetTrips(repository);
});

// delete Provider
final deleteTripsProvider = Provider<DeleteTrips>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return DeleteTrips(repository: repository);
});

final tripListNotifierProvider =
    StateNotifierProvider<TripListNotifier, List<Trip>>((ref) {
  final getTrips = ref.read(getTripsProvider);
  final addTrips = ref.read(addTripsProvider);
  final deleteTrips = ref.read(deleteTripsProvider);

  return TripListNotifier(getTrips, addTrips, deleteTrips);
});

class TripListNotifier extends StateNotifier<List<Trip>> {
  final GetTrips _getTrips;
  final AddTrips _addTrips;
  final DeleteTrips _deleteTrips;

  TripListNotifier(this._getTrips, this._addTrips, this._deleteTrips)
      : super([]);

  Future<void> addNewTrip(Trip trip) async {
    await _addTrips(trip);
  }

  Future<void> removeTrip(int tripId) async {
    await _deleteTrips(tripId);
  }

  Future<void> loadTrips() async{
    final tripsOrFailure = await _getTrips();
    tripsOrFailure.fold((error) => state = [], (trips) => state  = trips);
  }
}
