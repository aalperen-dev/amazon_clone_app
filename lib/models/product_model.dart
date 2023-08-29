// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  final String imgUrl;
  final String productName;
  final double cost;
  final int discount;
  final String uid;
  final String sellerName;
  final String sellerUid;
  final int rating;
  final int noOfRating;
  ProductModel({
    required this.imgUrl,
    required this.productName,
    required this.cost,
    required this.discount,
    required this.uid,
    required this.sellerName,
    required this.sellerUid,
    required this.rating,
    required this.noOfRating,
  });
}
