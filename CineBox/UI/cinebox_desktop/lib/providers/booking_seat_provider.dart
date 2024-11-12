import 'package:cinebox_desktop/models/BookingSeat/bookingSeat.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';


class BookingSeatProvider extends BaseProvider<BookingSeat> {
  BookingSeatProvider() : super("BookingSeat");

  @override
  BookingSeat fromJson(data) {

    return BookingSeat.fromJson(data);
  }
}