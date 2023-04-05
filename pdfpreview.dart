import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:printing/printing.dart';

class PdfPreviewpage extends StatelessWidget {
  final Uint8List pdf_doc;
const PdfPreviewpage({required
this.pdf_doc,Key?key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Preview pdf")),body:PdfPreview(build:(context)=>pdf_doc) ,);
  }
}
