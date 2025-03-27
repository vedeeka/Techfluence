import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MachineryListPage extends StatefulWidget {
  const MachineryListPage({Key? key}) : super(key: key);

  @override
  _MachineryListPageState createState() => _MachineryListPageState();
}

class _MachineryListPageState extends State<MachineryListPage> {
  final List<Machinery> _machineryList = [
    Machinery(
      id: 'M001',
      job_name: 'CNC Milling Machine',
      model: 'XR-500',
      serialNumber: 'SN-2023-0001',
      purchaseDate: DateTime(2023, 5, 15),
      location: 'Production Hall A',
      status: 'Operational',
    ),
    Machinery(
      id: 'M002',
      job_name: 'Lathe Machine',
      model: 'TK-300',
      serialNumber: 'SN-2023-0002',
      purchaseDate: DateTime(2023, 3, 10),
      location: 'Production Hall B',
      status: 'Under Maintenance',
    ),
    Machinery(
      id: 'M003',
      job_name: 'Drilling Press',
      model: 'DP-200',
      serialNumber: 'SN-2023-0003',
      purchaseDate: DateTime(2022, 11, 20),
      location: 'Production Hall C',
      status: 'Operational',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Machinery Inventory'),
        centerTitle: true,
      ),
      body: Column(
        children: [
             _upperBox(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _machineryList.length,
              itemBuilder: (context, index) {
                final machinery = _machineryList[index];
                return _buildMachineryListTile(machinery, context);
              },
            ),
          ),
       
        ],
      ),
    );
  }
Widget _upperBox() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    child: GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 3, // Make boxes wider and shorter
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        _buildInfoBox('Total Machines', '25', Icons.construction),
        _buildInfoBox('Operational', '18', Icons.check_circle_outline),
        _buildInfoBox('Maintenance', '7', Icons.build_circle_outlined),
      ],
    ),
  );
}

Widget _buildInfoBox(String title, String value, IconData icon) {
  return Card(
     elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.blue.shade700, size: 24),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: Colors.blue.shade900,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

  Widget _buildMachineryListTile(Machinery machinery, BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(machinery.status),
          child: Icon(
            _getStatusIcon(machinery.status),
            color: Colors.white,
          ),
        ),
        title: Text(
          machinery.job_name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Model: ${machinery.model}'),
            Text('Location: ${machinery.location}'),
          ],
        ),
        trailing: Text(
          machinery.status,
          style: TextStyle(
            color: _getStatusColor(machinery.status),
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MachineryDetailPage(machinery: machinery),
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'operational':
        return Colors.green;
      case 'under maintenance':
        return Colors.orange;
      case 'out of service':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'operational':
        return Icons.check_circle;
      case 'under maintenance':
        return Icons.build;
      case 'out of service':
        return Icons.error;
      default:
        return Icons.help;
    }
  }
}

class MachineryDetailPage extends StatelessWidget {
  final Machinery machinery;

  const MachineryDetailPage({Key? key, required this.machinery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Machinery Details: ${machinery.job_name}'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
            'assets/images/heroimg.png',
            height: 200,
            width: 300,
            fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildDetailRow('Machine ID', machinery.id),
            _buildDetailRow('job_name', machinery.job_name),
            _buildDetailRow('Model', machinery.model),
            _buildDetailRow('Serial Number', machinery.serialNumber),
            _buildDetailRow(
              'Purchase Date', 
              DateFormat('dd MMM yyyy').format(machinery.purchaseDate)
            ),
            _buildDetailRow('Location', machinery.location),
            _buildDetailRow('Status', machinery.status),
          ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class Machinery {
  final String id;
  final String job_name;
  final String model;
  final String serialNumber;
  final DateTime purchaseDate;
  final String location;
  final String status;

  Machinery({
    required this.id,
    required this.job_name,
    required this.model,
    required this.serialNumber,
    required this.purchaseDate,
    required this.location,
    required this.status,
  });
}