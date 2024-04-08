import 'dart:io';
import 'dart:typed_data';

import 'package:carry_cart_app/mobile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class CustomerBoard extends StatefulWidget {
  CustomerBoard({Key? key}) : super(key: key);

  @override
  _CustomerBoardState createState() => _CustomerBoardState();
}

class _CustomerBoardState extends State<CustomerBoard> {
  late DatabaseReference _databaseReference;
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    _databaseReference =
        FirebaseDatabase.instance.reference().child('products');
    _loadData();
  }

  void _loadData() {
    _databaseReference.once().then((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        setState(() {
          data = [];
          var values = event.snapshot.value as Map<dynamic, dynamic>;
          int count = 0; // Variable to keep track of the number of items added
          values.forEach((key, value) {
            if (count < 10) {
              // Add item only if count is less than 10
              data.add({
                'Sr': (data.length + 1).toString(), // Generate Sr automatically
                'Product': value['Product'],
                'Qty': value['Qty'],
                'Price': value['Price'],
              });
              count++; // Increment count after adding an item
            }
          });
        });
      }
    });
  }

  num getTotalQuantity() {
    return data.isNotEmpty
        ? data.fold(0, (previous, current) => previous + (current['Qty'] ?? 0))
        : 0;
  }

  double getTotalAmount() {
    return data.isNotEmpty
        ? data.fold(
            0,
            (previous, current) =>
                previous + (current['Qty'] ?? 0) * (current['Price'] ?? 0),
          )
        : 0;
  }

  String getBillId() {
    // Generate bill ID based on some logic
    return 'BILL-${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<String?> saveFileToGallery(String filePath) async {
    try {
      final File file = File(filePath);
      final Directory? downloadsDirectory = await getDownloadsDirectory();
      if (downloadsDirectory != null && await downloadsDirectory.exists()) {
        final savedFile =
            await file.copy('${downloadsDirectory.path}/bill.pdf');
        return savedFile.path;
      } else {
        print('Downloads directory does not exist');
        return null;
      }
    } catch (e) {
      print('Error saving file to gallery: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount = data.isNotEmpty
        ? data.fold(
            0,
            (previous, current) =>
                previous + (current['Qty'] ?? 0) * (current['Price'] ?? 0),
          )
        : 0;

    List<DataRow> rows = List<DataRow>.generate(
      data.length,
      (index) => DataRow(
        cells: [
          DataCell(
            Text(
              data[index]['Sr'] ?? '',
              style: TextStyle(color: Colors.white),
            ),
          ),
          DataCell(
            Text(
              data[index]['Product'] ?? '',
              style: TextStyle(color: Colors.white),
            ),
          ),
          DataCell(
            Text(
              data[index]['Qty']?.toString() ?? '',
              style: TextStyle(color: Colors.white),
            ),
          ),
          DataCell(
            Text(
              data[index]['Price']?.toString() ?? '',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    // Add the total amount as the last row in the table
    rows.add(
      DataRow(
        cells: [
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text(
            'Total Bill:',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          )),
          DataCell(Text(
            '\$${totalAmount.toStringAsFixed(2)}',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          )),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "CUSTOMER DASHBOARD",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.orange,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                  ),
                  child: Center(
                    child: DataTable(
                      border: TableBorder.all(color: Colors.white),
                      headingTextStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      columns: [
                        DataColumn(label: Text('Sr')),
                        DataColumn(label: Text('Product')),
                        DataColumn(label: Text('Qty')),
                        DataColumn(label: Text('Price')),
                      ],
                      rows: rows,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            //PrintBillButton(),
            ElevatedButton(
              onPressed: _createPDF,
              child: Text('PRINT BILL'),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _createPDF() async {
  //   final PdfDocument document = PdfDocument();
  //   document.pages.add();
  //   List<int> bytes = await document.save();
  //   document.dispose();
  //   saveAndLaunchFile(bytes, 'Output.pdf');
  //   await _databaseReference.remove();
  //   await FirebaseFirestore.instance.collection('bills').add({
  //     'total_quantity': getTotalQuantity(),
  //     'total_amount': getTotalAmount(),
  //     'bill_id': getBillId(),
  //     // 'pdf_url':
  //     // galleryPath, // Store the URL of the generated PDF in the gallery
  //   });
  // }
  Future<void> _createPDF() async {
    // Create a new PDF document
    final PdfDocument document = PdfDocument();

    // Add a page to the document
    final PdfPage page = document.pages.add();

    // Define text styles for table headers and content
    final PdfStandardFont headerFont =
        PdfStandardFont(PdfFontFamily.helvetica, 12, style: PdfFontStyle.bold);
    final PdfStandardFont contentFont =
        PdfStandardFont(PdfFontFamily.helvetica, 10);

    // Define the table headers
    final PdfGrid grid = PdfGrid();
    grid.columns.add(count: 4);
    grid.headers.add(1);
    final PdfGridRow headerRow = grid.headers[0];
    headerRow.cells[0].value = 'Sr';
    headerRow.cells[1].value = 'Product';
    headerRow.cells[2].value = 'Qty';
    headerRow.cells[3].value = 'Price';
    headerRow.style.font = headerFont;

    // Define table rows with data from Firebase
    for (int i = 0; i < data.length; i++) {
      final PdfGridRow row = grid.rows.add();
      row.cells[0].value = data[i]['Sr'] ?? '';
      row.cells[1].value = data[i]['Product'] ?? '';
      row.cells[2].value = data[i]['Qty']?.toString() ?? '';
      row.cells[3].value = data[i]['Price']?.toString() ?? '';
      row.style.font = contentFont;
    }

    // Calculate and add the total bill row
    final PdfGridRow totalRow = grid.rows.add();
    totalRow.cells[2].value = 'Total Bill:';
    totalRow.cells[3].value = '\$${getTotalAmount().toStringAsFixed(2)}';
    totalRow.cells[3].style.font = headerFont;

    // Draw the table on the PDF page
    grid.draw(
      page: page,
      bounds: Rect.fromLTWH(
          0, 0, page.getClientSize().width, page.getClientSize().height),
    );

    // Save the document as bytes
    final List<int> bytes = await document.save();

    // Dispose the document
    document.dispose();

    // Save and launch the PDF file
    await saveAndLaunchFile(Uint8List.fromList(bytes), 'Output.pdf');

    // Remove data from the real-time database
    await _databaseReference.remove();

    // Store bill information in Firestore
    await FirebaseFirestore.instance.collection('bills').add({
      'total_quantity': getTotalQuantity(),
      'total_amount': getTotalAmount(),
      'bill_id': getBillId(),
    });
  }
}
