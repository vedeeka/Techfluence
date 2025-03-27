import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobDetails extends StatefulWidget {
  final Map<String, dynamic> job;
  const JobDetails({super.key, required this.job});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1873E8);
    return Row(
      children: [
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
                    Material(
                      child: Text(
                        'Equipment Hub',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
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
                    Material(
                      color: Colors.white,
                      child: ListTile(
                        leading: const Icon(Icons.dashboard),
                        title: const Text('Dashboard'),
                        selected: true,
                        selectedColor: Colors.blue,
                        onTap: () {},
                      ),
                    ),
                    Material(
                      color: Colors.white,
                      child: ListTile(
                        leading: const Icon(Icons.list),
                        title: const Text('Machinery List'),
                        onTap: () {},
                      ),
                    ),
                    Material(
                      color: Colors.white,
                      child: ListTile(
                        leading: const Icon(Icons.add_circle_outline),
                        title: const Text('Add Machinery'),
                        onTap: () {},
                      ),
                    ),
                    Material(
                      color: Colors.white,
                      child: ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text('Settings'),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex:
                            3, // Increased flex value to make the description box wider
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              margin:
                                  const EdgeInsets.only(bottom: 10, left: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withAlpha(78),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Text(
                                widget.job['name'],
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withAlpha(78),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Text(
                                widget.job['description'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex:
                            1, // Reduced flex value for the image to balance the layout
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Center(
                            child: Image.network(
                              'https://t4.ftcdn.net/jpg/00/44/71/01/360_F_44710125_h5BZVCNCLcvnCVylyxhw9oHfgYTBqg6O.jpg',
                              height:
                                  280, // Adjusted height to match the combined height of "Job Name" and "Job Description"
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        final machineNames = [
                          'Machine 1',
                          'Machine 2',
                          'Machine 3'
                        ];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withAlpha(78),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      machineNames[index],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const Text("Machine Description"),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.info_outline,
                                    size: 32,
                                  ),
                                  onPressed: () {
                                    // Show machine details directly
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        title: Text(
                                          '${machineNames[index]} Details',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF1873E8),
                                          ),
                                        ),
                                        content: const Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Status: Operational',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              'Last Maintenance: 2 days ago',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  const Color(0xFF1873E8),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('Close'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
