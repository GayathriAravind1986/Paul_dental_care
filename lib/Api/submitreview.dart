import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

Future<void> submitReview({
  required String name,
  required String review,
  required int rating,
  required BuildContext context,
}) async {

  final dio = Dio();
  const String url = 'https://pauldentalcare.com/api/submit-review';

  try {
    final response = await dio.post(
      url,
      data: {
        'name': name,
        'review': review,
        'rating': rating.toString(),
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.data;
      if (responseData['success'] == true || responseData['message'] == 'Review submitted successfully') {
        Navigator.of(context).pop(); // Close dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('✅ Review submitted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Submission failed: ${responseData['message'] ?? "Unknown error"}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Failed: Server responded with ${response.statusCode}')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('❌ Error occurred: $e')),
    );
  }
}
