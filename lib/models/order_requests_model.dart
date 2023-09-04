// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderRequestsModel {
  final String orderName;
  final String buyersAddress;

  OrderRequestsModel({
    required this.orderName,
    required this.buyersAddress,
  });

  Map<String, dynamic> getJson() => {
        'orderName': orderName,
        'buyersAddress': buyersAddress,
      };

  factory OrderRequestsModel.getModelFromJson(
      {required Map<String, dynamic> json}) {
    return OrderRequestsModel(
      orderName: json['orderName'],
      buyersAddress: json['buyersAddress'],
    );
  }
}
