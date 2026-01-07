import 'package:flutter/material.dart';
import '../models/routine_model.dart';
import '../utils/constants.dart';
import '../widgets/routine_card.dart';

class DeleteRoutineScreen extends StatefulWidget {
  final List<RoutineModel> routines;

  const DeleteRoutineScreen({super.key, required this.routines});

  @override
  State<DeleteRoutineScreen> createState() => _DeleteRoutineScreenState();
}

class _DeleteRoutineScreenState extends State<DeleteRoutineScreen> {
  late List<RoutineModel> routines;
  final Set<String> _selectedRoutines = {};

  @override
  void initState() {
    super.initState();
    routines = List.from(widget.routines);
  }

  void _deleteSelectedRoutines() {
    if (_selectedRoutines.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select routines to delete'),
          backgroundColor: AppConstants.deleteColor,
        ),
      );
      return;
    }

    setState(() {
      routines.removeWhere((routine) => _selectedRoutines.contains(routine.id));
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_selectedRoutines.length} routine(s) deleted successfully'),
        backgroundColor: AppConstants.primaryColor,
      ),
    );

    _selectedRoutines.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('Delete Routine'),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingLarge),
              color: Colors.red.shade50,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome,\nArthur!!! What\'s your\nplan today?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.textPrimaryColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Pick routine to Delete !!!',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppConstants.deleteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: routines.isEmpty
                  ? const Center(
                      child: Text(
                        'No routines available',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppConstants.textSecondaryColor,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(AppConstants.paddingMedium),
                      itemCount: routines.length,
                      itemBuilder: (context, index) {
                        final routine = routines[index];
                        return RoutineCard(
                          routine: routine,
                          showCheckbox: true,
                          isSelected: _selectedRoutines.contains(routine.id),
                          onCheckboxChanged: (value) {
                            setState(() {
                              if (value == true) {
                                _selectedRoutines.add(routine.id);
                              } else {
                                _selectedRoutines.remove(routine.id);
                              }
                            });
                          },
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, routines),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.textSecondaryColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 50),
                      ),
                      child: const Text('Back'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _deleteSelectedRoutines,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.deleteColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 50),
                      ),
                      child: const Text('Delete Selected'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}