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
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    child: const Text(
                      "Job name",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 225,
                    width: MediaQuery.of(context).size.width / 2,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Job Description',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  'https://t4.ftcdn.net/jpg/00/44/71/01/360_F_44710125_h5BZVCNCLcvnCVylyxhw9oHfgYTBqg6O.jpg', // Replace with the actual image URL
                  height: 300,
                  width: MediaQuery.of(context).size.width / 3,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: 3,
              itemBuilder: (context, index) {
                final machineNames = ['Machine 1', 'Machine 2', 'Machine 3'];
                final colors = [
                  Colors.amber[600],
                  Colors.amber[500],
                  Colors.amber[100]
                ];
                return Container(
                  margin: const EdgeInsets.all(8),
                  height: 50,
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(machineNames[index]),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
