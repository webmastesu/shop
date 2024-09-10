// import 'package:flutter/material.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import '../models/product.dart';
// import '../config/app_config.dart';
//
// class ProductDescriptionScreen extends StatelessWidget {
//   final Product product;
//
//   ProductDescriptionScreen({required this.product});
//
//   void _showFullImage(BuildContext context, String imageUrl) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Center(
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.black.withOpacity(0.7),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             padding: EdgeInsets.all(8),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.network(
//                 imageUrl,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(product.name),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: () => _showFullImage(context, '${AppConfig.IMAGE_BASE_URL}/${product.imageUrl}'),
//               child: Image.network(
//                 '${AppConfig.IMAGE_BASE_URL}/${product.imageUrl}',
//                 fit: BoxFit.cover,
//                 height: 200, // Adjust the height as needed
//                 width: double.infinity,
//                 frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
//                   return ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: child,
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               product.name,
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Text(
//               // 'Price: ${product.currencyCode} ${product.price}',
//               'Price: ${product.price} ${product.currencyCode}',
//               style: TextStyle(fontSize: 20, color: Colors.green),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: HtmlWidget(
//                   product.description,
//                   onTapImage: (imageMetadata) {
//                     // Extract the URL string safely from ImageMetadata
//                     final imageUrl = imageMetadata?.sources.first.url ?? '';
//                     if (imageUrl.isNotEmpty) {
//                       _showFullImage(context, imageUrl);
//                     }
//                   },
//                   customStylesBuilder: (element) {
//                     if (element.localName == 'img') {
//                       return {
//                         'border-radius': '12px', // Rounded corners for images
//                       };
//                     }
//                     return {};
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../config/app_config.dart';
// import '../models/product.dart';
//
// class ProductDescriptionScreen extends StatelessWidget {
//   final Product product;
//
//   ProductDescriptionScreen({required this.product});
//
//   void _showFullImage(BuildContext context, String imageUrl) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Center(
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.black.withOpacity(0.7),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             padding: EdgeInsets.all(8),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.network(
//                 imageUrl,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(product.name),
//         backgroundColor: Colors.pinkAccent, // App bar color
//         elevation: 0, // Remove shadow
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: () => _showFullImage(context, '${AppConfig.IMAGE_BASE_URL}/${product.imageUrl}'),
//               child: Hero(
//                 tag: product.imageUrl,
//                 child: Image.network(
//                   '${AppConfig.IMAGE_BASE_URL}/${product.imageUrl}',
//                   fit: BoxFit.cover,
//                   height: 250, // Adjust the height for a modern look
//                   width: double.infinity,
//                   frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
//                     return ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: child,
//                     );
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               product.name,
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Price: ${product.price} ${product.currencyCode}',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.green,
//               ),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: HtmlWidget(
//                   product.description,
//                   onTapImage: (imageMetadata) {
//                     final imageUrl = imageMetadata?.sources.first.url ?? '';
//                     if (imageUrl.isNotEmpty) {
//                       _showFullImage(context, imageUrl);
//                     }
//                   },
//                   customStylesBuilder: (element) {
//                     if (element.localName == 'img') {
//                       return {
//                         'border-radius': '12px',
//                       };
//                     }
//                     return {};
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             _buildBuyNowButton(context),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBuyNowButton(BuildContext context) {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: SizedBox(
//         width: double.infinity,
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.pinkAccent, // Button color
//             padding: EdgeInsets.symmetric(vertical: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             elevation: 5,
//           ),
//           onPressed: () {
//             _showPurchaseDialog(context);
//           },
//           child: Text(
//             'Buy Now',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showPurchaseDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         final _nameController = TextEditingController();
//         final _phoneController = TextEditingController();
//         String _selectedMethod = 'SMS'; // Default method
//
//         return AlertDialog(
//           title: Text('Purchase Product'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Product Name: ${product.name}'),
//               SizedBox(height: 8),
//               Text('Product Image:'),
//               Image.network('${AppConfig.IMAGE_BASE_URL}/${product.imageUrl}'),
//               SizedBox(height: 16),
//               TextField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: 'Your Name'),
//               ),
//               SizedBox(height: 8),
//               TextField(
//                 controller: _phoneController,
//                 decoration: InputDecoration(labelText: 'Phone Number'),
//                 keyboardType: TextInputType.phone,
//               ),
//               SizedBox(height: 16),
//               DropdownButton<String>(
//                 value: _selectedMethod,
//                 items: ['Messenger', 'Telegram', 'SMS'].map((String method) {
//                   return DropdownMenuItem<String>(
//                     value: method,
//                     child: Text(method),
//                   );
//                 }).toList(),
//                 onChanged: (String? newValue) {
//                   if (newValue != null) {
//                     _selectedMethod = newValue;
//                   }
//                 },
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 final name = _nameController.text;
//                 final phoneNumber = _phoneController.text;
//
//                 if (name.isNotEmpty && phoneNumber.isNotEmpty) {
//                   _sendMessage(name, phoneNumber, _selectedMethod);
//                 } else {
//                   // Handle empty fields
//                 }
//               },
//               child: Text('Send'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _sendMessage(String name, String phoneNumber, String method) async {
//     final message = 'Product ID: ${product.id}\nProduct Name: ${product.name}\nProduct Image: ${AppConfig.IMAGE_BASE_URL}/${product.imageUrl}\nCustomer Name: $name\nPhone Number: $phoneNumber';
//
//     String url;
//
//     switch (method) {
//       case 'Messenger':
//         url = 'https://api.whatsapp.com/send?phone=YOUR_PHONE_NUMBER&text=${Uri.encodeComponent(message)}';
//         break;
//       case 'Telegram':
//         url = 'https://t.me/X109110?text=${Uri.encodeComponent(message)}';
//         break;
//       case 'SMS':
//         url = 'tel:09444704424:$phoneNumber?body=${Uri.encodeComponent(message)}';
//         break;
//       default:
//         return; // No valid method selected
//     }
//
//     // Open the URL
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       // Handle URL launch error
//     }
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import '../models/product.dart';
// import '../config/app_config.dart';
//
// class ProductDescriptionScreen extends StatelessWidget {
//   final Product product;
//
//   ProductDescriptionScreen({required this.product});
//
//   void _showFullImage(BuildContext context, String imageUrl) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Center(
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.black.withOpacity(0.7),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             padding: EdgeInsets.all(8),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.network(
//                 imageUrl,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(product.name),
//         backgroundColor: Colors.pinkAccent, // App bar color
//         elevation: 0, // Remove shadow
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: () => _showFullImage(context, '${AppConfig.IMAGE_BASE_URL}/${product.imageUrl}'),
//               child: Hero(
//                 tag: product.imageUrl,
//                 child: Image.network(
//                   '${AppConfig.IMAGE_BASE_URL}/${product.imageUrl}',
//                   fit: BoxFit.cover,
//                   height: 250, // Adjust the height for a modern look
//                   width: double.infinity,
//                   frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
//                     return ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: child,
//                     );
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               product.name,
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Price: ${product.price} ${product.currencyCode}',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.green,
//               ),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: HtmlWidget(
//                   product.description,
//                   onTapImage: (imageMetadata) {
//                     final imageUrl = imageMetadata?.sources.first.url ?? '';
//                     if (imageUrl.isNotEmpty) {
//                       _showFullImage(context, imageUrl);
//                     }
//                   },
//                   customStylesBuilder: (element) {
//                     if (element.localName == 'img') {
//                       return {
//                         'border-radius': '12px',
//                       };
//                     }
//                     return {};
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             _buildBuyNowButton(context),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBuyNowButton(BuildContext context) {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: SizedBox(
//         width: double.infinity,
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.pinkAccent, // Button color
//             padding: EdgeInsets.symmetric(vertical: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             elevation: 5,
//           ),
//           onPressed: () {
//             // Handle buy now action
//             // For example: Navigate to checkout screen
//           },
//           child: Text(
//             'Buy Now',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../models/product.dart';
import '../config/app_config.dart';
import 'package:url_launcher/url_launcher.dart';

import 'order_form_screen.dart';

class ProductDescriptionScreen extends StatelessWidget {
  final Product product;

  ProductDescriptionScreen({required this.product});

  void _showFullImage(BuildContext context, String imageUrl) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  void _showOrderForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderFormScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.pinkAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () =>
                    _showFullImage(context,
                        '${AppConfig.IMAGE_BASE_URL}/${product.imageUrl}'),
                child: Hero(
                  tag: product.imageUrl,
                  child: Image.network(
                    '${AppConfig.IMAGE_BASE_URL}/${product.imageUrl}',
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                    frameBuilder: (context, child, frame,
                        wasSynchronouslyLoaded) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: child,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                product.name,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Price: ${product.price} ${product.currencyCode}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 16),
              HtmlWidget(
                product.description,
                onTapImage: (imageMetadata) {
                  final imageUrl = imageMetadata?.sources.first.url ?? '';
                  if (imageUrl.isNotEmpty) {
                    _showFullImage(context, imageUrl);
                  }
                },
                customStylesBuilder: (element) {
                  if (element.localName == 'img') {
                    return {
                      'border-radius': '12px',
                    };
                  }
                  return {};
                },
              ),
              SizedBox(height: 16),
              _buildBuyNowButton(context),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildBuyNowButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pinkAccent,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
          ),
          onPressed: () => _showOrderForm(context),
          child: Text(
            'Buy Now',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}


// class OrderForm extends StatefulWidget {
//   final Product product;
//
//   OrderForm({required this.product});
//
//   @override
//   _OrderFormState createState() => _OrderFormState();
// }
//
// class _OrderFormState extends State<OrderForm> {
//   final _formKey = GlobalKey<FormState>();
//   String? _name;
//   String? _address;
//   String? _phoneNo;
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
//                 Text('Product: ${widget.product.name}'),
//                 Text('Name: $_name'),
//                 Text('Address: $_address'),
//                 Text('Phone: $_phoneNo'),
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
//               _buildContactOption('Messenger', 'fb-messenger://'),
//               _buildContactOption('Viber', 'viber://959976416375'),
//               _buildContactOption('Telegram', 'https://t.me/X109110'),
//               _buildContactOption('SMS', 'sms:'),
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
//       onTap: () => _launchUrl(scheme),
//     );
//   }
//
//   void _launchUrl(String scheme) async {
//     final message = 'Order: ${widget.product.name}\nName: $_name\nAddress: $_address\nPhone: $_phoneNo';
//     final encodedMessage = Uri.encodeComponent(message);
//     final url = '$scheme?text=$encodedMessage';
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
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Name'),
//               validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
//               onSaved: (value) => _name = value,
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Address'),
//               validator: (value) => value!.isEmpty ? 'Please enter your address' : null,
//               onSaved: (value) => _address = value,
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Phone Number'),
//               validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
//               onSaved: (value) => _phoneNo = value,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               child: Text('Continue'),
//               onPressed: _submitForm,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//

