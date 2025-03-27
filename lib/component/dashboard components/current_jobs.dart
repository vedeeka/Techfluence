import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        title: Text('Machinery List'),
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