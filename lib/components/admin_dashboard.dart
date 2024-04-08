import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDashBoard extends StatefulWidget {
  AdminDashBoard({Key? key}) : super(key: key);

  @override
  _AdminDashBoardState createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  List<Map<String, dynamic>> data = []; // Initialize with an empty list
  double totalSale = 0;

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  void fetchDataFromFirestore() async {
    // Assuming 'bills' is the collection in Firestore
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('bills').get();

    // Initialize data list and totalSale
    data = [];
    totalSale = 0;

    snapshot.docs.forEach((doc) {
      // Assuming your document fields are 'bill_id', 'quantity', 'bill'
      Map<String, dynamic> item = {
        'Bill ID': doc['bill_id'] ?? '',
        'Quantity': doc['total_quantity'] ?? 0,
        'Bill': doc['total_amount'] ?? 0,
      };

      data.add(item);

      // Calculate total sale
      totalSale += item['Bill'];
    });

    // Update the state to reflect changes
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<DataRow> rows = data.asMap().entries.map((entry) {
      int index = entry.key;
      Map<String, dynamic> item = entry.value;
      return DataRow(
        cells: [
          DataCell(Text((index + 1).toString(), style: TextStyle(color: Colors.white),)), // Serial number starts from 1
          DataCell(Text(item['Bill ID'].toString(), style: TextStyle(color: Colors.white),)),
          DataCell(Text(item['Quantity'].toString(), style: TextStyle(color: Colors.white),)),
          DataCell(Text(item['Bill'].toString(), style: TextStyle(color: Colors.white),)),
        ],
      );
    }).toList();

    // Add the total sale as the last row in the table
    rows.add(
      DataRow(
        cells: [
          DataCell(Text('')), // Empty cell for serial number
          DataCell(Text('')), // Empty cell for Bill ID
          DataCell(
            Text(
              'Total Sale',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          DataCell(
            Text(
              totalSale.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          "ADMIN DASHBOARD",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.orange,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Center(
                  child: DataTable(
                    columnSpacing: 20, // Adjust column spacing
                    horizontalMargin: 20, // Adjust horizontal margin
                    dataRowHeight: 60, // Adjust the height of data rows
                    border: TableBorder.all(color: Colors.white),
                    headingTextStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    columns: [
                      DataColumn(label: Text('Sr')),
                      DataColumn(label: Text('Bill ID')),
                      DataColumn(label: Text('Quantity')),
                      DataColumn(label: Text('Bill')),
                    ],
                    rows: rows,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/carrycart logo.png',
                  width: 150,
                  height: 100,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, right: 10),
                  child: Text(
                    "CarryCart.shop",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class AdminDashBoard extends StatefulWidget {
//   AdminDashBoard({Key? key}) : super(key: key);
//
//   @override
//   _AdminDashBoardState createState() => _AdminDashBoardState();
// }
//
// class _AdminDashBoardState extends State<AdminDashBoard> {
//   List<Map<String, dynamic>> data = []; // Initialize with an empty list
//   double totalSale = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchDataFromFirestore();
//   }
//
//   void fetchDataFromFirestore() async {
//     // Assuming 'bills' is the collection in Firestore
//     QuerySnapshot<Map<String, dynamic>> snapshot =
//     await FirebaseFirestore.instance.collection('bills').get();
//
//     // Initialize data list and totalSale
//     data = [];
//     totalSale = 0;
//
//     snapshot.docs.forEach((doc) {
//       // Assuming your document fields are 'bill_id', 'quantity', 'bill'
//       Map<String, dynamic> item = {
//         'Bill ID': doc['bill_id'] ?? '',
//         'Quantity': doc['total_quantity'] ?? 0,
//         'Bill': doc['total_amount'] ?? 0,
//       };
//
//       data.add(item);
//
//       // Calculate total sale
//       totalSale += item['Bill'];
//     });
//
//     // Update the state to reflect changes
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<DataRow> rows = data.asMap().entries.map((entry) {
//       int index = entry.key;
//       Map<String, dynamic> item = entry.value;
//       return DataRow(
//         cells: [
//           DataCell(Text((index + 1).toString())), // Serial number starts from 1
//           DataCell(Text(item['Bill ID'].toString())),
//           DataCell(Text(item['Quantity'].toString())),
//           DataCell(Text(item['Bill'].toString())),
//         ],
//       );
//     }).toList();
//
//     // Add the total sale as the last row in the table
//     rows.add(
//       DataRow(
//         cells: [
//           DataCell(Text('')), // Empty cell for serial number
//           DataCell(Text('')), // Empty cell for Bill ID
//           DataCell(
//             Text(
//               'Total Sale',
//               style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//             ),
//           ),
//           DataCell(
//             Text(
//               totalSale.toString(),
//               style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         title: Text(
//           "ADMIN DASHBOARD",
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//       ),
//       backgroundColor: Colors.orange,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Padding(
//                 padding: EdgeInsets.only(top: 15),
//                 child: Center(
//                   child: DataTable(
//                     border: TableBorder.all(color: Colors.white),
//                     headingTextStyle:
//                     TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//                     columns: [
//                       DataColumn(label: Text('Sr')),
//                       DataColumn(label: Text('Bill ID')),
//                       DataColumn(label: Text('Quantity')),
//                       DataColumn(label: Text('Bill')),
//                     ],
//                     rows: rows,
//                   ),
//                 ),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/images/carrycart logo.png',
//                   width: 150,
//                   height: 100,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 10, right: 10),
//                   child: Text(
//                     "CarryCart.shop",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                         color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AdminDashBoard extends StatefulWidget {
//   AdminDashBoard({Key? key}) : super(key: key);
//
//   @override
//   _AdminDashBoardState createState() => _AdminDashBoardState();
// }
//
// class _AdminDashBoardState extends State<AdminDashBoard> {
//   List<Map<String, dynamic>> data = []; // Initialize with an empty list
//   double totalSale = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchDataFromFirestore();
//   }
//
//   void fetchDataFromFirestore() async {
//     // Assuming 'bills' is the collection in Firestore
//     QuerySnapshot<Map<String, dynamic>> snapshot =
//     await FirebaseFirestore.instance.collection('bills').get();
//
//     // Initialize data list and totalSale
//     data = [];
//     totalSale = 0;
//
//     snapshot.docs.forEach((doc) {
//       // Assuming your document fields are 'bill_id', 'quantity', 'bill'
//       Map<String, dynamic> item = {
//         'Bill ID': doc['bill_id'] ?? '',
//         'Quantity': doc['quantity'] ?? 0,
//         'Bill': doc['bill'] ?? 0,
//       };
//
//       data.add(item);
//
//       // Calculate total sale
//       totalSale += item['Bill'];
//     });
//
//     // Update the state to reflect changes
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<DataRow> rows = data.asMap().entries.map((entry) {
//       int index = entry.key;
//       Map<String, dynamic> item = entry.value;
//       return DataRow(
//         cells: [
//           DataCell(Text((index + 1).toString())), // Serial number starts from 1
//           DataCell(Text(item['Bill ID'].toString())),
//           DataCell(Text(item['Quantity'].toString())),
//           DataCell(Text(item['Bill'].toString())),
//         ],
//       );
//     }).toList();
//
//     // Add the total sale as the last row in the table
//     rows.add(
//       DataRow(
//         cells: [
//           DataCell(Text('')),
//           DataCell(
//             Text(
//               'Total Sale',
//               style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//             ),
//           ),
//           DataCell(
//             Text(
//               totalSale.toString(),
//               style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         title: Text(
//           "ADMIN DASHBOARD",
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//       ),
//       backgroundColor: Colors.orange,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Padding(
//                 padding: EdgeInsets.only(top: 15),
//                 child: Center(
//                   child: DataTable(
//                     border: TableBorder.all(color: Colors.white),
//                     headingTextStyle:
//                     TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//                     columns: [
//                       DataColumn(label: Text('Sr')),
//                       DataColumn(label: Text('Bill ID')),
//                       DataColumn(label: Text('Quantity')),
//                       DataColumn(label: Text('Bill')),
//                     ],
//                     rows: rows,
//                   ),
//                 ),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/images/carrycart logo.png',
//                   width: 150,
//                   height: 100,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 10, right: 10),
//                   child: Text(
//                     "CarryCart.shop",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                         color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AdminDashBoard extends StatefulWidget {
//   AdminDashBoard({Key? key}) : super(key: key);
//
//   @override
//   _AdminDashBoardState createState() => _AdminDashBoardState();
// }
//
// class _AdminDashBoardState extends State<AdminDashBoard> {
//   late List<Map<String, dynamic>> data;
//   double totalSale = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchDataFromFirestore();
//   }
//
//   void fetchDataFromFirestore() async {
//     // Assuming 'bills' is the collection in Firestore
//     QuerySnapshot<Map<String, dynamic>> snapshot =
//     await FirebaseFirestore.instance.collection('bills').get();
//
//     // Initialize data list and totalSale
//     data = [];
//     totalSale = 0;
//
//     snapshot.docs.forEach((doc) {
//       // Assuming your document fields are 'bill_id', 'quantity', 'bill'
//       Map<String, dynamic> item = {
//         'Bill ID': doc['bill_id'] ?? '',
//         'Quantity': doc['total_quantity'] ?? 0,
//         'Bill': doc['total_amount'] ?? 0,
//       };
//
//       data.add(item);
//
//       // Calculate total sale
//       totalSale += item['Bill'];
//     });
//
//     // Update the state to reflect changes
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<DataRow> rows = data.map((item) {
//       return DataRow(
//         cells: [
//           DataCell(Text(item['Bill ID'].toString())),
//           DataCell(Text(item['Quantity'].toString())),
//           DataCell(Text(item['Bill'].toString())),
//         ],
//       );
//     }).toList();
//
//     // Add the total sale as the last row in the table
//     rows.add(
//       DataRow(
//         cells: [
//           DataCell(Text('')),
//           DataCell(
//             Text(
//               'Total Sale',
//               style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//             ),
//           ),
//           DataCell(
//             Text(
//               totalSale.toString(),
//               style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         title: Text(
//           "ADMIN DASHBOARD",
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//       ),
//       backgroundColor: Colors.orange,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Padding(
//                 padding: EdgeInsets.only(top: 15),
//                 child: Center(
//                   child: DataTable(
//                     border: TableBorder.all(color: Colors.white),
//                     headingTextStyle:
//                     TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//                     columns: [
//                       DataColumn(label: Text('Bill ID')),
//                       DataColumn(label: Text('Quantity')),
//                       DataColumn(label: Text('Bill')),
//                     ],
//                     rows: rows,
//                   ),
//                 ),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/images/carrycart logo.png',
//                   width: 150,
//                   height: 100,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 10, right: 10),
//                   child: Text(
//                     "CarryCart.shop",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                         color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class AdminDashBoard extends StatelessWidget {
//   AdminDashBoard({Key? key}) : super(key: key);
//
//   final List<Map<String, dynamic>> data = List.generate(
//     10,
//     (index) => {
//       'Sr': '',
//       'Product': '',
//       'Qty': '',
//       'Price': '',
//     },
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     // double totalAmount = data.fold(
//     //     0, (previous, current) => previous + current['Qty'] * current['Price']);
//     //double totalAmount = data.fold(0, (previous, current) => previous + current['Qty'] * current['Price']);
//
//     List<DataRow> rows = List<DataRow>.generate(
//       data.length,
//       (index) => DataRow(
//         cells: [
//           DataCell(Text(data[index]['Sr'])),
//           DataCell(Text(data[index]['Product'])),
//           DataCell(Text(data[index]['Qty'].toString())),
//           DataCell(Text(data[index]['Price'].toString())),
//         ],
//       ),
//     );
//
//     // Add the total amount as the last row in the table
//     rows.add(
//       DataRow(
//         cells: [
//           DataCell(Text('')),
//           DataCell(Text('')),
//           DataCell(Text('Total Sale',
//               style:
//                   TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
//           DataCell(Text('')),
//         ],
//       ),
//     );
//
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.orange,
//           title: Text(
//             "ADMIN DASHBOARD",
//             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//           centerTitle: true,
//           automaticallyImplyLeading: false,
//         ),
//         backgroundColor: Colors.orange,
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: SingleChildScrollView(
//                     child: Padding(
//                   padding: EdgeInsets.only(
//                     top: 15,
//                   ),
//                   child: Center(
//                     child: DataTable(
//                         border: TableBorder.all(color: Colors.white),
//                         headingTextStyle: TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.white),
//                         columns: [
//                           DataColumn(label: Text('Sr')),
//                           DataColumn(label: Text('Bill No')),
//                           DataColumn(label: Text('#Items')),
//                           DataColumn(label: Text('Bill')),
//                         ],
//                         rows: rows),
//                   ),
//                 )),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/images/carrycart logo.png',
//                     width: 150,
//                     height: 100,
//                   ),
//                   Padding(
//                       padding: EdgeInsets.only(top: 10, right: 10),
//                       child: Text(
//                         "CarryCart.shop",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                             color: Colors.white),
//                       ))
//                 ],
//               )
//             ],
//           ),
//         ));
//   }
// }
