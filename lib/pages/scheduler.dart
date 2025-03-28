import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techfluence/data/data.dart';

// Define AppTheme with primaryColor
class AppTheme {
  static const Color primaryColor =
      Color.fromARGB(255, 0, 0, 0); // Example color
}

Widget _buildSidebarItem(IconData icon, String label, {bool isActive = false}) {
  return ListTile(
    leading: Icon(
      icon,
      color: isActive ? const Color.fromARGB(255, 120, 122, 154) : Colors.grey,
    ),
    title: Text(
      label,
      style: TextStyle(
        color: isActive ? AppTheme.primaryColor : Colors.grey[700],
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
      ),
    ),
    onTap: () {},
    selected: isActive,
  );
}

class SchedulerPage extends StatefulWidget {
  const SchedulerPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SchedulerPageState createState() => _SchedulerPageState();
}

class _SchedulerPageState extends State<SchedulerPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _equipmentController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;

  void _addMaintenanceTask() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      final newTask = MaintenanceTask(
        equipment: _equipmentController.text.trim(),
        description: _descriptionController.text.trim(),
        scheduledDate: _selectedDate!,
      );

      setState(() {
        maintenanceTasks.add(newTask);
        maintenanceTasks
            .sort((a, b) => a.scheduledDate.compareTo(b.scheduledDate));
      });

      // Reset form
      _equipmentController.clear();
      _descriptionController.clear();
      _selectedDate = null;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Maintenance Task Added'),
          backgroundColor: Colors.green[600],
        ),
      );
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue[700]!,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _deleteTask(MaintenanceTask task) {
    setState(() {
      maintenanceTasks.remove(task);
    });
  }

  void _updateTaskStatus(MaintenanceTask task, MaintenanceStatus newStatus) {
    setState(() {
      task.status = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate to the previous page
          },
        ),
        title: const Text('Maintenance Scheduler'),
        backgroundColor: const Color.fromARGB(255, 235, 230, 230),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Maintenance Scheduler'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: MediaQuery.of(context).size.width / 5.1,
            color: const Color.fromARGB(255, 250, 250, 250),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Equipment Hub',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                _buildSidebarItem(Icons.dashboard, 'Dashboard', isActive: true),
                _buildSidebarItem(Icons.schedule, 'Maintenance'),
                _buildSidebarItem(Icons.analytics, 'Ongoing Jobs'),
                _buildSidebarItem(Icons.person, 'Scheduler'),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: SafeArea(
              child: Column(
                children: [
                  // Task Input Section
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                      border: Border.all(color: Colors.blue.shade100, width: 1),
                    ),
                    margin: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Equipment Name Field
                          TextFormField(
                            controller: _equipmentController,
                            decoration: InputDecoration(
                              labelText: "Equipment Name",
                              prefixIcon: const Icon(Icons.construction),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter equipment name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Description Field
                          TextFormField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              labelText: "Maintenance Description",
                              prefixIcon: const Icon(Icons.description),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 16),

                          // Date Selection
                          Row(
                            children: [
                              Expanded(
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child: Text(
                                    _selectedDate == null
                                        ? "Select Maintenance Date"
                                        : "Scheduled: ${DateFormat('dd MMM yyyy').format(_selectedDate!)}",
                                    key: ValueKey(_selectedDate),
                                    style: TextStyle(
                                      color: _selectedDate == null
                                          ? Colors.grey[600]
                                          : Colors.blue[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () => _selectDate(context),
                                icon: const Icon(Icons.calendar_today),
                                label: const Text("Choose Date"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[700],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Add Task Button
                          TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 300),
                            tween: Tween(begin: 0.9, end: 1.0),
                            builder: (context, scale, child) {
                              return Transform.scale(
                                scale: scale,
                                child: ElevatedButton(
                                  onPressed: _addMaintenanceTask,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                        255, 144, 206, 229),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    "Schedule Maintenance Task",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Tasks List Section
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.easeOutQuad,
                      switchOutCurve: Curves.easeInQuad,
                      child: maintenanceTasks.isEmpty
                          ? _buildEmptyState()
                          : ListView.builder(
                              key: const ValueKey('task-list'),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: maintenanceTasks.length,
                              itemBuilder: (context, index) {
                                final task = maintenanceTasks[index];
                                return AnimatedOpacity(
                                  duration: const Duration(milliseconds: 300),
                                  opacity: 1.0,
                                  child: _buildTaskCard(task, index),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.event_note_outlined,
              size: 120,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            const SizedBox(height: 24),
            Text(
              'No Maintenance Tasks',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Get started by adding your first maintenance task. Track and manage your equipment maintenance with ease.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement add maintenance task action
                // Navigator.push or show bottom sheet to add task
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Maintenance Task'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue[600],
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(MaintenanceTask task, int index) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.equipment,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildStatusChip(task.status),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              task.description,
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 16, color: Colors.blue[700]),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('dd MMM yyyy').format(task.scheduledDate),
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _editTask(task),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteTask(task),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(MaintenanceStatus status) {
    Color chipColor;
    switch (status) {
      case MaintenanceStatus.scheduled:
        chipColor = Colors.blue.shade100;
        break;
      case MaintenanceStatus.inProgress:
        chipColor = Colors.orange.shade100;
        break;
      case MaintenanceStatus.completed:
        chipColor = Colors.green.shade100;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.toString().split('.').last.toUpperCase(),
        style: TextStyle(
          color: chipColor == Colors.blue.shade100
              ? Colors.blue.shade800
              : chipColor == Colors.orange.shade100
                  ? Colors.orange.shade800
                  : Colors.green.shade800,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _editTask(MaintenanceTask task) {
    // Open a bottom sheet for editing
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Edit Maintenance Task',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: task.equipment),
              decoration: const InputDecoration(
                labelText: 'Equipment Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                task.equipment = value;
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: TextEditingController(text: task.description),
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                task.description = value;
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<MaintenanceStatus>(
              value: task.status,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
              items: MaintenanceStatus.values
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status.toString().split('.').last),
                      ))
                  .toList(),
              onChanged: (newStatus) {
                if (newStatus != null) {
                  _updateTaskStatus(task, newStatus);
                }
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

// Maintenance Task Model
class MaintenanceTask {
  String equipment;
  String description;
  DateTime scheduledDate;
  MaintenanceStatus status;

  MaintenanceTask({
    required this.equipment,
    required this.description,
    required this.scheduledDate,
    this.status = MaintenanceStatus.scheduled,
  });
}

// Maintenance Status Enum
enum MaintenanceStatus { scheduled, inProgress, completed }
