class contest {
  String? status;
  List<Result>? result;

  contest({this.status, this.result});

  contest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? id;
  String? name;
  String? type;
  String? phase;
  bool? frozen;
  int? durationSeconds;
  int? startTimeSeconds;
  int? relativeTimeSeconds;

  Result(
      {this.id,
      this.name,
      this.type,
      this.phase,
      this.frozen,
      this.durationSeconds,
      this.startTimeSeconds,
      this.relativeTimeSeconds});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    phase = json['phase'];
    frozen = json['frozen'];
    durationSeconds = json['durationSeconds'];
    startTimeSeconds = json['startTimeSeconds'];
    relativeTimeSeconds = json['relativeTimeSeconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['phase'] = this.phase;
    data['frozen'] = this.frozen;
    data['durationSeconds'] = this.durationSeconds;
    data['startTimeSeconds'] = this.startTimeSeconds;
    data['relativeTimeSeconds'] = this.relativeTimeSeconds;
    return data;
  }
}
