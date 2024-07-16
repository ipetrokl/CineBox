import 'package:cinebox_mobile/models/Ticket/ticket.dart';
import 'package:cinebox_mobile/providers/base_provider.dart';

class TicketProvider extends BaseProvider<Ticket> {
  TicketProvider() : super("Ticket");

  @override
  Ticket fromJson(data) {
    return Ticket.fromJson(data);
  }
}