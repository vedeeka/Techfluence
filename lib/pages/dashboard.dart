import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techfluence/component/dashboard%20components/current_jobs.dart';
import 'package:techfluence/component/dashboard%20components/equipment.dart';
import 'package:techfluence/component/dashboard%20components/jobspage.dart';
import 'package:techfluence/data/data.dart';
import 'package:techfluence/widgets/popups.dart';

class EquipmentCard extends StatefulWidget {
  final String name;
  final double width;
  final int input;
  final List<Map<String, dynamic>> items;

  const EquipmentCard({
    required this.name,
    required this.width,
    required this.input,
    required this.items,
    super.key,
  });

  @override
  State<EquipmentCard> createState() => _EquipmentCardState();
}

class _EquipmentCardState extends State<EquipmentCard> {
//1=available 2=upcoming 3=maintenance machine 4=ongoing jobs
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                if (widget.input == 1) {
                                  return MachineryProductGridPage();
                                } else if (widget.input == 3) {
                                  return const MachineryListPage();
                                }
                                return const JobsPage();
                              },
                            ),
                          );
                        },
                        label: const Text("View"),
                        icon: const Icon(Icons.remove_red_eye),
                      ),
                      if (widget.input < 3)
                        TextButton.icon(
                          onPressed: () {
                            if (widget.input == 1) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AddInventoryPopUp(
                                    f: (p0) {
                                      widget.items.add(p0);
                                      setState(() {});
                                    },
                                  );
                                },
                              );
                            }
                            if (widget.input == 2) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AddJobPopUp(
                                    f: (p0) {
                                      widget.items.add(p0);
                                      setState(() {});
                                    },
                                  );
                                },
                              );
                            }
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Add New'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            ...List.generate(
              widget.items.isEmpty
                  ? 0
                  : widget.items.length > 3
                      ? 3
                      : widget.items.length,
              (index) => _buildEquipmentRow(
                name: widget.items[index]['name'],
                status: widget.items[index]['status'],
                lastMaintenance: '2 weeks ago',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int page = 0;
Widget _buildEquipmentRow({
  required String name,
  required String status,
  required String lastMaintenance,
}) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: AppTheme.primaryColor.withAlpha(25),
      child: const Icon(Icons.precision_manufacturing,
          color: AppTheme.primaryColor),
    ),
    title: Text(
      name,
      style: const TextStyle(fontWeight: FontWeight.w600),
    ),
    subtitle: Text(
      'Last Maintenance: $lastMaintenance',
      style: const TextStyle(color: Colors.grey),
    ),
    trailing: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: status == 'available'
            ? AppTheme.secondaryColor.withAlpha(25)
            : status == 'maintenance'
                ? Colors.yellow.withAlpha(25)
                : Colors.red.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: status == 'available'
              ? AppTheme.secondaryColor
              : status == 'maintenance'
                  ? const Color.fromARGB(255, 250, 218, 10)
                  : Colors.red,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    onTap: () {},
  );
}

class StatusOverview extends StatefulWidget {
  final int totalEquipments, maintenance, critical;
  const StatusOverview(
      {super.key,
      required this.critical,
      required this.maintenance,
      required this.totalEquipments});

  @override
  State<StatusOverview> createState() => _StatusOverviewState();
}

class _StatusOverviewState extends State<StatusOverview> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatusCard(
            title: 'Total Equipment',
            value: widget.totalEquipments.toString(),
            color: AppTheme.primaryColor,
            icon: Icons.devices,
          ),
        ),
        Expanded(
          child: _StatusCard(
            title: 'Maintenance Due',
            value: widget.maintenance.toString(),
            color: Colors.orange,
            icon: Icons.build_circle,
          ),
        ),
        Expanded(
          child: _StatusCard(
            title: 'Critical Assets',
            value: widget.critical.toString(),
            color: Colors.red,
            icon: Icons.warning_amber_rounded,
          ),
        ),
      ],
    );
  }
}

class MobileNavigation extends StatefulWidget {
  const MobileNavigation({super.key});

  @override
  State<MobileNavigation> createState() => _MobileNavigationState();
}

class _MobileNavigationState extends State<MobileNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
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

// Enhanced Theme and Design Constants
class AppTheme {
  // Modern, professional color palette
  static const Color primaryColor = Color(0xFF1A73E8); // Google Blue
  static const Color secondaryColor = Color(0xFF34A853); // Google Green
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color surfaceColor = Colors.white;
  static const Color textColor = Color(0xFF202124);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        color: surfaceColor,
        elevation: 1,
        centerTitle: false,
        iconTheme: IconThemeData(color: primaryColor),
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardTheme(
        color: surfaceColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      textTheme: TextTheme(
        headlineMedium: const TextStyle(
          color: textColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: const TextStyle(
          color: textColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: textColor.withAlpha(200),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
      ),
    );
  }
}

// Advanced Responsive Dashboard
class ResponsiveDashboardScreen extends StatefulWidget {
  const ResponsiveDashboardScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ResponsiveDashboardScreenState createState() =>
      _ResponsiveDashboardScreenState();
}

class _ResponsiveDashboardScreenState extends State<ResponsiveDashboardScreen> {
  bool _isCompactMode = false;
  List<Map<String, dynamic>> inventoryItems = [],
      jobList = [],
      ongoingJobs = [],
      idleMachines = [],
      maintenanceMachine = [],
      upcomingJobs = [];
  void segregate() {
    ongoingJobs.clear();
    upcomingJobs.clear();
    idleMachines.clear();
    maintenanceMachine.clear();

    for (var i in inventoryItems) {
      if (i['status'] == 'available') {
        idleMachines.add(i);
      } else if (i['status'] == 'maintenance') {
        maintenanceMachine.add(i);
      }
    }
    for (var j in jobList) {
      if (j['status'] == 'upcoming') {
        upcomingJobs.add(j);
        continue;
      } else if (j['status'] == 'ongoing') {
        ongoingJobs.add(j);
      }
    }
    setState(() {});
  }

  void loadData() async {
    inventoryItems.clear();
    jobList.clear();
    var docs = await FirebaseFirestore.instance
        .collection(backendBaseString)
        .doc(globalEmail)
        .collection('inventory')
        .get()
        .then((onValue) {
      return onValue.docs;
    });
    for (var d in docs) {
      Map<String, dynamic> i = d.data();
      i['id'] = d.id;
      inventoryItems.add(i);
    }
    var docs2 = await FirebaseFirestore.instance
        .collection(backendBaseString)
        .doc(globalEmail)
        .collection('jobs')
        .get()
        .then(
      (onValue) {
        return onValue.docs;
      },
    );
    for (var d in docs2) {
      Map<String, dynamic> i = d.data();
      i['id'] = d.id;
      jobList.add(i);
    }
    segregate();
    setState(() {});
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }
  // Define the 'page' variable

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return LayoutBuilder(
      builder: (context, constraints) {
        _isCompactMode = constraints.maxWidth < 800;

        return Scaffold(
          body: Row(
            children: [
              Container(
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
                    _buildSidebarItem(Icons.dashboard, 'Dashboard',
                        isActive: true),
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
              ),
              // Main Content Area
              Expanded(
                child: Scaffold(
                  appBar: AppBar(
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
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          StatusOverview(
                            totalEquipments: inventoryItems.length,
                            critical: 0,
                            maintenance: maintenanceMachine.length,
                          ),
                          const SizedBox(height: 16),
                          BuildEquipmentList(
                            aItems: idleMachines,
                            mItems: maintenanceMachine,
                            uJobs: upcomingJobs,
                            oJobs: ongoingJobs,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: _isCompactMode ? const MobileNavigation() : null,
        );
      },
    );
  }
}

class BuildEquipmentList extends StatefulWidget {
  final List<Map<String, dynamic>> aItems, mItems, uJobs, oJobs;
  const BuildEquipmentList(
      {super.key,
      required this.aItems,
      required this.mItems,
      required this.oJobs,
      required this.uJobs});

  @override
  State<BuildEquipmentList> createState() => _BuildEquipmentListState();
}

class _BuildEquipmentListState extends State<BuildEquipmentList> {
  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 2.5;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EquipmentCard(
                  name: "Ongoing Job List",
                  width: cardWidth,
                  input: 4,
                  items: widget.oJobs,
                ),
                EquipmentCard(
                  name: "Maintenance Machine List",
                  width: cardWidth,
                  input: 3,
                  items: widget.mItems,
                ),
                const SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EquipmentCard(
                  name: "Idle Machines",
                  width: cardWidth,
                  input: 1,
                  items: widget.aItems,
                ),
                EquipmentCard(
                  name: "Upcoming Job List",
                  width: cardWidth,
                  input: 2,
                  items: widget.uJobs,
                ),
                const SizedBox(width: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Status Card Widget
class _StatusCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;
  const _StatusCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

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

// Main Application
class EquipmentMaintenanceApp extends StatelessWidget {
  const EquipmentMaintenanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Equipment Maintenance Hub',
      theme: AppTheme.lightTheme,
      home: const ResponsiveDashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
