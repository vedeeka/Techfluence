import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ResponsiveDashboardScreen(),
    );
  }
}

// Status Card Widget
class StatusCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const StatusCard({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 36),
                const Icon(Icons.more_vert, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// App Theme (since it was referenced but not defined)
class AppTheme {
  static const Color primaryColor = Colors.blue;
  static const Color surfaceColor = Colors.white;
}

// Responsive Dashboard Screen
class ResponsiveDashboardScreen extends StatefulWidget {
  @override
  _ResponsiveDashboardScreenState createState() => _ResponsiveDashboardScreenState();
}

class _ResponsiveDashboardScreenState extends State<ResponsiveDashboardScreen> {
  bool _isCompactMode = false;
  List<Map<String, dynamic>> inventoryItems = [];
  List<Map<String, dynamic>> jobList = [];
  
  // Placeholder for global email (you should replace this with actual authentication)
  String globalEmail = 'user@example.com';
  String backendBaseString = 'equipment_management';

  void loadData() async {
    try {
      setState(() {
        inventoryItems.clear();
        jobList.clear();
      });

      // Fetch inventory items
      var inventoryDocs = await FirebaseFirestore.instance
          .collection(backendBaseString)
          .doc(globalEmail)
          .collection('inventory')
          .get();
      
      // Fetch job list
      var jobDocs = await FirebaseFirestore.instance
          .collection(backendBaseString)
          .doc(globalEmail)
          .collection('jobs')
          .get();

      setState(() {
        inventoryItems = inventoryDocs.docs.map((doc) => doc.data()).toList();
        jobList = jobDocs.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _isCompactMode = constraints.maxWidth < 800;

        return Scaffold(
          body: Row(
            children: [
              // Sidebar Navigation
              if (!_isCompactMode) _buildSidebar(),

              // Main Content Area
              Expanded(
                child: _buildMainContent(),
              ),
            ],
          ),
          bottomNavigationBar: _isCompactMode ? _buildMobileNavigation() : null,
        );
      },
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 250,
      color: AppTheme.surfaceColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Equipment Hub',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          _buildSidebarItem(Icons.dashboard, 'Dashboard', isActive: true),
          _buildSidebarItem(Icons.schedule, 'Maintenance'),
          _buildSidebarItem(Icons.analytics, 'Analytics'),
          _buildSidebarItem(Icons.person, 'Profile'),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Add Equipment'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String label, {bool isActive = false}) {
    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? AppTheme.primaryColor : Colors.grey,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isActive ? AppTheme.primaryColor : Colors.grey[700],
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {},
      selected: isActive,
    );
  }

  Widget _buildMobileNavigation() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppTheme.primaryColor,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          activeIcon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule_outlined),
          activeIcon: Icon(Icons.schedule),
          label: 'Schedule',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics_outlined),
          activeIcon: Icon(Icons.analytics),
          label: 'Analytics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    final searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text("Dashboard"),
            const SizedBox(width: 20),
            ...List.generate(5, (index) => 
              TextButton(
                onPressed: () {},
                child: Text("Page ${index + 1}", style: const TextStyle(color: Colors.black)),
              )
            ),
          ],
        ),
        actions: [
          Container(
            width: 350,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStatusOverview(),
              const SizedBox(height: 16),
              BuildEquipmentList(), // This was undefined, so I added a placeholder
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusOverview() {
    return Row(
      children: [
        Expanded(
          child: StatusCard(
            title: 'Total Equipment',
            value: '124',
            color: AppTheme.primaryColor,
            icon: Icons.devices,
          ),
        ),
        Expanded(
          child: StatusCard(
            title: 'Maintenance Due',
            value: '12',
            color: Colors.orange,
            icon: Icons.build_circle,
          ),
        ),
        Expanded(
          child: StatusCard(
            title: 'Critical Assets',
            value: '3',
            color: Colors.red,
            icon: Icons.warning_amber_rounded,
          ),
        ),
      ],
    );
  }
}

// Placeholder for BuildEquipmentList
class BuildEquipmentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Equipment List Placeholder'),
    );
  }
}

// Machinery Model and Pages
class Machinery {
  final String id;
  final String name;
  final String model;
  final String status;

  Machinery({
    required this.id,
    required this.name,
    required this.model,
    required this.status,
  });
}

class MachineryListPage extends StatelessWidget {
  final List<Machinery> _machineryList = [
    Machinery(
      id: 'M001',
      name: 'CNC Milling Machine',
      model: 'XR-500',
      status: 'Operational',
    ),
    Machinery(
      id: 'M002',
      name: 'Lathe Machine',
      model: 'TK-300',
      status: 'Under Maintenance',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Machinery List'),
      ),
      body: ListView.builder(
        itemCount: _machineryList.length,
        itemBuilder: (context, index) {
          final machinery = _machineryList[index];
          return ListTile(
            title: Text(machinery.name),
            subtitle: Text(machinery.model),
            trailing: Text(
              machinery.status,
              style: TextStyle(
                color: machinery.status == 'Operational'
                    ? Colors.green
                    : Colors.orange,
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
          );
        },
      ),
    );
  }
}

class MachineryDetailPage extends StatelessWidget {
  final Machinery machinery;

  const MachineryDetailPage({Key? key, required this.machinery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(machinery.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${machinery.id}'),
            Text('Name: ${machinery.name}'),
            Text('Model: ${machinery.model}'),
            Text('Status: ${machinery.status}'),
          ],
        ),
      ),
    );
  }
}