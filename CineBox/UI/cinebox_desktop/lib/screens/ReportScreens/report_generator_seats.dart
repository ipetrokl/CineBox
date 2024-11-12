import 'dart:async';
import 'package:cinebox_desktop/models/Reports/hallOccupancyReport.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> generateSeatsReportPDF(List<HallOccupancyReport> _seatsData,
    DateTime selectedDate, String cinemaName) async {
  final pdf = pw.Document();
  final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

  final maxTotalSeats =
      _seatsData.map((e) => e.totalSeats).reduce((a, b) => a > b ? a : b);

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Text(
              'Number of Occupied Seats per Hall',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'Date of request: ',
                  style: pw.TextStyle(
                      fontSize: 12, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(formattedDate, style: pw.TextStyle(fontSize: 12)),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'Cinema: ',
                  style: pw.TextStyle(
                      fontSize: 12, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(cinemaName, style: pw.TextStyle(fontSize: 12)),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Hall Occupancy Data',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 10),
            pw.TableHelper.fromTextArray(
              headers: ['Hall', 'Occupied Seats', 'Total Seats'],
              data: _seatsData.map((report) {
                return [
                  report.hallName,
                  '${report.occupiedSeats}',
                  '${report.totalSeats}'
                ];
              }).toList(),
            ),
            pw.SizedBox(height: 20),
            pw.Container(
              height: 250,
              padding: const pw.EdgeInsets.only(bottom: 10),
              child: pw.Stack(
                alignment: pw.Alignment.bottomLeft,
                children: [
                  pw.Positioned.fill(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                      children: List.generate(9, (index) {
                        final value = (maxTotalSeats / 8) * (8 - index);
                        return pw.Expanded(
                          child: pw.Row(
                            children: [
                              pw.Text(
                                (value.round() ~/ 10 * 10).toString(),
                                style: pw.TextStyle(
                                    fontSize: 10, color: PdfColors.grey700),
                              ),
                              pw.Expanded(
                                child: pw.Divider(
                                  color: PdfColors.grey400,
                                  thickness: 0.5,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: _seatsData.map((report) {
                      final occupiedHeight =
                          (report.occupiedSeats / maxTotalSeats) * 213;
                      final totalHeight =
                          (report.totalSeats / maxTotalSeats) * 213;

                      return pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [
                          pw.Container(
                            width: 20,
                            height: totalHeight,
                            decoration: const pw.BoxDecoration(
                              color: PdfColors.blue200,
                            ),
                            child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.end,
                              children: [
                                pw.Container(
                                  width: 20,
                                  height: occupiedHeight,
                                  color: PdfColors.blue,
                                ),
                              ],
                            ),
                          ),
                          pw.SizedBox(height: 2),
                          pw.Text(
                            report.hallName,
                            style: pw.TextStyle(fontSize: 10),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}
