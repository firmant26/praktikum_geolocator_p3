import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'catatan_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MapScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final List<CatatanModel> _savedNotes = [];
  final MapController _mapController = MapController();

  @override
  void initState() {
    loadSavedData();
    super.initState();
  }

  // LOAD DATA DARI SharedPreferences
  Future<void> loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedJson = prefs.getString("catatan_data");

    if (savedJson != null) {
      List decoded = jsonDecode(savedJson);

      setState(() {
        _savedNotes.clear();
        _savedNotes.addAll(decoded.map((e) => CatatanModel.fromJson(e)));
      });
    }
  }

  // SAVE DATA KE SharedPreferences
  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List jsonList = _savedNotes.map((e) => e.toJson()).toList();
    await prefs.setString("catatan_data", jsonEncode(jsonList));
  }

  // FUNGSI GPS
  Future<void> _findMyLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    Position position = await Geolocator.getCurrentPosition();
    _mapController.move(
      latlong.LatLng(position.latitude, position.longitude),
      15.0,
    );
  }

  // LONG PRESS → TAMBAH CATATAN + DIALOG INPUT
  void _handleLongPress(TapPosition tapPos, latlong.LatLng point) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(point.latitude, point.longitude);

    String address = placemarks.first.street ?? "Alamat tidak dikenal";

    TextEditingController noteController = TextEditingController();
    String kategoriDipilih = "Rumah";

    // Dialog Input
    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Tambah Catatan"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField(
                value: kategoriDipilih,
                items: ["Rumah", "Toko", "Kantor"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  kategoriDipilih = value!;
                },
              ),
              TextField(
                controller: noteController,
                decoration: const InputDecoration(
                  labelText: "Catatan",
                ),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );

    if (noteController.text.isEmpty) return;

    setState(() {
      _savedNotes.add(
        CatatanModel(
          position: point,
          note: noteController.text,
          address: address,
          category: kategoriDipilih,
        ),
      );
    });

    saveData();
  }

  // DELETE MARKER
  void deleteMarker(int index) {
    setState(() {
      _savedNotes.removeAt(index);
    });
    saveData();
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Geo-Catatan")),

      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: const latlong.LatLng(-6.2, 106.8),
          initialZoom: 13.0,
          onLongPress: _handleLongPress,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),

          // MARKER LAYER
          MarkerLayer(
            markers: List.generate(_savedNotes.length, (index) {
              CatatanModel item = _savedNotes[index];

              IconData icon;
              Color color;

              if (item.category == "Rumah") {
                icon = Icons.home;
                color = Colors.blue;
              } else if (item.category == "Toko") {
                icon = Icons.store;
                color = Colors.green;
              } else {
                icon = Icons.apartment;
                color = Colors.purple;
              }

              return Marker(
                point: item.position,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(item.note,
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold)),
                              Text(item.address),
                              const SizedBox(height: 20),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                  deleteMarker(index);
                                },
                                icon: const Icon(Icons.delete),
                                label: const Text("Hapus Marker"),
                                style:
                                    ElevatedButton.styleFrom(backgroundColor: Colors.red),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Icon(icon, color: color, size: 40),
                ),
              );
            }),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _findMyLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
