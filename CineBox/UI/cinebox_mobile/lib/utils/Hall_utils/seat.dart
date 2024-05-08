import 'package:cinebox_mobile/utils/Hall_utils/seat_type.dart';
import 'package:flutter/material.dart';

class Seat extends StatefulWidget {
  final SeatType type;
  final ValueChanged<int> onChanged;

  const Seat({Key? key, required this.type, required this.onChanged})
      : super(key: key);

  @override
  _SeatState createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;
    switch (widget.type) {
      case SeatType.single:
        color = Colors.green.shade400;
        icon = Icons.event_seat;
        break;
      case SeatType.lovers:
        color = Colors.green.shade400;
        icon = Icons.favorite;
        break;
      case SeatType.disabled:
        color = Colors.green.shade400;
        icon = Icons.wheelchair_pickup;
        break;
      case SeatType.empty:
        color = Colors.transparent;
        icon = Icons.stairs;
        break;
    }

    if (_isSelected) {
      color = const Color.fromRGBO(97, 72, 199, 1);
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          if (_isSelected && widget.type == SeatType.lovers) {
            widget.onChanged(2);
          } else if (_isSelected) {
            widget.onChanged(1);
          } else if (!_isSelected && widget.type == SeatType.lovers) {
            widget.onChanged(-2);
          } else {
            widget.onChanged(-1);
          }
        });
      },
      child: Container(
        height: 40.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Center(
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
