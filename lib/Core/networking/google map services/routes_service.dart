import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wheel_n_deal/Features/user/post_order/data/models/Google%20Map%20Models/location_info/location_info.dart';
import 'package:wheel_n_deal/Features/user/post_order/data/models/Google%20Map%20Models/routes_model/routes_model.dart';
import 'package:wheel_n_deal/Features/user/post_order/data/models/Google%20Map%20Models/routes_modifier.dart';

class RoutesService {
  final String baseUrl =
      'https://routes.googleapis.com/directions/v2:computeRoutes';
  final String apiKey = 'AIzaSyBmhDvQXo3iFJt-j0v9VrgEihwFU6_Qa1E';

  Future<RoutesModel> fetchRoutes(
      {required LocationInfoModel origin,
      required LocationInfoModel destination,
      RoutesModifier? routeModifiers}) async {
    Uri url = Uri.parse(baseUrl);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': apiKey,
      'X-Goog-FieldMask':
          'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline'
    };
    Map<String, dynamic> body = {
      "origin": origin.toJson(),
      "destination": destination.toJson(),
      "travelMode": "DRIVE",
      "routingPreference": "TRAFFIC_AWARE",
      "computeAlternativeRoutes": false,
      "routeModifiers": routeModifiers != null
          ? routeModifiers.toJson()
          : RoutesModifier().toJson(),
      "languageCode": "en-US",
      "units": "IMPERIAL"
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return RoutesModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('No routes found');
    }
  }
}
