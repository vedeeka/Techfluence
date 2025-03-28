import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techfluence/component/dashboard%20components/current_jobs.dart';
import 'package:techfluence/data/data.dart';
import 'package:techfluence/data/themes.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maintenance Priority'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(backendBaseString)
            .doc(globalEmail)
            .collection('inventory')
            .orderBy('rank', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var docs = snapshot.data!.docs;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, childAspectRatio: 5),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  var d = docs[index].data();
                  d['id'] = docs[index].id;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MachineryDetailPage(machinery: d);
                      },
                    ),
                  );
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    boxShadow: const [BoxShadow(color: lightGrey)],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                          docs[index]['rank'] >= 15
                              ? Icons.running_with_errors_rounded
                              : docs[index]['rank'] >= 10
                                  ? Icons.error
                                  : docs[index]['rank'] >= 5
                                      ? Icons.error_outline
                                      : Icons.check,
                          color: docs[index]['rank'] >= 15
                              ? Colors.red
                              : docs[index]['rank'] >= 10
                                  ? Colors.orange
                                  : docs[index]['rank'] >= 5
                                      ? Colors.yellow
                                      : Colors.green),
                      const SizedBox(width: 10),
                      Text(docs[index]['name'],
                          style: const TextStyle(fontSize: 18)),
                      const Spacer(),
                      Text(
                        docs[index]['rank'] >= 15
                            ? 'Urgent'
                            : docs[index]['rank'] >= 10
                                ? 'High'
                                : docs[index]['rank'] >= 5
                                    ? 'Medium'
                                    : 'Low',
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
