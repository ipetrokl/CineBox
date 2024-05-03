import 'dart:convert';
import 'dart:math';

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
          Expanded(child: _buildProductCardList()),
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
          return _buildProductCard(_cartProvider.cart.items[index], index);
        },
      ),
    );
  }

  Widget _buildProductCard(CartItem item, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: const Color.fromARGB(200, 21, 36, 118), width: 1)),
        child: ListTile(
          title: Row(
            children: [
              Text(item.count.toString(), style: const TextStyle(fontSize: 12)),
              const SizedBox(width: 20),
              SizedBox(
                width: 50,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image(
                    image: item.movie.picture != null && item.movie.picture != ""
                        ? MemoryImage(base64Decode(item.movie.picture!))
                        : const AssetImage("assets/images/empty.jpg")
                            as ImageProvider<Object>,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10), // Prilagodite razmak između slike i ostatka
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.movie.title ?? ""),
                    Text(item.movie.description.toString(),
                        style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              IconButton(
                iconSize: 20,
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _cartProvider.cart.items.removeAt(index);
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBuyButton() {
    return TextButton(
      child: Text("Buy"),
      onPressed: () async {
        List<Map> items = [];
        _cartProvider.cart.items.forEach((item) {
          items.add({
            "id": item.movie.id,
            "amount": item.count,
          });
        });
        Map booking = {
          "items": items,
        };

        await _bookingProvider.insert(booking);

        _cartProvider.cart.items.clear();
        setState(() {});
      },
    );
  }
}
