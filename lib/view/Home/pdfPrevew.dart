import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:math';

class PreviewPage extends StatelessWidget {
  String cname;
  String cadress;
  String cemail;
  String cphone;
  var image;

  PreviewPage(this.cname, this.cadress, this.cemail, this.cphone, this.image,
      {Key? key})
      : super(key: key);
  var random = Random();
  var pdf;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        pdfFileName: "${random.nextInt(100000) + 100}_skelten.pdf",
        build: (context) => makePdf(),
      ),
    );
  }

  Future<Uint8List> makePdf() async {
    pdf = pw.Document();

    pdf.addPage(pw.Page(
      margin: const pw.EdgeInsets.all(10),
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Header(text: "YOUR COMPANY DETAILS", level: 1),
              ]),
              pw.Divider(borderStyle: pw.BorderStyle.dashed),
              pw.Container(height: 50),
              pw.Image(pw.MemoryImage(image),
                  fit: pw.BoxFit.fitHeight, height: 150, width: 150),
              pw.Container(height: 100),
              pw.Container(
                width: 400,
                child: pw.Column(children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Paragraph(
                          text: "Company Name",
                        ),
                        pw.Paragraph(
                          text: cname,
                        ),
                      ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Paragraph(
                          text: "Company Address",
                        ),
                        pw.Paragraph(
                          text: cadress,
                        ),
                      ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Paragraph(
                          text: "Company Email",
                        ),
                        pw.Paragraph(
                          text: cemail,
                        )
                      ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Paragraph(
                          text: "Company Phone",
                        ),
                        pw.Paragraph(text: cphone),
                      ]),
                ]),
              ),
              pw.Container(height: 50),
              pw.Divider(borderStyle: pw.BorderStyle.dashed),
              pw.Footer(),
            ]);
      },
    ));

    return pdf.save();
  }
}
