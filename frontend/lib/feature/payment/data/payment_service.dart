import '../../../core/network/api_client.dart';

class PaymentInitData {
  final String merchantId;
  final String orderId;
  final double amount;
  final String currency;
  final String items;
  final bool sandbox;
  final String notifyUrl;
  final String hash;

  PaymentInitData({
    required this.merchantId,
    required this.orderId,
    required this.amount,
    required this.currency,
    required this.items,
    required this.sandbox,
    required this.notifyUrl,
    required this.hash,
  });

  factory PaymentInitData.fromJson(Map<String, dynamic> json) => PaymentInitData(
        merchantId: json["merchant_id"],
        orderId: json["order_id"],
        amount: double.parse(json["amount"].toString()),
        currency: json["currency"],
        items: json["items"],
        sandbox: json["sandbox"],
        notifyUrl: json["notify_url"],
        hash: json["hash"],
      );
}

class PaymentService {
  static Future<PaymentInitData> initPayment(String bookingId) async {
    final res = await ApiClient.post("/payments/init/$bookingId");
    return PaymentInitData.fromJson(res);
  }
}
