import 'package:flutter/cupertino.dart';
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
    ),
    // Add other machinery items here...
  ];

  MachineryProductGridPage({super.key});
  final TextEditingController searchController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
               
                    title: Row(
                      
                      children: [
                        
                        const Text("Dashboard"),
                        const SizedBox(width: 20),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Page 1",
                              style: TextStyle(color: Colors.black)),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Page 2",
                              style: TextStyle(color: Colors.black)),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Page 3",
                              style: TextStyle(color: Colors.black)),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Page 4",
                              style: TextStyle(color: Colors.black)),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Page 5",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                    shadowColor: Colors.black,
                    elevation: 1,
                    actions: [
                      Container(
                        height: double.infinity,
                        width: 350,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: TextField(
                            controller: searchController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: "Search",
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.bell_fill),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.help),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.settings),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.person),
                      ),
                    ],
                  ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 3,
        ),
        itemCount: machineryList.length,
        itemBuilder: (context, index) =>
            _buildProductCard(context, machineryList[index]),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Machinery machinery) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MachineryDetailPage(machinery: machinery)),
      ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(machinery.imageUrl,
                  height: 80, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(machinery.jobName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(machinery.model,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  Text('\$${machinery.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(machinery.status).withAlpha(55),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(machinery.status,
                        style: TextStyle(
                            color: _getStatusColor(machinery.status),
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
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
      case 'operational':
        return Colors.green;
      case 'under maintenance':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
class MachineryDetailPage extends StatelessWidget {
  final Machinery machinery;

  const MachineryDetailPage({super.key, required this.machinery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Sidebar Navigation
          Container(
            width: 250,
            color: Colors.grey[100],
            child: Column(
              children: [
                // Logo or Header
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Machinery',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _buildNavItem(
                        icon: Icons.dashboard,
                        title: 'Dashboard',
                        isSelected: true,
                        onTap: () {},
                      ),
                      _buildNavItem(
                        icon: Icons.list,
                        title: 'Machinery List',
                        onTap: () {},
                      ),
                      _buildNavItem(
                        icon: Icons.add_circle_outline,
                        title: 'Add Machinery',
                        onTap: () {},
                      ),
                      _buildNavItem(
                        icon: Icons.settings,
                        title: 'Settings',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Main Content Area
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                title: Text(machinery.jobName),
                elevation: 1,
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      machinery.imageUrl,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            machinery.jobName,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Model: ${machinery.model}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${machinery.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            machinery.description,
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildSpecificationTable(),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Request for quote sent')),
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Request Quote'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create consistent navigation items
  Widget _buildNavItem({
    required IconData icon,
    required String title,
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Colors.blue : Colors.grey[600],
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.blue : Colors.grey[800],
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedColor: Colors.blue,
      onTap: onTap,
    );
  }

  // Specification Table (assumed implementation)
  Widget _buildSpecificationTable() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
          },
          children: [
            _buildTableRow('Status', machinery.status),
            _buildTableRow('Model', machinery.model),
            _buildTableRow('Price', '\$${machinery.price.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  // Helper method to create table rows
  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            value,
            style: TextStyle(
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }
}

  Widget _buildSpecificationTable(Machinery machinery) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Specifications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildSpecRow('Serial Number', machinery.serialNumber),
            _buildSpecRow('Location', machinery.location),
            _buildSpecRow('Purchase Date',
                DateFormat('dd MMM yyyy').format(machinery.purchaseDate)),
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


class Machinery {
  final String id,
      jobName,
      model,
      serialNumber,
      location,
      status,
      description,
      imageUrl;
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
