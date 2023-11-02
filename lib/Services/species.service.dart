import 'dart:convert';
import 'package:http/http.dart' as http;

class SpeciesService {
  static const baseUrl = 'http://192.168.137.1:3000';

  Future<Map<String, dynamic>> browseSpecies(String commonName) async {
    final url = Uri.parse('$baseUrl/browse-species');

    try {
      final headers = {
        'Content-Type': 'application/json',
      };

      final Map<String, String> common_name = {
        'common_name': commonName,
      };

      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(common_name),
      );

      if (response.statusCode == 201) {
        // Successful response
        final data = json.decode(response.body);
        return {
          'success': true,
          'message': data['message'],
          'recs': data['recs'],
        };
      } else if (response.statusCode == 401) {
        // No results found
        return {
          'success': false,
          'error': 'No results found',
        };
      } else {
        // Handle other error cases
        return {
          'success': false,
          'error': 'An error occurred while querying the database',
        };
      }
    } catch (exception) {
      // Handle network errors
      return {
        'success': false,
        'error': 'Network error: $exception',
      };
    }
  }

  Future<Map<String, dynamic>> addSpecies(
    String commonName,
    String sciName,
    String consStatus,
    double latitude,
    double longitude,
    double altitude,
    String description,
  ) async {
    final url = Uri.parse('$baseUrl/add-species');

    // Create a map with the data you want to send
    final data = {
      'commonName': commonName,
      'sciName': sciName,
      'consStatus': consStatus,
      'latitude': latitude,
      'longitude': longitude,
      'altitude': altitude,
      'description': description,
    };

    try {
      final response = await http.post(
        url,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 201) {
        // Species record created successfully
        return {
          'success': true,
          'message': 'Species record creation successful',
          'data': json.decode(response.body),
        };
      } else if (response.statusCode == 401) {
        // Invalid response
        return {
          'success': false,
          'error': 'Invalid response',
        };
      } else {
        // An error occurred
        return {
          'success': false,
          'error': 'An error occurred while creating species record',
          'errorMessage': json.decode(response.body)['errorMessage'],
        };
      }
    } catch (e) {
      // Handle network or other errors here
      return {
        'success': false,
        'error': 'Network error',
        'errorMessage': e.toString(),
      };
    }
  }
}
