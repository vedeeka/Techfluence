import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techfluence/data/data.dart';
import 'package:techfluence/data/themes.dart';
import 'package:techfluence/widgets/buttons.dart';
import 'package:techfluence/widgets/textfields.dart';

class AddInventoryPopUp extends StatefulWidget {
  const AddInventoryPopUp({super.key});

  @override
  State<AddInventoryPopUp> createState() => _AddInventoryPopUpState();
}

class _AddInventoryPopUpState extends State<AddInventoryPopUp> {
  final name = TextEditingController(),
      des = TextEditingController(),
      tagC = TextEditingController();

  List<String> tags = [];

  void addInv() async {
    var i = InventoryClass();
    i.inventory['name'] = name.text.trim();
    i.inventory['tags'] = tags;
    i.inventory['description'] = des.text.trim();
    await FirebaseFirestore.instance
        .collection('hackathons/techfluence/companies/$globalEmail/inventory')
        .doc()
        .set(i.inventory);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Inventory Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(c: name, hint: "Equipment name with model info"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(
              c: des,
              hint: "Description",
              lineNo: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(
              c: tagC,
              hint: "Tags",
              onEnter: (p0) {
                if (tagC.text.isEmpty) {
                  return;
                }
                tags.add(tagC.text.trim());
                tagC.clear();
                setState(() {});
              },
              suffix: IconButton(
                onPressed: () {
                  if (tagC.text.isEmpty) {
                    return;
                  }
                  tags.add(tagC.text.trim());
                  tagC.clear();
                  setState(() {});
                },
                icon: const Icon(Icons.send),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                height: tags.isEmpty ? 0 : 25,
                width: MediaQuery.of(context).size.width / 3,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tags.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: lightGrey,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(tags[index]),
                            const SizedBox(width: 2),
                            GestureDetector(
                              onTap: () {
                                tags.removeAt(index);
                                setState(() {});
                              },
                              child: const Icon(
                                Icons.cancel_rounded,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
          ),
          MyButton(
              f: () {
                addInv();
                Navigator.pop(context);
              },
              text: 'Add Equipment')
        ],
      ),
    );
  }
}

class AddJobPopUp extends StatefulWidget {
  const AddJobPopUp({super.key});

  @override
  State<AddJobPopUp> createState() => _AddJobPopUpState();
}

class _AddJobPopUpState extends State<AddJobPopUp> {
  final name = TextEditingController(), des = TextEditingController();
  void addJob() async {
    await FirebaseFirestore.instance
        .collection(backendBaseString)
        .doc(globalEmail)
        .collection('jobs')
        .doc()
        .set({
      'name': name.text.trim(),
      'description': des.text.trim(),
      'date': DateTime.now(),
      'status': 'upcoming'
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Job'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(c: name, hint: "Job name"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(
              c: des,
              hint: "Job description",
              lineNo: 2,
            ),
          ),
          MyButton(
              f: () {
                addJob();
                Navigator.pop(context);
              },
              text: "Add New Job")
        ],
      ),
    );
  }
}
