import 'package:flutter/material.dart';
import '../models/routine_model.dart';
import '../utils/constants.dart';
import 'my_data_screen.dart';

class MainMenuScreen extends StatelessWidget {
  final String userName;

  const MainMenuScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final sampleRoutines = [
      RoutineModel(
        id: '1',
        name: 'Routine Name',
        description: 'Description...',
        time: '20:01',
        creator: 'Creator',
      ),
      RoutineModel(
        id: '2',
        name: 'Routine Name',
        description: 'Description...',
        time: '11:50',
        creator: 'Creator',
      ),
      RoutineModel(
        id: '3',
        name: 'Routine Name',
        description: 'Description...',
        time: '00:00',
        creator: 'Creator',
      ),
    ];

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('Main Menu'),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingLarge),
              color: AppConstants.primaryColor,
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: AppConstants.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Beginner',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(AppConstants.paddingMedium),
                itemCount: sampleRoutines.length,
                itemBuilder: (context, index) {
                  final routine = sampleRoutines[index];
                  return Card(
                    margin: const EdgeInsets.only(
                      bottom: AppConstants.paddingMedium,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.paddingMedium),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                routine.name,
                                style: AppConstants.subheadingStyle,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppConstants.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  routine.time,
                                  style: const TextStyle(
                                    color: AppConstants.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            routine.description,
                            style: AppConstants.bodyStyle,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '(${routine.creator})',
                            style: AppConstants.bodyStyle.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyDataScreen(
                            userName: 'Arthur Devoe',
                            userEmail: 'Arthur123@gmail.com',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryColor,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('My Data'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.textSecondaryColor,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('EXIT'),
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