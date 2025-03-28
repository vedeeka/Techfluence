import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techfluence/component/dashboard%20components/current_jobs.dart';
import 'package:techfluence/data/data.dart';
import 'package:techfluence/pages/dashboard.dart';
import 'package:techfluence/pages/jobdetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:techfluence/pages/scheduler.dart';

Widget _buildStatusChip(String status) {
  Color chipColor;
  switch (status.toLowerCase()) {
    case 'active':
      chipColor = Colors.green[100]!;
      break;
    case 'pending':
      chipColor = Colors.orange[100]!;
      break;
    case 'completed':
      chipColor = Colors.blue[100]!;
      break;
    default:
      chipColor = Colors.grey[200]!;
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: chipColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      status,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

class JobsPage extends StatelessWidget {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Permanent Sidebar
          Container(
            width: 250,
            color: Colors.white,
            child: Column(
              children: [
                // Sidebar Header
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Equipment Hub',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Sidebar Menu Items
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.dashboard),
                        title: const Text('Dashboard'),
                        selected: true,
                        selectedColor: Colors.blue,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) =>
                                  const EquipmentMaintenanceApp(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.list),
                        title: const Text('Maintenance'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => const MachineryListPage(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text('Ongoing Jobs'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => const JobsPage(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.access_time),
                        title: const Text('Schedular'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => const SchedulerPage(),
                            ),
                          );
                        },
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
                backgroundColor: Colors.white,
                title: const Text("Dashboard"),
                shadowColor: Colors.black,
                elevation: 1,
                actions: [
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
              body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(backendBaseString)
                    .doc(globalEmail)
                    .collection('jobs')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var docs = snapshot.data!.docs;
                  if (docs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.work_off_outlined,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No Jobs Available',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Check back later or adjust your filters',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> job = docs[index].data();
                      job['id'] = docs[index].id;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => JobDetails(
                                job: job,
                              ),
                              settings: RouteSettings(
                                name: 'job-details',
                                arguments: job,
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    job['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    job['description'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      _buildStatusChip(job['status']),
                                      const SizedBox(width: 8),
                                      Text(
                                        job['date'] is Timestamp
                                            ? DateFormat('MM/dd/yyyy').format(
                                                (job['date'] as Timestamp)
                                                    .toDate())
                                            : job['date'].toString(),
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          print(
                                              'deletion of job and items available');
                                        },
                                        icon: const Icon(Icons.delete),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
