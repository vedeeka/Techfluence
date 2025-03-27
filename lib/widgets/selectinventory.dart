import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techfluence/data/data.dart';
import 'package:techfluence/data/themes.dart';

class SelectInventoryPage extends StatefulWidget {
  final Function(List<Map<String, dynamic>>) items;
  const SelectInventoryPage({super.key, required this.items});

  @override
  State<SelectInventoryPage> createState() => _SelectInventoryPageState();
}

class _SelectInventoryPageState extends State<SelectInventoryPage> {
  final search = TextEditingController();
  List<Map<String, dynamic>> selectedItems = [], send = [];
  void change(int n, bool b) {
    send.clear();
    selectedItems[n]['present'] = b;
    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i]['present'] == true) {
        send.add(selectedItems[i]);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Inventory'),
        actions: [
          SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: TextField(
                controller: search,
                decoration: InputDecoration(
                  hintText: "Search",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: lightGrey,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              )),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {
              widget.items(send);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.check),
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
              child: Text('No data'),
            );
          }
          for (int i = selectedItems.length; i < docs.length; i++) {
            selectedItems.add(docs[i].data());
            selectedItems[i]['id'] = docs[i].id;
            selectedItems[i]['present'] = false;
          }
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              if (docs[index]['status'] != 'available') {
                return Container();
              }
              if (search.text.isNotEmpty &&
                  !docs[index]['name'].toString().contains(search.text)) {
                return Container();
              }
              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: lightGrey),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          docs[index]['name'],
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(docs[index]['status'])
                      ],
                    ),
                    const Spacer(),
                    SelectButton(
                      f: (b) {
                        change(index, b);
                        setState(() {});
                      },
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SelectButton extends StatefulWidget {
  final Function(bool) f;
  const SelectButton({
    super.key,
    required this.f,
  });

  @override
  State<SelectButton> createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton> {
  bool b = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        b = !b;
        setState(() {});
        widget.f(b);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: b ? Colors.green : Colors.red),
        width: MediaQuery.of(context).size.width / 10,
        child: Text(
          b ? "Selected" : "Not Selected",
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
