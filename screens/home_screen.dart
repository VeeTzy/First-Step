import 'package:flutter/material.dart';
import '../models/routine_model.dart';
import '../utils/constants.dart';
import '../widgets/routine_card.dart';
import 'edit_mode_screen.dart';
import 'main_menu_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({super.key, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<RoutineModel> routines = [
    RoutineModel(
      id: '1',
      name: 'Morning Activity',
      description: 'Joging 10-20 Menit',
      time: '07:30',
      activities: [],
    ),
    RoutineModel(
      id: '2',
      name: 'Morning Activity1',
      description: '',
      time: '09:00',
      activities: [
        'Push-Up 12 x 8',
        'Sit-Up 10 x 8',
        'Squat 12 x 8',
      ],
    ),
  ];

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _navigateToEdit() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditModeScreen(routines: routines),
      ),
    );

    if (result != null && result is List<RoutineModel>) {
      setState(() {
        routines = result;
      });
    }
  }

  void _navigateToMainMenu() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainMenuScreen(userName: 'Arthur Devoe'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: AppConstants.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: _navigateToMainMenu,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingLarge),
              color: AppConstants.primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome,\n${widget.userName}!!! What\'s your\nplan today?',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppConstants.borderRadiusMedium,
                              ),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: _navigateToEdit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppConstants.primaryColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppConstants.borderRadiusMedium,
                            ),
                          ),
                        ),
                        child: const Text('Edit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(AppConstants.paddingMedium),
                itemCount: routines.length,
                itemBuilder: (context, index) {
                  return RoutineCard(routine: routines[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}