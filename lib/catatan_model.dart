import 'package:latlong2/latlong.dart';

class CatatanModel {
  final LatLng position;
  final String note;
  final String address;
  final String category;

  CatatanModel({
    required this.position,
    required this.note,
    required this.address,
    required this.category,
  });

  // Convert ke JSON untuk disimpan
  Map<String, dynamic> toJson() {
    return {
      "lat": position.latitude,
      "lng": position.longitude,
      "note": note,
      "address": address,
      "category": category,
    };
  }

  // Convert dari JSON ketika membaca data
  factory CatatanModel.fromJson(Map<String, dynamic> json) {
    return CatatanModel(
      position: LatLng(json["lat"], json["lng"]),
      note: json["note"],
      address: json["address"],
      category: json["category"],
    );
  }
}
