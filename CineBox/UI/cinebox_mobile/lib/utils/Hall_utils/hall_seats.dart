import 'package:cinebox_mobile/utils/Hall_utils/seat.dart';
import 'package:cinebox_mobile/utils/Hall_utils/seat_type.dart';
import 'package:flutter/material.dart';

class SeatBuilder {
  static Widget buildSeats({required ValueChanged<int> onSeatChanged}) {
    List<Widget> rows = [];
    for (int i = 0; i < 10; i++) {
      List<Widget> seats = [];
      switch (i) {
        case 0:
          seats.addAll(_buildSeatsForRow(1, SeatType.single,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(2, SeatType.disabled,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.empty,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.disabled,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.single,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.disabled,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.single,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.disabled,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.single,
              onSeatChanged: onSeatChanged));
          break;
        case 4:
          seats.addAll(_buildSeatsForRow(3, SeatType.single,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.empty,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(2, SeatType.single,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.lovers,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(2, SeatType.single,
              onSeatChanged: onSeatChanged));
          break;
        case 5:
          seats.addAll(_buildSeatsForRow(1, SeatType.single,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.lovers,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.empty,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(4, SeatType.single,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.lovers,
              onSeatChanged: onSeatChanged));
          break;
        case 6:
          seats.addAll(_buildSeatsForRow(3, SeatType.single,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.empty,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.single,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.lovers,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(3, SeatType.single,
              onSeatChanged: onSeatChanged));
          break;
        case 7:
          seats.addAll(_buildSeatsForRow(1, SeatType.lovers,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.single,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.empty,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(2, SeatType.single,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(2, SeatType.lovers,
              onSeatChanged: onSeatChanged));
          break;
        case 8:
          seats.addAll(_buildSeatsForRow(3, SeatType.single,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.empty,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.lovers,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(2, SeatType.single,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.lovers,
              onSeatChanged: onSeatChanged));
          break;
        case 9:
          seats.addAll(_buildSeatsForRow(1, SeatType.lovers,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.single,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.empty,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(2, SeatType.single,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.lovers,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(2, SeatType.single,
              onSeatChanged: onSeatChanged));
          break;
        default:
          seats.addAll(_buildSeatsForRow(3, SeatType.single,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(1, SeatType.empty,
              onSeatChanged: onSeatChanged));
          seats.addAll(_buildSeatsForRow(6, SeatType.single,
              onSeatChanged: onSeatChanged));
          break;
      }
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: seats,
        ),
      );
      rows.add(SizedBox(
        height: 4,
      ));
    }
    return Column(
      children: rows,
    );
  }

  static List<Widget> _buildSeatsForRow(int count, SeatType type,
      {required ValueChanged<int> onSeatChanged}) {
    List<Widget> seatWidgets = [];
    for (int i = 0; i < count; i++) {
      seatWidgets.add(SizedBox(
        width: 4,
      ));
      if (type == SeatType.lovers) {
        seatWidgets.add(Expanded(
          flex: 2,
          child: Seat(
            type: type,
            onChanged: (int count) {
              onSeatChanged(count);
            },
          ),
        ));
        seatWidgets.add(SizedBox(
          width: 4,
        ));
      } else {
        seatWidgets.add(Expanded(
          child: Seat(
            type: type,
            onChanged: (int count) {
              onSeatChanged(count);
            },
          ),
        ));
      }
    }
    return seatWidgets;
  }
}
