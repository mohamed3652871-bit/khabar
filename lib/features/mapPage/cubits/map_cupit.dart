import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'map_state.dart';
import 'package:flutter/material.dart';

class MapCubit extends Cubit<MapState> {
  final TextEditingController searchController = TextEditingController();
  MapCubit() : super(InitMapState());
  Set<Marker> markers = {};
  LatLng initLatLng=LatLng(30.04855406300429, 31.22707262635231);
  static MapCubit get(BuildContext context) => BlocProvider.of(context);
  LatLng? selectedLatLng;

  void addMarker(LatLng latLng) {
    selectedLatLng = latLng;

    markers.add(
      Marker(
        markerId: MarkerId("marker"),
        position: latLng,
      ),
    );

    mapController?.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );

    emit(UpdateMapState());
  }
  late GoogleMapController? mapController;

}