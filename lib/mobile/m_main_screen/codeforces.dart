import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String _apiUrl = 'https://codeforces.com/api';
const String _userMethod = '/user.info';
const String _contestMethod = '/contest.list';

class CodeforcesProfile {
  final String handle;
  final int? rating;
  final int? maxRating;
  final String? rank;
  final String? maxRank;
  final String titlePhoto;

  CodeforcesProfile({
    required this.handle,
    required this.rating,
    required this.maxRating,
    required this.rank,
    required this.maxRank,
    required this.titlePhoto,
  });

  factory CodeforcesProfile.fromJson(Map<String, dynamic> json) {
    final result = json['result'][0];
    return CodeforcesProfile(
      handle: result['handle'],
      rating: result['rating'],
      maxRating: result['maxRating'],
      rank: result['rank'],
      maxRank: result['maxRank'],
      titlePhoto: result['titlePhoto'],
    );
  }
}

class Contest {
  final int id;
  final String name;
  final String type;
  final DateTime startTime;

  Contest({
    required this.id,
    required this.name,
    required this.type,
    required this.startTime,
  });

  factory Contest.fromJson(Map<String, dynamic> json) {
    return Contest(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      startTime:
          DateTime.fromMillisecondsSinceEpoch(json['startTimeSeconds'] * 1000),
    );
  }
}

class CodeforcesPage extends StatefulWidget {
  @override
  _CodeforcesPageState createState() => _CodeforcesPageState();
}

class _CodeforcesPageState extends State<CodeforcesPage> {
  late Future<CodeforcesProfile> _futureProfile;
  late List<Contest> _upcomingContests = [];
  late List<Contest> _pastContests = [];

  @override
  void initState() {
    super.initState();
    _futureProfile = _fetchProfile();

    _fetchContests();
  }

  Future<CodeforcesProfile> _fetchProfile() async {
    final response = await http
        .get(Uri.parse('$_apiUrl$_userMethod?handles=ayuanchor'));
    final json = jsonDecode(response.body);
    return CodeforcesProfile.fromJson(json);
  }

  @override
  void _fetchContests() async {
    final response = await http.get(Uri.parse('$_apiUrl$_contestMethod'));
    final json = jsonDecode(response.body);
    final result = json['result'] as List<dynamic>;
    final contests =
        result.map((contestJson) => Contest.fromJson(contestJson)).toList();
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    _upcomingContests = contests
        .where((contest) =>
            contest.startTime.millisecondsSinceEpoch ~/ 1000 >= now)
        .toList();
    _pastContests = contests
        .where(
            (contest) => contest.startTime.millisecondsSinceEpoch ~/ 1000 < now)
        .toList();
    setState(() {});
  }

  bool upcoming_contest = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('Codeforces')),
      ),
      body: FutureBuilder<CodeforcesProfile>(
        future: _futureProfile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final profile = snapshot.data!;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.16,
                          // Shadow depth
                          // color: Colors.yellow,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color.fromARGB(179, 105, 167, 255),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 255, 255, 255),
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.network(profile.titlePhoto),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    " ${profile.handle}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("${profile.rank}"),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Text('Rating: ${profile.rating}'),
                                ],
                              )
                            ],
                          ))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: (() {
                        setState(() {
                          upcoming_contest = true;
                        });
                      }),
                      child: Text(
                        'Upcoming contests',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: upcoming_contest
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                    TextButton(
                      onPressed: (() {
                        setState(() {
                          upcoming_contest = false;
                          // _isLoading = false;
                        });
                      }),
                      child: Text(
                        'Past contests',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: upcoming_contest
                                ? FontWeight.normal
                                : FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: upcoming_contest
                        ? _upcomingContests.length
                        : _pastContests.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          title: upcoming_contest
                              ? Text(_upcomingContests[index].name)
                              : Text(_pastContests[index].name),
                          subtitle: upcoming_contest
                              ? Text(
                                  '${_upcomingContests[index].startTime} (${_upcomingContests[index].type})')
                              : Text(
                                  '${_pastContests[index].startTime} (${_pastContests[index].type})'));
                    },
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

// void _showContestsDialog(
//     BuildContext context, List<Contest> contests, String title) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text(title),
//         content: SizedBox(
//           width: double.maxFinite,
//           child: ListView.builder(
//             itemCount: contests.length,
//             itemBuilder: (context, index) {
//               final contest = contests[index];
//               return ListTile(
//                 title: Text(contest.name),
//                 subtitle: Text('${contest.startTime} (${contest.type})'),
//               );
//             },
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Close'),
//           ),
//         ],
//       );
//     },
//   );
// }

// class contestwidget extends StatefulWidget {
//   List<Contest> Contests;
//   contestwidget({super.key, required this.Contests});

//   @override
//   State<contestwidget> createState() => _contestwidgetState();
// }

// class _contestwidgetState extends State<contestwidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: widget.Contests.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             title: Text(widget.Contests[index].name),
//             subtitle: Text(
//                 '${widget.Contests[index].startTime} (${widget.Contests[index].type})'),
//           );
//         },
//       ),
//     );
//   }
// }

// Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Text(
//                         '${profile.handle} (${profile.rank})',
//                         style: Theme.of(context).textTheme.headline6,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         children: [
//                           Text('Current rating: ${profile.rating}'),
//                           SizedBox(width: 16),
//                           Text('Max rating: ${profile.maxRating}'),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );

// PopupMenuButton<String>(
//             itemBuilder: (context) => [
//               PopupMenuItem<String>(
//                 value: 'upcoming',
//                 child: Text('Upcoming contests'),
//               ),
//               PopupMenuItem<String>(
//                 value: 'past',
//                 child: Text('Past contests'),
//               ),
//             ],
//             onSelected: (value) {
//               if (value == 'upcoming') {
//                 _showContestsDialog(
//                     context, _upcomingContests, 'Upcoming contests');
//               } else if (value == 'past') {
//                 _showContestsDialog(context, _pastContests, 'Past contests');
//               }
//             },
//           ),
