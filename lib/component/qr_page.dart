import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';

class MachineryQRDetailPage extends StatefulWidget {
  final Machinery machinery;

  const MachineryQRDetailPage({Key? key, required this.machinery}) : super(key: key);

  @override
  _MachineryQRDetailPageState createState() => _MachineryQRDetailPageState();
}

class Machinery {
  final String id;
  final String name;
  final String model;
  final String serialNumber;
  final DateTime purchaseDate;
  final String location;
  final String status;

  Machinery({
    required this.id,
    required this.name,
    required this.model,
    required this.serialNumber,
    required this.purchaseDate,
    required this.location,
    required this.status,
  });
}

class _MachineryQRDetailPageState extends State<MachineryQRDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Machinery QR Details: ${widget.machinery.name}'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Large QR Code
         Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Large QR Code with decorative background
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade50,
                              Colors.blue.shade100,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: QrImageView(
                          data: _generateQRData(),
                          version: QrVersions.auto,
                          size: 250.0,
                          gapless: false,
                          embeddedImage: const AssetImage('assets/logo.png'),
                          embeddedImageStyle: const QrEmbeddedImageStyle(
                            size: Size(50, 50),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

                  const SizedBox(height: 20),
                  
                  // Machinery Details
                  _buildDetailRow('Machine ID', widget.machinery.id),
                  _buildDetailRow('Name', widget.machinery.name),
                  _buildDetailRow('Model', widget.machinery.model),
                  _buildDetailRow('Serial Number', widget.machinery.serialNumber),
                  _buildDetailRow('Purchase Date', 
                    DateFormat('dd MMM yyyy').format(widget.machinery.purchaseDate)
                  ),
                  _buildDetailRow('Location', widget.machinery.location),
                  _buildDetailRow('Status', widget.machinery.status),
                  
                  const SizedBox(height: 20),
                  
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.print),
                        label: const Text('Print QR'),
                        onPressed: _printQRCode,
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.share),
                        label: const Text('Share'),
                        onPressed: _shareQRCode,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }




  Widget buildDetailRow({
  required String label, 
  required String value, 
  TextStyle? labelStyle, 
  TextStyle? valueStyle,
  EdgeInsets? padding,
  CrossAxisAlignment? crossAxisAlignment,
}) {
  return Padding(
    padding: padding ?? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: labelStyle ?? TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontSize: 16.0,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: valueStyle ?? TextStyle(
              color: Colors.black54,
              fontSize: 16.0,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

  String _generateQRData() {
    return '''
Machinery Details
-----------------
ID: ${widget.machinery.id}
Name: ${widget.machinery.name}
Model: ${widget.machinery.model}
Serial Number: ${widget.machinery.serialNumber}
Purchase Date: ${DateFormat('dd MMM yyyy').format(widget.machinery.purchaseDate)}
Location: ${widget.machinery.location}
Status: ${widget.machinery.status}
''';
  }

  void _printQRCode() {
   
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Printing QR Code...')),
    );
  }

  void _shareQRCode() {
 
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sharing QR Code...')),
    );
  }
}

// Example usage in a list or another page
class MachineryListPage extends StatelessWidget {
  final List<Machinery> machineryList = [
    Machinery(
      id: 'M001',
      name: 'CNC Milling Machine',
      model: 'XR-500',
      serialNumber: 'SN-2023-0001',
      purchaseDate: DateTime(2023, 5, 15),
      location: 'Production Hall A',
      status: 'Operational',
    ),
    // Add more machinery items
  ];

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Machinery Inventory'),
      // Optional: Add actions or leading widget if needed
    ),
    body: RefreshIndicator(
      onRefresh: _refreshMachineryList,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: machineryList.length,
        itemBuilder: (context, index) {
          final machinery = machineryList[index];
          return _buildMachineryCard(machinery, context);
        },
      ),
    ),
    // Optional: Add a floating action button to add new machinery
    floatingActionButton: FloatingActionButton(
      onPressed: _addNewMachinery,
      child: const Icon(Icons.add),
    ),
  );
}

// Extracted card widget for better readability and maintainability
Widget _buildMachineryCard(Machinery machinery, BuildContext context) {
  return Card(
    elevation: 2,
    margin: const EdgeInsets.symmetric(vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MachineryQRDetailPage(machinery: machinery),
          ),
        );
      },
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.construction,
            color: Colors.blue,
            size: 32,
          ),
        ),
        title: Text(
          machinery.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Model: ${machinery.model}',
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.qr_code,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  'Tap to view QR details',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.blue,
        ),
      ),
    ),
  );
}

// Placeholder methods for potential future implementation
Future<void> _refreshMachineryList() async {
  // Implement logic to refresh the machinery list
  // For example, fetch updated data from an API
  await Future.delayed(const Duration(seconds: 2));
  // setState() to update the list
}

void _addNewMachinery() {
  // Implement navigation to add new machinery page
  // Navigator.push(...);
}
}