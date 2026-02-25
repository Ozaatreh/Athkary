import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class RamadanPdfViewer extends StatelessWidget {
  final String title;
  final String localPath;

  const RamadanPdfViewer({
    super.key,
    required this.title,
    required this.localPath,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surface.withOpacity(0.94),
            ],
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: PDFView(
            filePath: localPath,
            autoSpacing: true,
            fitEachPage: true,
            pageSnap: true,
          ),
        ),
      ),
    );
  }
}
