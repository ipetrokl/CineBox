import 'dart:async';
import 'package:cinebox_desktop/models/Reports/terminOccupiedReport.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> generateTerminsReportPDF(
    List<TerminOccupiedReport> _terminData) async {
  final pdf = pw.Document();
  final createdDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Text(
              'Most occupied termins',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'Date of created: ',
                  style: pw.TextStyle(
                      fontSize: 12, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(createdDate, style: pw.TextStyle(fontSize: 12)),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.TableHelper.fromTextArray(
              headers: ['Show time', 'Movie', 'Occupied'],
              data: _terminData.map((report) {
                return [
                  '${report.screeningTime} h',
                  (report.movieTitle),
                  '${report.totalBookedSeats} times'
                ];
              }).toList(),
            ),
            pw.SizedBox(height: 20),
          ],
        );
      },
    ),
  );

  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}
