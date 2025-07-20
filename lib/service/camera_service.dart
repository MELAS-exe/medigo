// File: lib/services/prescription_api_service.dart
import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PrescriptionApiService {
  static const String baseUrl = 'http://192.168.1.12:8000/api'; // Replace with your actual IP

  static Future<PrescriptionResponse> uploadPrescription(String imagePath) async {
    try {
      print('Starting prescription upload from: $imagePath');

      // Read the file
      File imageFile = File(imagePath);

      if (!await imageFile.exists()) {
        throw Exception('Image file does not exist at path: $imagePath');
      }

      Uint8List imageBytes = await imageFile.readAsBytes();
      print('File size: ${imageBytes.length} bytes');

      // Create simple multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/ordonnances/upload/'),
      );

      // Get just the filename
      String fileName = imagePath.split('/').last;

      // Add the image file - no extra headers or content types
      var multipartFile = http.MultipartFile.fromBytes(
        'image', // Field name that Django expects
        imageBytes,
        filename: fileName,
      );

      request.files.add(multipartFile);

      print('Sending POST request to: ${request.url}');
      print('Filename: $fileName');
      print('Sending raw image file...');

      // Send request
      var streamedResponse = await request.send().timeout(
        Duration(seconds: 60),
      );

      var response = await http.Response.fromStream(streamedResponse);

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonData = json.decode(response.body);
        print('Successfully parsed JSON response');
        return PrescriptionResponse.fromJson(jsonData);
      } else {
        String errorMessage = 'Server returned status ${response.statusCode}';
        if (response.body.isNotEmpty) {
          errorMessage += ': ${response.body}';
        }
        throw Exception(errorMessage);
      }

    } on SocketException catch (e) {
      print('Socket Exception: $e');
      throw Exception('Network error: Unable to connect to server');
    } on TimeoutException catch (e) {
      print('Timeout Exception: $e');
      throw Exception('Request timeout');
    } catch (e) {
      print('Error in uploadPrescription: $e');
      rethrow;
    }
  }
}

class PrescriptionResponse {
  final int id;
  final String image;
  final String medicamentsExtraits;
  final String dateUpload;

  PrescriptionResponse({
    required this.id,
    required this.image,
    required this.medicamentsExtraits,
    required this.dateUpload,
  });

  factory PrescriptionResponse.fromJson(Map<String, dynamic> json) {
    return PrescriptionResponse(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
      medicamentsExtraits: json['medicaments_extraits'] ?? '',
      dateUpload: json['date_upload'] ?? DateTime.now().toIso8601String(),
    );
  }

  List<String> get medicamentsList {
    if (medicamentsExtraits.isEmpty) return [];

    return medicamentsExtraits
        .split('\n')
        .where((med) => med.trim().isNotEmpty)
        .map((med) => med.trim())
        .toList();
  }
}