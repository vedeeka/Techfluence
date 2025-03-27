import 'package:flutter/material.dart';

class JobDetails extends StatefulWidget {
  const JobDetails({super.key});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job name'),
      ),
      body: Padding(padding:EdgeInsets.all(14),child:Text('Job description'),),
    );
  }
}