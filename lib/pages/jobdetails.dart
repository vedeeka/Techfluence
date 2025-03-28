import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techfluence/data/data.dart';
import 'package:techfluence/widgets/buttons.dart';
import 'package:techfluence/widgets/selectinventory.dart';
import 'package:techfluence/widgets/textfields.dart';

class JobDetails extends StatefulWidget {
  final Map<String, dynamic> job;
  const JobDetails({super.key, required this.job});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  final searchController = TextEditingController();
  List<Map<String, dynamic>> items = [];
  List<String> itemId = [];
  String risk = 'none';

  void calculateDamage() async {
    if (widget.job.containsKey('level')) {
      if (widget.job['level'] == 'urgent') {
        risk = 'urgent';
        return;
      }
    }

    int count = 0;
    for (var i in itemId) {
      var v = await FirebaseFirestore.instance
          .collection(backendBaseString)
          .doc(globalEmail)
          .collection('inventory/$i/maintenance')
          .get()
          .then((onValue) {
        return onValue.docs;
      });
      for (var a in v) {
        if (a.data()['level'] == 'high') {
          count += 3;
        } else if (a.data()['level'] == 'mid') {
          count += 2;
        } else if (a.data()['level'] == 'low') {
          count += 1;
        }
      }
    }
    if (count >= 15) {
      risk = "urgent";
    } else if (count >= 10) {
      risk = 'high';
    } else if (count >= 5) {
      risk = 'mid';
    }
    setState(() {});
  }

  void dispatch() async {
    List<String> i = [];
    for (var item in items) {
      i.add(item['id']);
      await FirebaseFirestore.instance
          .collection(backendBaseString)
          .doc(globalEmail)
          .collection('inventory')
          .doc(item['id'])
          .update({'status': 'unavailable'});
    }
    await FirebaseFirestore.instance
        .collection(backendBaseString)
        .doc(globalEmail)
        .collection('jobs')
        .doc(widget.job['id'])
        .update({'status': 'ongoing', 'inventory': i});
    loadData();
  }

  void loadData() async {
    itemId.clear();
    var v = await FirebaseFirestore.instance
        .collection(backendBaseString)
        .doc(globalEmail)
        .collection('jobs')
        .doc(widget.job['id'])
        .get()
        .then((onValue) {
      return onValue.data() ?? {};
    });
    if (v.containsKey('inventory')) {
      itemId = List.from(v['inventory']);
    }

    for (var i in itemId) {
      Map<String, dynamic> v = await FirebaseFirestore.instance
          .collection(backendBaseString)
          .doc(globalEmail)
          .collection('inventory')
          .doc(i)
          .get()
          .then((onValue) {
        return onValue.data() ?? {};
      });
      v['id'] = i;
      items.add(v);
    }
    setState(() {});
  }

  void completeOrder() async {
    for (var i in items) {
      await FirebaseFirestore.instance
          .collection(backendBaseString)
          .doc(globalEmail)
          .collection('inventory')
          .doc(i['id'])
          .update({'status': i['status'], 'level': i['level']});

      await FirebaseFirestore.instance
          .collection(backendBaseString)
          .doc(globalEmail)
          .collection('inventory/${i['id']}/maintenance')
          .doc()
          .set({
        'job': widget.job['name'],
        'level': i['level'],
        'description': i['des']
      });
    }

    await FirebaseFirestore.instance
        .collection(backendBaseString)
        .doc(globalEmail)
        .collection('jobs')
        .doc(widget.job['id'])
        .update({'status': 'complete'});
    widget.job['status'] = 'complete';
    setState(() {});
  }

  @override
  void initState() {
    if (widget.job['status'] == 'ongoing') {
      loadData();
    }
    calculateDamage();

    super.initState();
  }

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
                      color: Colors.white,
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
              title: const Text("Dashboard"),
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text(
                    'Status: ${widget.job['status']}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  if (widget.job['status'] == 'upcoming')
                    Column(
                      children: [
                        MyButton(
                            f: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SelectInventoryPage(items: (list) {
                                      items.clear();
                                      for (var i in list) {
                                        items.add(i);
                                      }
                                      setState(() {});
                                    });
                                  },
                                ),
                              );
                            },
                            text: 'Add Inventory'),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Text(
                              items[index]['name'],
                              style: const TextStyle(fontSize: 17),
                            );
                          },
                        ),
                        MyButton(
                            f: () {
                              dispatch();
                              widget.job['status'] = 'ongoing';
                              setState(() {});
                            },
                            text: "Dispatch For Job")
                      ],
                    ),
                  if (widget.job['status'] == 'ongoing')
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: items.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final info = TextEditingController();
                            String level = 'none';
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          items[index]['name'],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
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
                                              '${items[index]['name']} Details',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF1873E8),
                                              ),
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Status: Operational',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                const Text(
                                                  'Last Maintenance: 2 days ago',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                DropdownButton(
                                                  hint: const Text(
                                                      "Damage Level"),
                                                  items: const [
                                                    DropdownMenuItem(
                                                      value: 'none',
                                                      child: Text("None"),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: 'low',
                                                      child: Text("Low"),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: 'mid',
                                                      child: Text("Medium"),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: 'high',
                                                      child: Text("High"),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: 'urgent',
                                                      child: Text("Urgent"),
                                                    ),
                                                  ],
                                                  onChanged: ((val) {
                                                    if (val == 'urgent') {
                                                      items[index]['status'] =
                                                          'maintenance';
                                                    } else {
                                                      items[index]['status'] =
                                                          'available';
                                                    }
                                                    level = val!;
                                                  }),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: MyTextField(
                                                      c: info,
                                                      hint: 'additional info'),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: MyButton(
                                                      f: () {
                                                        calculateDamage();
                                                        items[index]['des'] =
                                                            info.text;
                                                        items[index]['level'] =
                                                            risk;
                                                        Navigator.pop(context);
                                                      },
                                                      text: 'Add details'),
                                                )
                                              ],
                                            ),
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
                        MyButton(f: completeOrder, text: 'Complete order')
                      ],
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
