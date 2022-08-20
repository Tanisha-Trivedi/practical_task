///TODO: Model for Converting Json to Dart
import 'dart:convert';

HomePageListResponse homePageListResponseFromJson(String str) =>
    HomePageListResponse.fromJson(json.decode(str));

String homeResponseToJson(HomePageListResponse data) => json.encode(data.toJson());

class HomePageListResponse {
  HomePageListResponse({
    required this.title,
    required this.rows,
  });

  String title;
  List<HomePageListRow> rows;

  factory HomePageListResponse.fromJson(Map<String, dynamic> json) => HomePageListResponse(
    title: json["title"],
    rows: List<HomePageListRow>.from(json["rows"].map((x) => HomePageListRow.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
  };
}

class HomePageListRow {
  HomePageListRow({
    required this.title,
    required this.description,
    this.imageHref,
  });

  String? title;
  String? description;
  String? imageHref;

  factory HomePageListRow.fromJson(Map<String, dynamic> json) => HomePageListRow(
    title: json["title"],
    description: json["description"],
    imageHref: json["imageHref"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "imageHref": imageHref,
  };
}
