import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MobileMainScreen extends StatefulWidget {
  const MobileMainScreen({Key? key}) : super(key: key);

  @override
  _MobileMainScreenState createState() => _MobileMainScreenState();
}

class _MobileMainScreenState extends State<MobileMainScreen> {
  late Future<List<dynamic>> _contestsFuture;

  @override
  void initState() {
    super.initState();
    _contestsFuture = fetchFutureContests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.amber),
            height: 200,
            width: double.infinity,
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _contestsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error fetching contests'));
                }

                final contests = snapshot.data!;

                return ListView.builder(
                  itemCount: contests.length,
                  itemBuilder: (context, index) {
                    final contest = contests[index];
                    return ListTile(
                      title: Text(contest['name']),
                      subtitle: Text(
                          'Start Time: ${DateTime.fromMillisecondsSinceEpoch(contest['startTimeSeconds'] * 1000)}'),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () => null,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<dynamic>> fetchFutureContests() async {
    final url = Uri.parse('https://codeforces.com/api/contest.list');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final contests = data['result'] as List<dynamic>;

      return contests.toList();
    } else {
      throw Exception('Failed to fetch contests');
    }
  }
}
