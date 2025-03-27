import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techfluence/data/data.dart';
import 'package:techfluence/pages/jobdetails.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs Page'),
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
            return const Center(
              child: Text('No Jobs'),
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
                      builder: (context) {
                        return JobDetails(
                          job: job,
                        );
                      },
                    ),
                  );
                },
                //TODO chanage this
                child: ListTile(
                  //name description status date
                  title: Text(job['name']),
                  subtitle: Text(job['description']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
