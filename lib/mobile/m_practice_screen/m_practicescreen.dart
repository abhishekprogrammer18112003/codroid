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
  List<Color> col = [Color.fromARGB(221, 169, 255, 172), Color.fromARGB(255, 255, 218, 145),  Color.fromARGB(255, 255, 184, 184)];
  List<String> diff = ['Easy', 'Medium', 'Hard'];

  @override
  void initState() {
    super.initState();
    _fetchTopProblems();
  }

  Future<void> _fetchTopProblems() async {
    try {
      List<dynamic> problems = await _apiClient.fetchTopProblems(limit: 12);
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
                final problemTitleSlug = problem['stat']['question__title_slug'];
                final rating = problem['difficulty']['level'];
                final problemUrl = 'https://leetcode.com/problems/$problemTitleSlug/';

                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: ListTile(
                    minVerticalPadding: 2,
                    tileColor: col[rating-1],
                    splashColor: Colors.blueAccent,
                    title: Text('$problemTitle'),
                    trailing: Text(diff[rating-1]),
                    leading: Text('${index+1}.'),
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
