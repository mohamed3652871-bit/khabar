import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(InitMapState()) {
    _init();
  }

  final TextEditingController searchController = TextEditingController();

  GoogleMapController? mapController;

  Set<Marker> markers = {};

  LatLng initLatLng =
  const LatLng(30.04855406300429, 31.22707262635231);

  LatLng? selectedLatLng;

  static MapCubit get(BuildContext context) =>
      BlocProvider.of<MapCubit>(context);

  /// 👇 بدل ما تنادي مباشرة في constructor
  Future<void> _init() async {
    await Future.delayed(const Duration(milliseconds: 300));
    await getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint("Location service is OFF");
        return;
      }

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        debugPrint("Location permission denied");
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final latLng = LatLng(position.latitude, position.longitude);

      selectedLatLng = latLng;

      markers
        ..clear()
        ..add(
          Marker(
            markerId: const MarkerId("current_location"),
            position: latLng,
          ),
        );

      emit(UpdateMapState());

      /// 👇 مهم: خلي الكاميرا تتحرك بس لو map جاهز
      mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(latLng, 15),
      );
    } catch (e) {
      debugPrint("Location error: $e");
    }
  }

  void addMarker(LatLng latLng) {
    selectedLatLng = latLng;

    markers
      ..clear()
      ..add(
        Marker(
          markerId: const MarkerId("marker"),
          position: latLng,
        ),
      );

    mapController?.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );

    emit(UpdateMapState());
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;

    getCurrentLocation();
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}