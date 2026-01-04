import 'package:dio/dio.dart';

class LocationService {
  final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> getSuggestions(String query) async {
    if (query.isEmpty) return [];

    try {
      final response = await _dio.get(
        'https://nominatim.openstreetmap.org/search',
        queryParameters: {
          'q': query,
          'format': 'jsonv2',
          'limit': 5,
          'addressdetails': 1,
          'countrycodes': 'in',
        },
        options: Options(headers: {'User-Agent': 'MeimarApp/1.0'}),
      );

      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((item) => item as Map<String, dynamic>).toList();
      }
      return [];
    } catch (e) {
      print('Location Search Error: $e');
      return [];
    }
  }
}
