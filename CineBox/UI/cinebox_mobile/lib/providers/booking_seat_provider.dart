import 'package:cinebox_mobile/models/BookingSeat/bookingSeat.dart';
import 'package:cinebox_mobile/providers/base_provider.dart';

class BookingSeatProvider extends BaseProvider<BookingSeat> {
  BookingSeatProvider() : super("BookingSeat");

 @override
  BookingSeat fromJson(data) {
    return BookingSeat.fromJson(data);
  }
}