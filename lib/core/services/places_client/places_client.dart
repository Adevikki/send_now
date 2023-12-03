import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:retrofit/retrofit.dart';

import '../../config/dio_utils/header_interceptors.dart';
import '../../domain/model/get_place_details.dart';
import '../../domain/model/places_response.dart';
part 'places_client.g.dart';

@RestApi()
abstract class PlacesClient {
  factory PlacesClient(Dio dio, {String baseUrl}) = _PlacesClient;

  @GET("/maps/api/place/autocomplete/json")
  Future<PlacesResponse> getPlace(@Queries() Map<String, dynamic> queries);
  @GET("/maps/api/place/details/json")
  Future<GetPlaceDetails> getPlaceDetails(
    @Queries() Map<String, dynamic> queries,
  );
  @GET("/maps/api/directions/json")
  Future<dynamic> getDrivingDistance(
    @Queries() Map<String, dynamic> queries,
  );
}

////////////////////////////////////////////////////////////////

final dio = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.baseUrl = "https://maps.googleapis.com";
  dio.options.headers = {
    'Content-Type': 'application/json',
    "accept": 'application/json'
  };
  dio.options.queryParameters.addAll({
    "key": "*************", //REPLACE AND TEST WITH YOUR GOOGLE API_KEY
  });
  dio.interceptors.add(PlacesInterceptor(dio: dio));

  return dio;
});

final placesClient =
    Provider<PlacesClient>((ref) => PlacesClient(ref.read(dio)));
