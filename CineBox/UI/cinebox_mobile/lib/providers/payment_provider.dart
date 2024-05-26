import 'dart:convert';

import 'package:cinebox_mobile/models/Payment/payment.dart';
import 'package:cinebox_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PaymentProvider extends BaseProvider<Payment> {
  PaymentProvider() : super("Payment");

  @override
  Payment fromJson(data) {
    return Payment.fromJson(data);
  }

  Future<String> createPaymentIntent(double amount) async {
    var url = "http://localhost:7137/Payment/create-payment-intent";
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

  Future<String> getAccessToken() async {
    final clientID =
        'AfUL3htfyisqFkbLdh3XDkGsv3vqaZri84h1DyH_iVADv_nUc5RAOZ-3Y9arQF3TXlKa7iNY91F3t2yY';
    final secret =
        'EFd73fFBj1_MQiiekdCboJjtx2tS8jsm9b9vTxNlR5ZWCS_fCsA7tXZpHGaCHaCf43Wu836587O_gI_e';

    final url = Uri.parse('https://api.paypal.com/v1/oauth2/token');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$clientID:$secret'))}',
      },
      body: {
        'grant_type': 'client_credentials',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final accessToken = responseBody['access_token'];
      return accessToken;
    } else {
      throw Exception('Failed to get access token');
    }
  }
}
