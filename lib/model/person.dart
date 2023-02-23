class PersonModel {
  String? message;
  List<People>? people;
  int? number;

  PersonModel({
    this.message,
    this.people,
    this.number,
  });

  PersonModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['people'] != null) {
      people = <People>[];
      json['people'].forEach((v) {
        people!.add(People.fromJson(v));
      });
    }
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (people != null) {
      data['people'] = people!.map((v) => v.toJson()).toList();
    }
    data['number'] = number;
    return data;
  }
}

class People {
  String? name;
  String? craft;

  People({
    this.name,
    this.craft,
  });

  People.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    craft = json['craft'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['craft'] = craft;
    return data;
  }
}
