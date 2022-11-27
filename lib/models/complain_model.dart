import 'package:hydrogen_complian/models/user_model.dart';

class ComplainModel {
  final String summary;
  final String title;
  final int rating;
  final DateTime? createdAt;
  final int? id;
  // final UserModel userModel;

  ComplainModel(
      {this.createdAt,
      this.id,
      required this.summary,
      required this.title,
      required this.rating});

  Map<String, dynamic> toJson() {
    return {'summary': summary, 'title': title, 'rating': rating};
  }

 static ComplainModel fromJson(Map<String, dynamic> json) {
    return ComplainModel(
        summary: json['summary'],
        title: json['title'],
        rating: json['rating'],
        createdAt: DateTime.tryParse(json['created_at']),
        id: json['id']
        );
  }
}
