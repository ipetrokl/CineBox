import 'package:cinebox_desktop/models/Payment/payment.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';


class PaymentProvider extends BaseProvider<Payment> {
  PaymentProvider() : super("Payment");

  @override
  Payment fromJson(data) {

    return Payment.fromJson(data);
  }
}