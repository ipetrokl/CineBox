import 'package:cinebox_mobile/models/Seat/seat.dart';
import 'package:cinebox_mobile/utils/Hall_utils/seat_visualization.dart';
import 'package:cinebox_mobile/utils/Hall_utils/seat_type.dart';
import 'package:flutter/material.dart';

class SeatBuilder {
  static Widget buildSeats(
      {required ValueChanged<int> onSeatChanged,
      required List<Seat> seats,
      required List<Seat> selectedSeats}) {
    List<Widget> rows = [];

    // Broj redova i broj sjedala u redu
    int rowCount = 9;
    int seatsPerRow = 10;

    // Funkcija za provjeru je li sjedalo već odabrano
    bool isSeatSelected(Seat seat) {
      return selectedSeats.contains(seat);
    }

    // Funkcija za dodavanje ili uklanjanje sjedala iz liste odabranih
    void toggleSeatSelection(Seat seat) {
      if (isSeatSelected(seat)) {
        selectedSeats.remove(seat);
      } else {
        selectedSeats.add(seat);
      }
      onSeatChanged(selectedSeats.length);
    }

    // Kreiranje redova sjedala
    int seatIndex = -1;
    for (int i = 0; i < rowCount; i++) {
      List<Widget> rowChildren = [];
      int temp = seatsPerRow;
      for (int j = 0; j < temp; j++) {
        seatIndex++;
        if (seatIndex < seats.length) {
          Seat seat = seats[seatIndex];
          var selected = isSeatSelected(seat);
          Widget seatWidget;

          switch (seat.category) {
            case "solo":
              seatWidget = Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SeatVisualization(
                    type: SeatType.single,
                    onChanged: (count) {
                      toggleSeatSelection(seat);
                    },
                    seatStatus: seat.status!,
                    isSelected: selected,
                  ),
                ),
              );
              break;
            case "disabled":
              seatWidget = Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SeatVisualization(
                    type: SeatType.disabled,
                    onChanged: (count) {
                      toggleSeatSelection(seat);
                    },
                    seatStatus: seat.status!,
                    isSelected: selected,
                  ),
                ),
              );
              break;
            case "love":
              seatWidget = Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SeatVisualization(
                    type: SeatType.lovers,
                    onChanged: (count) {
                      toggleSeatSelection(seat);
                    },
                    seatStatus: seat.status!,
                    isSelected: selected,
                  ),
                ),
              );
              temp--;
              break;
            default:
              seatWidget =
                  SizedBox(); // Prazan widget ako kategorija nije definirana
          }

          rowChildren.add(seatWidget);
        }
      }

      rows.add(Row(children: rowChildren));
    }

    return Column(children: rows);
  }
}
