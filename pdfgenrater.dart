import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myapp/pdfpreview.dart';
import 'package:pdf/widgets.dart' as pdf_doc;
import 'package:flutter/foundation.dart';

class pdfinvoice extends StatefulWidget {
  @override
  State<pdfinvoice> createState() => _pdfinvoiceState();
}

class _pdfinvoiceState extends State<pdfinvoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pdf viever")),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: FloatingActionButton(
              onPressed: () async {
                Uint8List pdf = await generatePdf();
                await Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => PdfPreviewpage(
                          pdf_doc: pdf,
                        )));
              },
              child: const Icon(Icons.picture_as_pdf),
            ),
          ),
        ],
      )),
    );
  }
}

Future<Uint8List> generatePdf() async {
  final pdf = pdf_doc.Document();

  pdf.addPage(
    pdf_doc.Page(
      build: (context) {
        return pdf_doc.Container(
            child: pdf_doc.Column(children: [
          pdf_doc.Text("Invoice",
              style: pdf_doc.TextStyle(fontWeight: pdf_doc.FontWeight.bold, fontSize: 40),
              textAlign: pdf_doc.TextAlign.center),
          pdf_doc.SizedBox(height: 10),
          pdf_doc.Row(mainAxisAlignment: pdf_doc.MainAxisAlignment.spaceBetween, children: [
            pdf_doc.Column(crossAxisAlignment: pdf_doc.CrossAxisAlignment.start, children: [
              pdf_doc.Text("Pavan bhimrao mane", textAlign: pdf_doc.TextAlign.left),
              pdf_doc.Text("pavanmane4961@gmaoil.com", textAlign: pdf_doc.TextAlign.left),
              pdf_doc.Text("+91 9146255857", textAlign: pdf_doc.TextAlign.left),
              pdf_doc.Text("a/p sangavade tal- karvir", textAlign: pdf_doc.TextAlign.left),
            ]),
            pdf_doc.Column(
              children: <pdf_doc.Widget>[
                pdf_doc.Text("Invoice Number: 123"),
                pdf_doc.Text("Date: ${DateFormat("dd-MM-yyyy").format(DateTime.now())}"),
              ],
            ),
          ]),
          pdf_doc.SizedBox(height: 40),
          pdf_doc.Divider(),
          pdf_doc.SizedBox(height: 20),
          pdf_doc.Table(children: [
            pdf_doc.TableRow(children: [
              pdf_doc.Text("Item"),
              pdf_doc.Text("Quantity"),
              pdf_doc.Text("Price"),
              pdf_doc.Text("PartNo"),
              pdf_doc.Text("HSN"),
              pdf_doc.Text("row"),
            ]),
            pdf_doc.TableRow(children: [
              pdf_doc.Text("shoes"),
              pdf_doc.Text("100"),
              pdf_doc.Text("500"),
              pdf_doc.Text("21545"),
              pdf_doc.Text("84545"),
              pdf_doc.Text("5451"),
            ]),
            pdf_doc.TableRow(children: [
              pdf_doc.Text("glubs"),
              pdf_doc.Text("21214"),
              pdf_doc.Text("4547"),
              pdf_doc.Text("151"),
              pdf_doc.Text("8484"),
              pdf_doc.Text("1454"),
            ]),
            pdf_doc.TableRow(children: [
              pdf_doc.Text("socks"),
              pdf_doc.Text("21214"),
              pdf_doc.Text("4547"),
              pdf_doc.Text("151"),
              pdf_doc.Text("8484"),
              pdf_doc.Text("1454"),
            ]),
            pdf_doc.TableRow(children: [
              pdf_doc.Text("shirt"),
              pdf_doc.Text("21214"),
              pdf_doc.Text("4547"),
              pdf_doc.Text("151"),
              pdf_doc.Text("8484"),
              pdf_doc.Text("1454"),
            ]),
            pdf_doc.TableRow(children: [
              pdf_doc.Text("pant"),
              pdf_doc.Text("21214"),
              pdf_doc.Text("4547"),
              pdf_doc.Text("151"),
              pdf_doc.Text("8484"),
              pdf_doc.Text("1454"),
            ]),
            pdf_doc.TableRow(children: [
              pdf_doc.Text("bags"),
              pdf_doc.Text("21214"),
              pdf_doc.Text("4547"),
              pdf_doc.Text("151"),
              pdf_doc.Text("8484"),
              pdf_doc.Text("1454"),
            ]),
          ]),
          pdf_doc.Divider(),
          pdf_doc.SizedBox(height: 60),
          pdf_doc.Row(
            mainAxisAlignment: pdf_doc.MainAxisAlignment.end,
            children: <pdf_doc.Widget>[
              pdf_doc.Text("total"),
              pdf_doc.Text(""),
            ],
          ),
        ]));
      },
    ),
  );
  return pdf.save();
}
