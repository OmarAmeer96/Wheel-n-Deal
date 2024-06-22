import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wheel_n_deal/Features/user/post_order/data/models/Google%20Map%20Models/place_autocomplete_model/place_autocomplete_model.dart';
import 'package:wheel_n_deal/Features/user/post_order/data/models/Google%20Map%20Models/place_details_model/place_details_model.dart';

class PlacesService {
  final String baseUrl = 'https://maps.googleapis.com/maps/api/place';
  final String apiKey = 'AIzaSyBmhDvQXo3iFJt-j0v9VrgEihwFU6_Qa1E';
  Future<List<PlaceAutocompleteModel>> getPredictions(
      {required String input, required String sessionToken}) async {
    var response = await http.get(Uri.parse(
        '$baseUrl/autocomplete/json?key=$apiKey&input=$input&sessiontoken=$sessionToken'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['predictions'];
      List<PlaceAutocompleteModel> places = [];
      for (var item in data) {
        places.add(PlaceAutocompleteModel.fromJson(item));
      }
      return places;
    } else {
      throw Exception();
    }
  }

  Future<PlaceDetailsModel> getPlaceDetails({required String placeId}) async {
    var response = await http
        .get(Uri.parse('$baseUrl/details/json?key=$apiKey&place_id=$placeId'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['result'];

      return PlaceDetailsModel.fromJson(data);
    } else {
      throw Exception();
    }
  }
}
