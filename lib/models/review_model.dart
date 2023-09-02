// ignore_for_file: public_member_api_docs, sort_constructors_first
class ReviewModel {
  final String senderName;
  final String description;
  final int rating;
  ReviewModel({
    required this.senderName,
    required this.description,
    required this.rating,
  });

  factory ReviewModel.getModelFromJson({required Map<String, dynamic> json}) {
    return ReviewModel(
      senderName: json['senderName'],
      description: json['description'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> getJson() {
    return {
      'senderName': senderName,
      'description': description,
      'rating': rating,
    };
  }
}
