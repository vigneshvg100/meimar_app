import 'package:dio/dio.dart';
import '../../api/api_routes.dart';

class ItineraryService {
  final Dio dioClient = Dio();

  Future<dynamic> generateItinerary(Map<String, dynamic> body) async {
    try {
      final response = await dioClient.post(
        "${ApiRoutes.ITENERARY_BASE_URL}${ApiRoutes.GENERATE_ITENERARY}",
        data: body,
      );
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
