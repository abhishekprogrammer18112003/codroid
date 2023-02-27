import 'package:codroid/mobile/m_practice_screen/webviewpage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import './leetcode_api.dart';

class LeetCodeScreen extends StatefulWidget {
  @override
  _LeetCodeScreenState createState() => _LeetCodeScreenState();
}

class _LeetCodeScreenState extends State<LeetCodeScreen> {
  final LeetCodeApiClient _apiClient = LeetCodeApiClient();

  List<dynamic> _problems = [];

  @override
  void initState() {
    super.initState();
    _fetchTopProblems();
  }

  Future<void> _fetchTopProblems() async {
    try {
      List<dynamic> problems = await _apiClient.fetchTopProblems(limit: 10);
      setState(() {
        _problems = problems;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _problems.isEmpty
          ? Center(
              child: Lottie.asset("assets/lottie/loading.json",
                  height: MediaQuery.of(context).size.height * 0.25),
            )
          : ListView.builder(
              itemCount: _problems.length,
              itemBuilder: (BuildContext context, int index) {
                final problem = _problems[index];
                final problemId = problem['stat']['question_id'];
                final problemTitle = problem['stat']['question__title'];
                final problemTitleSlug =
                    problem['stat']['question__title_slug'];

                final problemUrl =
                    'https://leetcode.com/problems/$problemTitleSlug/';

                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: ListTile(
                    minVerticalPadding: 2,
                    tileColor: Colors.blue.shade100,
                    splashColor: Colors.blueAccent,
                    title: Text('${index + 1}. $problemTitle'),
                    // subtitle: Text(problemUrl),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => webViewPage(url: problemUrl),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
