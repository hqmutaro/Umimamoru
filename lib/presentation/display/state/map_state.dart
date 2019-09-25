import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:umimamoru/application/bloc/bloc_provider.dart';
import 'package:umimamoru/application/bloc/cone_state_bloc.dart';
import 'package:umimamoru/domain/module_state.dart';
import 'package:umimamoru/domain/wave_speed.dart';
import 'package:umimamoru/presentation/ui/loader/color_loader.dart';
import 'package:umimamoru/presentation/ui/loader/color_loader3.dart';

class MapState extends StatefulWidget {

  @override
  _MapState createState() => _MapState();
}

class _MapState extends  State<MapState> {

  Completer<GoogleMapController> _controller = Completer();
  final LatLng _center = const LatLng(26.512094, 128.028253);

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  double getIconPath(double speed) {
    if (getLevel(speed) == Level.Fast) {
      return BitmapDescriptor.hueRed;
    }

    if (getLevel(speed) == Level.Ordinarily) {
      return BitmapDescriptor.hueGreen;
    }

    if (getLevel(speed) == Level.Calm) {
      return BitmapDescriptor.hueBlue;
    }
    return BitmapDescriptor.hueYellow;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ConeStateBloc>(context);
    bloc.start.add(null);

    return StreamBuilder<List<ModuleState>>(
      stream: bloc.output,
      builder: (BuildContext context, AsyncSnapshot<List<ModuleState>> snapshot) {
        if (snapshot.hasData) {
          List<Marker> allMarkers = [];
          snapshot.data.forEach((model) async {
            allMarkers.add(
                Marker(
                    markerId: MarkerId(model.module),
                    draggable: false,
                    position: LatLng(model.latitude, model.longitude),
                    infoWindow: InfoWindow(
                      title: model.module,
                      snippet: "流速: ${model.speed}m/s 発生回数: ${model.countOccur}",
                    ),
                    /*
                    icon: await BitmapDescriptor.fromAssetImage(
                        ImageConfiguration(size: Size(100, 20)),
                        getIconPath(model.speed)
                    )
                    
                     */
                    icon: BitmapDescriptor.defaultMarkerWithHue(getIconPath(model.speed))
                )
            );
          });
          return GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 17.0
              ),
              minMaxZoomPreference: MinMaxZoomPreference(16, 18),
              markers: allMarkers.toSet(),
              scrollGesturesEnabled: false,
              rotateGesturesEnabled: false,
              zoomGesturesEnabled: false,
              tiltGesturesEnabled: false
          );
        }
        return Container(
          child: Center(
            child: ColorLoader(
              colors: [Colors.blueAccent, Colors.pinkAccent],
              duration: Duration(milliseconds: 1250)
            )
          )
        );
      }
    );
  }
}