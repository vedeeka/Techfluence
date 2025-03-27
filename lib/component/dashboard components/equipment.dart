import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MachineryProductGridPage extends StatelessWidget {
  final List<Machinery> machineryList = [
    Machinery(
      id: 'M001',
      jobName: 'CNC Milling Machine',
      model: 'XR-500',
      serialNumber: 'SN-2023-0001',
      purchaseDate: DateTime(2023, 5, 15),
      location: 'Production Hall A',
      status: 'Operational',
      price: 45000.00,
      description: 'High-precision CNC milling machine.',
      imageUrl: 'assets/images/heroimg.png',
    ),
     Machinery(
      id: 'M001',
      jobName: 'CNC Milling Machine',
      model: 'XR-500',
      serialNumber: 'SN-2023-0001',
      purchaseDate: DateTime(2023, 5, 15),
      location: 'Production Hall A',
      status: 'Operational',
      price: 45000.00,
      description: 'High-precision CNC milling machine.',
      imageUrl: 'assets/images/heroimg.png',
    ),     Machinery(
      id: 'M001',
      jobName: 'CNC Milling Machine',
      model: 'XR-500',
      serialNumber: 'SN-2023-0001',
      purchaseDate: DateTime(2023, 5, 15),
      location: 'Production Hall A',
      status: 'Operational',
      price: 45000.00,
      description: 'High-precision CNC milling machine.',
      imageUrl: 'assets/images/heroimg.png',
    ),
    // Add other machinery items here...
  ];

  MachineryProductGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Machinery Marketplace')),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 3, crossAxisSpacing: 12, mainAxisSpacing: 3,
        ),
        itemCount: machineryList.length,
        itemBuilder: (context, index) => _buildProductCard(context, machineryList[index]),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Machinery machinery) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MachineryDetailPage(machinery: machinery)),
      ),
      child: Card(
        
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(machinery.imageUrl, height: 80, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(machinery.jobName, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(machinery.model, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  Text('\$${machinery.price.toStringAsFixed(2)}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(machinery.status).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(machinery.status, style: TextStyle(color: _getStatusColor(machinery.status), fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'operational': return Colors.green;
      case 'under maintenance': return Colors.orange;
      default: return Colors.grey;
    }
  }
}

class MachineryDetailPage extends StatelessWidget {
  final Machinery machinery;

  const MachineryDetailPage({super.key, required this.machinery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(machinery.jobName)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(machinery.imageUrl, width: double.infinity, height: 200, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(machinery.jobName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text('Model: ${machinery.model}', style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                  Text('\$${machinery.price.toStringAsFixed(2)}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 24)),
                  Text(machinery.description, style: TextStyle(color: Colors.grey[800], fontSize: 16, height: 1.5)),
                  _buildSpecificationTable(),
                  ElevatedButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Request for quote sent'))),
                    style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                    child: const Text('Request Quote'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecificationTable() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Specifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildSpecRow('Serial Number', machinery.serialNumber),
            _buildSpecRow('Location', machinery.location),
            _buildSpecRow('Purchase Date', DateFormat('dd MMM yyyy').format(machinery.purchaseDate)),
            _buildSpecRow('Status', machinery.status),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(value, style: TextStyle(color: Colors.grey[800])),
        ],
      ),
    );
  }
}

class Machinery {
  final String id, jobName, model, serialNumber, location, status, description, imageUrl;
  final DateTime purchaseDate;
  final double price;

  Machinery({
    required this.id,
    required this.jobName,
    required this.model,
    required this.serialNumber,
    required this.purchaseDate,
    required this.location,
    required this.status,
    required this.price,
    required this.description,
    required this.imageUrl,
  });
}
