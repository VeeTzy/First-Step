import 'package:flutter/material.dart';
import '../models/routine_model.dart';
import '../utils/constants.dart';
import '../widgets/routine_card.dart';
import 'add_routine_screen.dart';
import 'delete_routine_screen.dart';

class EditModeScreen extends StatefulWidget {
  final List<RoutineModel> routines;

  const EditModeScreen({super.key, required this.routines});

  @override
  State<EditModeScreen> createState() => _EditModeScreenState();
}

class _EditModeScreenState extends State<EditModeScreen> {
  late List<RoutineModel> routines;

  @override
  void initState() {
    super.initState();
    routines = List.from(widget.routines);
  }

  void _addNewRoutine() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddRoutineScreen(),
      ),
    );

    if (result != null && result is RoutineModel) {
      setState(() {
        routines.add(result);
      });
      
      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('New Routine has been added!!!'),
            backgroundColor: AppConstants.primaryColor,
          ),
        );
      }
    }
  }

  void _deleteRoutine() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeleteRoutineScreen(routines: routines),
      ),
    );

    if (result != null && result is List<RoutineModel>) {
      setState(() {
        routines = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('Edit Mode'),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingLarge),
              color: Colors.amber.shade100,
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
                    'You\'re Now in Edit Mode.\nPlease Choose your Action!!!',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppConstants.textSecondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _addNewRoutine,
                      icon: const Icon(Icons.add),
                      label: const Text('Add New'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _deleteRoutine,
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.deleteColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingMedium,
                ),
                itemCount: routines.length,
                itemBuilder: (context, index) {
                  return RoutineCard(routine: routines[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, routines);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.textSecondaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}