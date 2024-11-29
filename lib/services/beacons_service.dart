import 'package:findflow_mobile/models/beacon_model.dart';
import 'package:findflow_mobile/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'beacons_service.g.dart';

sealed class BeaconsState {}

class BeaconsInitial extends BeaconsState {}

class BeaconsLoading extends BeaconsState {}

class BeaconsLoaded extends BeaconsState {
  final Map<String, Beacon> beacons;
  BeaconsLoaded(this.beacons);
}

class BeaconsError extends BeaconsState {
  final String message;
  BeaconsError(this.message);
}

@riverpod
class BeaconsService extends _$BeaconsService {
  @override
  BeaconsState build() => BeaconsInitial();

  Future<Map<String, Beacon>> getBeaconNames(List<String> addresses) async {
    final dio = ref.read(dioProvider);
    state = BeaconsLoading();

    final response =
        await dio.post<Map<String, dynamic>>('/beacon_names', data: {
      'array_mac': addresses,
    });

    Map<String, Beacon> beacons = {};

    if (response.data == null) {
      state = BeaconsError('No beacons found');
      return beacons;
    }

    for (String key in response.data!.keys) {
      final String? name = response.data?[key]['name'];
      final String? data_type = response.data?[key]['data_type'];
      final String? data = response.data?[key]['data'];

      if (name == null || data_type == null || data == null) continue;

      beacons[key] = Beacon(
        name: name,
        data_type: data_type,
        data: data,
      );
    }

    print("setting state to BeaconsLoaded");

    state = BeaconsLoaded(beacons);

    return beacons;
  }

  setBeacons(Map<String, Beacon> beacons) {
    state = BeaconsLoaded(beacons);
  }
}
