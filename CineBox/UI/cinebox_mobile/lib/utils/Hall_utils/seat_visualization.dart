import 'package:cinebox_mobile/utils/Hall_utils/seat_type.dart';
import 'package:flutter/material.dart';

class SeatVisualization extends StatefulWidget {
  final SeatType type;
  final ValueChanged<int> onChanged;
  final bool seatStatus;
  final bool isSelected;
  final bool isBooked;

  const SeatVisualization(
      {Key? key,
      required this.type,
      required this.onChanged,
      required this.seatStatus,
      this.isSelected = false,
      required this.isBooked})
      : super(key: key);

  @override
  _SeatVisualizationState createState() => _SeatVisualizationState();
}

class _SeatVisualizationState extends State<SeatVisualization> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;
    switch (widget.type) {
      case SeatType.single:
        color = Colors.green.shade400;
        icon = Icons.event_seat;
        break;
      case SeatType.double:
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

    if (_isSelected || widget.isSelected) {
      color = const Color.fromRGBO(97, 72, 199, 1);
    }
    if (!widget.seatStatus) {
      color = Colors.grey;
    }
    if (widget.isBooked) {
      color = const Color.fromRGBO(255, 0, 0, 1);
    }

    return GestureDetector(
      onTap: (widget.seatStatus && !widget.isBooked)
          ? () {
              setState(() {
                _isSelected = !_isSelected;
                if (_isSelected) {
                  widget.onChanged(1);
                } else {
                  widget.onChanged(-1);
                }
              });
            }
          : null,
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
