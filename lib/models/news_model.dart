// To parse this JSON data, do
//
//     final newsRequest = newsRequestFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

NewsRequest parseData(String data) {
  NewsRequest requestModel = getRequestModelFromMap(data);
  return requestModel;
}

Future<NewsRequest> getData(String url) async {
  http.Response response = await http.Client().get(url);
  if (response.statusCode == 200) {
    return compute(parseData, response.body);
  } else {
    print("error: ${response.statusCode}");
    return null;
  }
}

NewsRequest getRequestModelFromMap(String jsonMap) {
  var map = json.decode(jsonMap);
  return NewsRequest.fromMap(map);
}

//NewsRequest newsRequestFromJson(String str) =>
//    NewsRequest.fromMap(json.decode(str));

String newsRequestToJson(NewsRequest data) => json.encode(data.toMap());

class NewsRequest {
  String status;
  int totalResults;
  List<Article> articles;

  NewsRequest({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory NewsRequest.fromMap(Map<String, dynamic> json) => new NewsRequest(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: new List<Article>.from(
            json["articles"].map((x) => Article.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "totalResults": totalResults,
        "articles": new List<dynamic>.from(articles.map((x) => x.toMap())),
      };
}

class Article {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromMap(Map<String, dynamic> json) => new Article(
        source: Source.fromMap(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"] == null
            ? 'https://s3-ca-central-1.amazonaws.com/quincy-network/wp-content/uploads/sites/14/2018/10/18210325/breaking-news.jpg'
            : json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toMap() => {
        "source": source.toMap(),
        "author": author ?? 'No author',
        "title": title ?? 'No title',
        "description": description ?? 'No prescription',
        "url": url ?? 'No url',
        "urlToImage": urlToImage ??
            'https://s3-ca-central-1.amazonaws.com/quincy-network/wp-content/uploads/sites/14/2018/10/18210325/breaking-news.jpg',
        "publishedAt": publishedAt.toIso8601String(),
        "content": content ?? 'No content',
      };
}

class Source {
  Id id;
  String name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromMap(Map<String, dynamic> json) => new Source(
        id: json["id"] == null ? null : idValues.map[json["id"]],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : idValues.reverse[id],
        "name": name ?? 'No name',
      };
}

enum Id { ARS_TECHNICA, ENGADGET, THE_NEXT_WEB }

final idValues = new EnumValues({
  "ars-technica": Id.ARS_TECHNICA,
  "engadget": Id.ENGADGET,
  "the-next-web": Id.THE_NEXT_WEB
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
