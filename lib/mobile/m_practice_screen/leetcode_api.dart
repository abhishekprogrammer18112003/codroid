import 'dart:convert';
import 'package:http/http.dart' as http;

class LeetCodeApiClient {
  final String _baseUrl = 'https://leetcode.com/api';

  Future<List<dynamic>> fetchTopProblems({int limit = 10}) async {
    final response = await http.get(Uri.parse('$_baseUrl/problems/all'));

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return decoded['stat_status_pairs'].sublist(0, limit);
    } else {
      throw Exception('Failed to load problems');
    }
  }

  // Future<Map<String, dynamic>> fetchSolution(int id) async {
  //   final response = await http.get(Uri.parse('$_baseUrl/submissions/detail/$id'));

  //   if (response.statusCode == 200) {
  //     final decoded = jsonDecode(response.body);
  //     return decoded['data']['submissionDetail'];
  //   } else {
  //     throw Exception('Failed to load solution');
  //   }
  // }
}
