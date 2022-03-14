class OrderModel {
  late String device_name;
  late String uId;
  late String number;
  late String username;
  late bool seen;
  OrderModel.createModel({required dynamic data}) {
    device_name = data['device_name'];
    uId = data['uId'];
    number = data['number'];
    username = data['username'];
    seen = data['seen'];
  }
}
