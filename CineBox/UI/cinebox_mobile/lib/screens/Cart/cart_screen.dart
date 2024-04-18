import 'package:cinebox_mobile/models/Cart/cart.dart';
import 'package:cinebox_mobile/providers/booking_provider.dart';
import 'package:cinebox_mobile/providers/cart_provider.dart';
import 'package:cinebox_mobile/screens/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../utils/util.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = "/cart";

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  late CartProvider _cartProvider;
  late BookingProvider _bookingProvider;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _cartProvider = context.watch<CartProvider>();
    _bookingProvider = context.read<BookingProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        child: Column(
          children: [
            Expanded(child:_buildProductCardList()),
            _buildBuyButton(),
          ],
        ),
      );
  }

  Widget _buildProductCardList() {
    return Container(
      child: ListView.builder(
        itemCount: _cartProvider.cart.items.length,
        itemBuilder: (context, index) {
          return _buildProductCard(_cartProvider.cart.items[index]);
        },
      ),
    );
  }

  Widget _buildProductCard(CartItem item) {
    return ListTile(
      leading: imageFromBase64String(item.movie.picture!),
      title: Text(item.movie.title ?? ""),
      subtitle: Text(item.movie.description.toString()),
      trailing: Text(item.count.toString()),
    );
  }

  Widget _buildBuyButton() {
    return TextButton(
      child: Text("Buy"),
      onPressed: () async {
        List<Map> items = [];
        _cartProvider.cart.items.forEach((item) {
          items.add({
            "proizvodId": item.movie.id,
            "kolicina": item.count,
          });
        });
        Map booking = {
          "items": items,
        };

        await _bookingProvider.insert(booking);

        _cartProvider.cart.items.clear();
        setState(() {
        });
      },
    );
  }
}