import 'dart:convert';
import 'package:cinebox_mobile/models/Payment/payment.dart';
import 'package:cinebox_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class PaymentProvider extends BaseProvider<Payment> {
  PaymentProvider() : super("Payment");

  @override
  Payment fromJson(data) {
    return Payment.fromJson(data);
  }

  Future<String> createPaymentIntent(double amount) async {
    var url = "${BaseProvider.baseUrl}Payment/create-payment-intent";
    var uri = Uri.parse(url);

    var body = jsonEncode({'amount': amount});
    var headers = createHeaders();

    var response = await http.post(uri, headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      // Zahtjev je uspješno izvršen
      var clientSecret = jsonDecode(response.body)['clientSecret'];
      return clientSecret;
    } else {
      // Status odgovora nije uspješan
      print('HTTP Error: ${response.statusCode}');
      throw Exception("Failed to create payment intent");
    }
  }

  Future<String> createPayPalPayment(double amount) async {
    var url = "${BaseProvider.baseUrl}Payment/create-paypal-payment";
    var uri = Uri.parse(url);

    var body = jsonEncode({
      'amount': amount,
    });
    var headers = createHeaders();

    var response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> paymentData = jsonDecode(response.body);
      final List<dynamic> links = paymentData['links'];

      final Map<String, dynamic>? approvalUrl = links.firstWhere(
        (link) => link['rel'] == 'approval_url',
        orElse: () => null,
      );

      if (approvalUrl != null) {
        final String checkoutUrl = approvalUrl['href'];
        return checkoutUrl;
      } else {
        throw Exception('Approval URL not found');
      }
    } else {
      throw Exception('Failed to create PayPal payment');
    }
  }
}
