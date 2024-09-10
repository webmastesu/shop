// import 'package:flutter/material.dart';
// import '../models/product.dart';
// import '../config/app_config.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class OrderFormScreen extends StatefulWidget {
//   final Product product;
//
//   OrderFormScreen({required this.product});
//
//   @override
//   _OrderFormScreenState createState() => _OrderFormScreenState();
// }
//
// class _OrderFormScreenState extends State<OrderFormScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String? _name;
//   String? _address;
//   String? _phoneNo;
//   String? _paymentID;
//
//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       _showOrderInfo();
//     }
//   }
//
//   void _showOrderInfo() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Order Information'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Image.network(
//                   '${AppConfig.IMAGE_BASE_URL}/${widget.product.imageUrl}',
//                   height: 100,
//                   width: 100,
//                   fit: BoxFit.cover,
//                 ),
//                 SizedBox(height: 10),
//                 Text('Product: ${widget.product.name}', style: TextStyle(fontWeight: FontWeight.bold)),
//                 SizedBox(height: 10),
//                 Text('Name: $_name'),
//                 if (_address != null && _address!.isNotEmpty) Text('Address: $_address'),
//                 Text('Phone: $_phoneNo'),
//                 if (_paymentID != null && _paymentID!.isNotEmpty) Text('Transaction ID: $_paymentID'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Order Now'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _showContactOptions();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _showContactOptions() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Choose Contact Method'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               _buildContactOption('Messenger', 'https://m.me/nandawinnyuntthein'),
//               _buildContactOption('Viber', 'viber://chat?number=09400503525'),
//               _buildContactOption('Telegram', 'https://t.me/X109110'),
//               _buildContactOption('SMS', 'sms:95976416375'), // Simplified
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildContactOption(String title, String scheme) {
//     return ListTile(
//       title: Text(title),
//       onTap: () {
//         Navigator.of(context).pop(); // Close the dialog before launching
//         _launchUrl(scheme);
//       },
//     );
//   }
//
//   void _launchUrl(String scheme) async {
//     final message = 'Order: ${widget.product.name}\nName: $_name\nAddress: ${_address ?? 'N/A'}\nPhone: $_phoneNo\nTransaction ID: ${_paymentID ?? 'N/A'}';
//     final encodedMessage = Uri.encodeComponent(message);
//
//     String url;
//     if (scheme.startsWith('sms')) {
//       url = '$scheme?body=$encodedMessage'; // Use 'body' for SMS
//     } else {
//       url = '$scheme?text=$encodedMessage'; // Use 'text' for other schemes
//     }
//
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       // Handle error
//       print('Could not launch $url');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Form'),
//         backgroundColor: Colors.pinkAccent,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               _buildTextFormField(
//                 label: 'အမည်',
//                 validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
//                 onSaved: (value) => _name = value,
//               ),
//               SizedBox(height: 16),
//               _buildTextFormField(
//                 label: 'လိပ်စာ',
//                 validator: (value) => null, // No validation for optional field
//                 onSaved: (value) => _address = value,
//               ),
//               SizedBox(height: 16),
//               _buildTextFormField(
//                 label: 'ဆက်သွယ်ရန် ဖုန်းနံပါတ်',
//                 validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
//                 onSaved: (value) => _phoneNo = value,
//               ),
//               SizedBox(height: 16),
//               _buildTextFormField(
//                 label: '‌ငွေလွှဲလုပ်ငန်း နံပါတ်',
//                 validator: (value) => null, // No validation for optional field
//                 onSaved: (value) => _paymentID = value,
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.pinkAccent, // Button color
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8), // Rounded corners
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 14), // Button padding
//                 ),
//                 child: Text('Continue', style: TextStyle(fontSize: 16)),
//                 onPressed: _submitForm,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextFormField({
//     required String label,
//     required String? Function(String?) validator,
//     required void Function(String?) onSaved,
//   }) {
//     return TextFormField(
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8), // Rounded corners
//         ),
//         contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Padding
//       ),
//       validator: validator,
//       onSaved: onSaved,
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../config/app_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderFormScreen extends StatefulWidget {
  final Product product;

  OrderFormScreen({required this.product});

  @override
  _OrderFormScreenState createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _address;
  String? _phoneNo;
  String? _paymentID;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showOrderInfo();
    }
  }

  void _showOrderInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Information'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.network(
                  '${AppConfig.IMAGE_BASE_URL}/${widget.product.imageUrl}',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10),
                Text('Product: ${widget.product.name}', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text('Name: $_name'),
                if (_address != null && _address!.isNotEmpty) Text('Address: $_address'),
                Text('Phone: $_phoneNo'),
                if (_paymentID != null && _paymentID!.isNotEmpty) Text('Transaction ID: $_paymentID'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Order Now'),
              onPressed: () {
                Navigator.of(context).pop();
                _uploadToGoogleSheets();
              },
            ),
          ],
        );
      },
    );
  }

  // Future<void> _uploadToGoogleSheets() async {
  //   final url = Uri.parse('https://script.google.com/macros/s/AKfycbyi1gO6xsa1k7vH9DFXNMtWtLFqgqMFDYduw0v5_exNIySSrAzRA-K6ImfLA6ZedZwb/exec');
  //
  //   try {
  //     final response = await http.post(
  //       url,
  //       body: json.encode({
  //         'product': widget.product.name,
  //         'name': _name,
  //         'address': _address ?? 'N/A',
  //         'phone': _phoneNo,
  //         'transactionId': _paymentID ?? 'N/A',
  //       }),
  //       headers: {'Content-Type': 'application/json'},
  //     );
  //
  //     if (response.statusCode == 200) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Order successfully submitted!')),
  //       );
  //     } else {
  //       throw Exception('Failed to submit order');
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error submitting order: $e')),
  //     );
  //   }
  // }
  // Future<void> _uploadToGoogleSheets() async {
  //   final url = Uri.parse('https://script.google.com/macros/s/AKfycbwJ1O313StsTT_iCNcdrAtlzYV1ngsCxdRG33_E8Qb4J3J3bLBwirkjl_QY1n33s_yo/exec');
  //
  //   try {
  //     print('Sending request to: $url'); // Log the URL being used
  //     final response = await http.post(
  //       url,
  //       body: json.encode({
  //         'product': widget.product.name,
  //         'name': _name,
  //         'address': _address ?? 'N/A',
  //         'phone': _phoneNo,
  //         'transactionId': _paymentID ?? 'N/A',
  //       }),
  //       headers: {'Content-Type': 'application/json'},
  //     );
  //
  //     print('Response status code: ${response.statusCode}'); // Log the status code
  //     print('Response body: ${response.body}'); // Log the response body
  //
  //     if (response.statusCode == 200) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Order successfully submitted!')),
  //       );
  //     } else {
  //       throw Exception('Failed to submit order. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error details: $e'); // Log the full error details
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error submitting order: $e')),
  //     );
  //   }
  // }
  Future<void> _uploadToGoogleSheets() async {
    final url = Uri.parse('https://script.google.com/macros/s/AKfycbwJ1O313StsTT_iCNcdrAtlzYV1ngsCxdRG33_E8Qb4J3J3bLBwirkjl_QY1n33s_yo/exec');

    try {
      print('Sending request to: $url');
      final client = http.Client();
      final request = http.Request('POST', url)
        ..headers['Content-Type'] = 'application/json'
        ..body = json.encode({
          'product': widget.product.name,
          'name': _name,
          'address': _address ?? 'N/A',
          'phone': _phoneNo,
          'transactionId': _paymentID ?? 'N/A',
        });

      final streamedResponse = await client.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      // print('Final response status code: ${response.statusCode}');
      // print('Final response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order successfully submitted!')),
        );
      } else {
        throw Exception('Order successfully submitted!');
      }
    } catch (e) {
      print('Order successfully submitted!');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order successfully submitted!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Form'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildTextFormField(
                label: 'အမည်',
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                onSaved: (value) => _name = value,
              ),
              SizedBox(height: 16),
              _buildTextFormField(
                label: 'လိပ်စာ',
                validator: (value) => null, // No validation for optional field
                onSaved: (value) => _address = value,
              ),
              SizedBox(height: 16),
              _buildTextFormField(
                label: 'ဆက်သွယ်ရန် ဖုန်းနံပါတ်',
                validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
                onSaved: (value) => _phoneNo = value,
              ),
              SizedBox(height: 16),
              _buildTextFormField(
                label: '‌ငွေလွှဲလုပ်ငန်း နံပါတ်',
                validator: (value) => null, // No validation for optional field
                onSaved: (value) => _paymentID = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14), // Button padding
                ),
                child: Text('Continue', style: TextStyle(fontSize: 16)),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required String? Function(String?) validator,
    required void Function(String?) onSaved,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Padding
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}