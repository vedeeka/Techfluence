import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';

class Machinery {
  final String id;
  final String name;
  final String model;
  final String serialNumber;
  final DateTime purchaseDate;
  final double purchasePrice;
  final String manufacturer;
  final String department;
  final String maintenanceStatus;
  final String condition;

  Machinery({
    required this.id,
    required this.name,
    required this.model,
    required this.serialNumber,
    required this.purchaseDate,
    required this.purchasePrice,
    required this.manufacturer,
    required this.department,
    required this.maintenanceStatus,
    required this.condition,
  });
}

class MachineryQRReportPage extends StatefulWidget {
  const MachineryQRReportPage({Key? key}) : super(key: key);

  @override
  _MachineryQRReportPageState createState() => _MachineryQRReportPageState();
}

class _MachineryQRReportPageState extends State<MachineryQRReportPage> {
  final List<Machinery> machineryList = [
    Machinery(
      id: 'M001',
      name: 'CNC Milling Machine',
      model: 'XR-500',
      serialNumber: 'SN-2023-0001',
      purchaseDate: DateTime(2023, 5, 15),
      purchasePrice: 75000.00,
      manufacturer: 'TechCNC Industries',
      department: 'Production',
      maintenanceStatus: 'Pending Maintenance',
      condition: 'Good',
    ),
    Machinery(
      id: 'M002',
      name: 'Lathe Machine',
      model: 'TL-300',
      serialNumber: 'SN-2023-0002',
      purchaseDate: DateTime(2023, 3, 10),
      purchasePrice: 45000.00,
      manufacturer: 'Precision Turnings',
      department: 'Fabrication',
      maintenanceStatus: 'Up to Date',
      condition: 'Excellent',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Machinery Inventory Report'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: _generatePrintableReport,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: machineryList.length,
        itemBuilder: (context, index) {
          return _buildMachineryReportCard(machineryList[index]);
        },
      ),
    );
  }

  Widget _buildMachineryReportCard(Machinery machinery) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // QR Code
            QrImageView(
              data: _generateQRData(machinery),
              version: QrVersions.auto,
              size: 120.0,
            ),
            const SizedBox(width: 20),
            // Machinery Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    machinery.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildDetailRow('Model', machinery.model),
                  _buildDetailRow('Serial Number', machinery.serialNumber),
                  _buildDetailRow('Purchase Date', 
                    DateFormat('dd MMM yyyy').format(machinery.purchaseDate)
                  ),
                  _buildDetailRow('Purchase Price', 
                    '\$${machinery.purchasePrice.toStringAsFixed(2)}'
                  ),
                  _buildDetailRow('Department', machinery.department),
                  _buildDetailRow('Maintenance Status', machinery.maintenanceStatus),
                  _buildDetailRow('Condition', machinery.condition),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }

  String _generateQRData(Machinery machinery) {
    return '''
Machinery Inventory Report
------------------------
ID: ${machinery.id}
Name: ${machinery.name}
Model: ${machinery.model}
Serial Number: ${machinery.serialNumber}
Purchase Date: ${DateFormat('dd MMM yyyy').format(machinery.purchaseDate)}
Purchase Price: \$${machinery.purchasePrice.toStringAsFixed(2)}
Manufacturer: ${machinery.manufacturer}
Department: ${machinery.department}
Maintenance Status: ${machinery.maintenanceStatus}
Condition: ${machinery.condition}
''';
  }

  void _generatePrintableReport() {
    // TODO: Implement report generation logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Generating Printable Report...')),
    );
  }
}