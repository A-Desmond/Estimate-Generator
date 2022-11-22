import 'dart:io';

import 'package:estimate/model/estimate.dart';
import 'package:estimate/constant/const.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

final pdfProvider = Provider((ref) => PdfGenerator());

class PdfGenerator {
  Future<File> generate(
      {required List<Estimate> estimateList, required int totalAmount}) async {
    final pdf = Document(author: 'Adjohu Desmond');
    final font = await PdfGoogleFonts.kanitRegular();
    pdf.addPage(MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        final tableData = estimateList.map((e) {
          return [e.itemName, e.quantity, e.price, e.totalCost];
        }).toList();
        return [
          title(),
          Table.fromTextArray(
              headers: header,
              data: tableData,
              cellAlignments: {
                0: Alignment.centerLeft,
                1: Alignment.centerRight,
                2: Alignment.centerRight,
                3: Alignment.centerRight
              },
              cellStyle: TextStyle(font: font),
              headerCellDecoration:
                  const BoxDecoration(color: PdfColors.grey300),
              headerStyle: TextStyle(
                  font: font,
                  fontWeight: FontWeight.bold,
                  fontBold: Font.timesBold()),
              oddCellStyle: TextStyle(
                font: font,
              )),
          SizedBox(height: 20),
          total(totalAmount)
        ];
      },
    ));

    return saveFile(name: 'Everlasting Electricals', pdf: pdf);
  }

  Widget title() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Everlasting Electricals',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
      Text('Contact: 0550644852',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
      Text('Visit everelectricals.com',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
      SizedBox(height: 20)
    ]);
  }

  Widget total(int total) {
    return Row(children: [
      Spacer(flex: 6),
      Text('TOTAL: GHS $total',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ]);
  }

  Future<File> saveFile({
    required String name,
    required Document pdf,
  }) async {
    final byte = await pdf.save();
    final fileDirectory = await getApplicationDocumentsDirectory();
    final file = File('${fileDirectory.path}/$name');

    await file.writeAsBytes(byte);

    return file;
  }

  Future viewPdf(File file) async {
    final filePath = file.path;

    await OpenFile.open(filePath);
  }
}
