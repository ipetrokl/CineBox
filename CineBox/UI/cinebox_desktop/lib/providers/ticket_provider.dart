import 'package:cinebox_desktop/models/Ticket/ticket.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';


class TicketProvider extends BaseProvider<Ticket> {
  TicketProvider() : super("Ticket");

  @override
  Ticket fromJson(data) {

    return Ticket.fromJson(data);
  }
}