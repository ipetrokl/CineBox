import 'package:cinebox_mobile/models/Promotion/promotion.dart';
import 'package:cinebox_mobile/providers/promotion_provider.dart';
import 'package:cinebox_mobile/screens/master_screen.dart';
import 'package:cinebox_mobile/utils/search_result.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PromotionScreen extends StatefulWidget {
  static const String routeName = "/promotion";
  final int cinemaId;
  final DateTime initialDate;
  final String cinemaName;

  const PromotionScreen(
      {super.key, required this.cinemaId, required this.initialDate, required this.cinemaName});

  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  late PromotionProvider _promotionProvider;
  SearchResult<Promotion>? result;

  @override
  void initState() {
    super.initState();
    _promotionProvider = context.read<PromotionProvider>();
    print("called initState");
    loadData();
  }

  Future loadData() async {
    try {
      var data = await _promotionProvider.get(filter: {'currentDate' : DateTime.now()});

      setState(() {
        result = data;
      });
    } catch (e) {
      print("Error fetching promotions: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      cinemaId: widget.cinemaId,
      initialDate: widget.initialDate,
      cinemaName: widget.cinemaName,
      child: Column(
        children: [Expanded(child: _buildPromotion())],
      ),
    );
  }

  Widget _buildPromotion() {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 1,
            image: AssetImage("assets/images/sale.jpg"),
            fit: BoxFit
                .cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: SingleChildScrollView(
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Promo codes:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  const Divider(
                      thickness: 5, color: Color.fromARGB(200, 21, 36, 118)),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 575,
                    child: GridView(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 15,
                      ),
                      scrollDirection: Axis.vertical,
                      children: _buildPromotionCardList(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPromotionCardList() {
    if (result == null || result!.result.isEmpty) {
      return [Center(child: Text('No promo codes found.'))];
    }

    return result!.result.map((promotion) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color.fromARGB(200, 21, 36, 118), width: 2),
          color: Colors.white70
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                promotion.code!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const Divider(
                  thickness: 2, color: Color.fromARGB(200, 21, 36, 118)),
              Text(
                "Discount:",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                promotion.discount!.truncate().toString() + "%",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                "Expiration date:",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                DateFormat('dd.MM.yyyy.').format(promotion.expirationDate!),
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
