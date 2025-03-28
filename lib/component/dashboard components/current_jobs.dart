import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techfluence/data/data.dart';
import 'package:techfluence/widgets/buttons.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';

void main() {
  Gemini.init(apiKey: apiKey, enableDebugging: true);

  runApp(const MyApp());
}

const apiKey = 'AIzaSyBtfDLk9Sb3HvvZ7ZLXdlBRK9BKREy-j5g';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MachineryListPage(),
    );
  }
}

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

class MachineryListPage extends StatefulWidget {
  const MachineryListPage({super.key});

  @override
  State<MachineryListPage> createState() => _MachineryListPageState();
}

class _MachineryListPageState extends State<MachineryListPage> {
  final TextEditingController searchController = TextEditingController();

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
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.list),
                        title: const Text('Maintenance'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.add_circle_outline),
                        title: const Text('Analytics'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text('Profile'),
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
                backgroundColor: Colors.white,
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
                        onChanged: (value) {
                          setState(() {});
                        },
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
              body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(backendBaseString)
                    .doc(globalEmail)
                    .collection('inventory')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var docs = snapshot.data!.docs;
                  if (docs.isEmpty) {
                    return const Center(
                      child: Text('No Data'),
                    );
                  }
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final machinery = docs[index].data();
                      machinery['id'] = docs[index].id;
                      if (searchController.text.isNotEmpty &&
                          !machinery['name']
                              .toString()
                              .contains(searchController.text)) {
                        return Container();
                      }
                      if (searchController.text.isNotEmpty &&
                          searchController.text.startsWith('#') &&
                          !List.from(docs[index]['tags']).contains(
                              searchController.text.split('x').last)) {
                        return Container();
                      }
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MachineryDetailPage(machinery: machinery),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  // Status Indicator
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: machinery['status'] == 'available'
                                          ? Colors.green.shade50
                                          : machinery['status'] == 'unavailable'
                                              ? Colors.red.shade50
                                              : Colors.orange.shade50,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        machinery['status'] == 'available'
                                            ? Icons.check_circle
                                            : machinery['status'] ==
                                                    'unavailable'
                                                ? Icons.block_rounded
                                                : Icons.warning_rounded,
                                        color:
                                            machinery['status'] == 'available'
                                                ? Colors.green.shade600
                                                : machinery['status'] ==
                                                        'unavailable'
                                                    ? Colors.red.shade600
                                                    : Colors.orange.shade600,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),

                                  // Machine Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          machinery['name'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[800],
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          machinery['description'],
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Status Badge
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: machinery['status'] == 'available'
                                          ? Colors.green.shade100
                                          : machinery['status'] == 'unavailable'
                                              ? Colors.red.shade100
                                              : Colors.orange.shade100,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      machinery['status'],
                                      style: TextStyle(
                                        color:
                                            machinery['status'] == 'available'
                                                ? Colors.green.shade800
                                                : machinery['status'] ==
                                                        'unavailable'
                                                    ? Colors.red.shade800
                                                    : Colors.orange.shade800,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
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
          ),
        ],
      ),
    );
  }
}

class MachineryDetailPage extends StatefulWidget {
  final Map<String, dynamic> machinery;

  const MachineryDetailPage({super.key, required this.machinery});

  @override
  State<MachineryDetailPage> createState() => _MachineryDetailPageState();
}

class _MachineryDetailPageState extends State<MachineryDetailPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  int s = 0;
  String _generateQRData() {
    return '''
Machinery Details
-----------------
ID:${widget.machinery['name']}
Model: ${widget.machinery['model']}
Status: ${widget.machinery['status']}
''';
  }

  void addMessage(String sender, String message) {
    setState(() {
      _messages.add({sender: message} as Map<String, String>);
    });
  }

  void initializeController() {
    if (widget.machinery.isEmpty) {
      print("Error: Machinery data is empty.");
      return;
    }

    if (_controller.text.isEmpty) {
      String prompt =
          "Failure Prediction AI request: Analyze past maintenance data to predict failures. Answer my question as per this data\n"
          "Machinery Details:\n"
          "Name: ${widget.machinery['name'] ?? 'N/A'}\n"
          "Model: ${widget.machinery['model'] ?? 'N/A'}\n"
          "Status: ${widget.machinery['status'] ?? 'N/A'}";

      Gemini.instance.prompt(parts: [
        Part.text(prompt),
      ]).then((value) {
        addMessage('bot', value?.output ?? 'No response received.');
      });
    }
    setState(() {});
  }

  @override
  void initState() {
    initializeController(); // Directly execute during initialization
    super.initState();
  }

  void _openChatDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text(
                'Chatbot Help',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1873E8),
                ),
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final message = _messages[index];
                          final isUser = message.keys.first == 'user';
                          return Align(
                            alignment: isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isUser
                                    ? const Color(0xFF1873E8).withOpacity(0.1)
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                message.values.first,
                                style: TextStyle(
                                  color: isUser
                                      ? const Color(0xFF1873E8)
                                      : Colors.grey[800],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            maxLines: 3,
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Type your message...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF1873E8),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.send),
                          color: const Color(0xFF1873E8),
                          onPressed: () {
                            Gemini.instance.prompt(parts: [
                              Part.text(_controller.text),
                            ]).then((value) {
                              if (s != 0) {
                                setState(() {
                                  _messages.add({'user': _controller.text});
                                });
                              }
                              s = 1;
                              addMessage('bot',
                                  value?.output ?? 'No response received.');
                              _controller.clear();
                              setDialogState(() {}); // Update the dialog UI
                            });
                            setDialogState(() {}); // Update the dialog UI
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF1873E8),
                    ),
                    child: const Center(
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.machinery['name']),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editMachinery,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Card(
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
              ),
              // Machine Overview Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow(
                        icon: Icons.power,
                        label: 'Status',
                        value: widget.machinery['status'],
                        valueColor: widget.machinery['status'] == 'available'
                            ? Colors.green
                            : Colors.orange,
                      ),
                    ],
                  ),
                ),
              ),

              if (widget.machinery['status'] == 'maintenance')
                MyButton(
                    f: () async {
                      await FirebaseFirestore.instance
                          .collection(backendBaseString)
                          .doc(globalEmail)
                          .collection('inventory')
                          .doc(widget.machinery['id'])
                          .update({'level': 'none', 'status': 'available'});
                      var v = await FirebaseFirestore.instance
                          .collection(backendBaseString)
                          .doc(globalEmail)
                          .collection(
                              'inventory/${widget.machinery['id']}/maintenance')
                          .get()
                          .then((onValue) {
                        return onValue.docs;
                      });
                      for (var i in v) {
                        await FirebaseFirestore.instance
                            .collection(backendBaseString)
                            .doc(globalEmail)
                            .collection(
                                'inventory/${widget.machinery['id']}/maintenance')
                            .doc(i.id)
                            .delete();
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    text: "Completed Maintenance"),

              const SizedBox(height: 20),

              // Additional Details Section
              const Text(
                'Additional Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoTile(
                        title: 'Last Maintenance',
                        subtitle: 'June 15, 2024',
                        icon: Icons.build_circle,
                      ),
                      const Divider(),
                      _buildInfoTile(
                        title: 'Next Scheduled Maintenance',
                        subtitle: 'December 15, 2024',
                        icon: Icons.calendar_today,
                      ),
                      const Divider(),
                      _buildInfoTile(
                        title: 'Total Operating Hours',
                        subtitle: '1,245 hours',
                        icon: Icons.timer,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openChatDialog,
        child: const Icon(Icons.chat),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoTile({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
    );
  }

  void _editMachinery() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit Machinery feature coming soon')),
    );
  }
}
