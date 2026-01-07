import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/constants.dart';
import 'edit_profile_screen.dart';

class MyDataScreen extends StatefulWidget {
  final String userName;
  final String userEmail;

  const MyDataScreen({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  @override
  State<MyDataScreen> createState() => _MyDataScreenState();
}

class _MyDataScreenState extends State<MyDataScreen> {
  DateTime? _dateOfBirth;
  int? _age;

  void _calculateAge() {
    if (_dateOfBirth != null) {
      final now = DateTime.now();
      int age = now.year - _dateOfBirth!.year;
      if (now.month < _dateOfBirth!.month ||
          (now.month == _dateOfBirth!.month && now.day < _dateOfBirth!.day)) {
        age--;
      }
      setState(() {
        _age = age;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dateOfBirth) {
      setState(() {
        _dateOfBirth = picked;
      });
      _calculateAge();
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'dd/MM/yyyy';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  void _navigateToEditProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          userName: widget.userName,
          userEmail: widget.userEmail,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('My Data'),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundColor: AppConstants.primaryColor,
                child: Icon(
                  Icons.person,
                  size: 70,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.userName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Beginner',
                  style: TextStyle(
                    color: AppConstants.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.paddingMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppConstants.textSecondaryColor,
                            ),
                          ),
                          TextButton(
                            onPressed: _navigateToEditProfile,
                            child: const Text('Edit'),
                          ),
                        ],
                      ),
                      Text(
                        widget.userEmail,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppConstants.textPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.paddingMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _age != null ? 'Age: $_age' : 'Age',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppConstants.textSecondaryColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () => _selectDate(context),
                            child: Text(_dateOfBirth == null ? 'Add' : 'Edit'),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatDate(_dateOfBirth),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: _dateOfBirth == null
                                      ? AppConstants.textSecondaryColor
                                      : AppConstants.textPrimaryColor,
                                ),
                              ),
                              const Icon(
                                Icons.calendar_today,
                                color: AppConstants.primaryColor,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.paddingMedium),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppConstants.textSecondaryColor,
                        ),
                      ),
                      TextButton(
                        onPressed: _navigateToEditProfile,
                        child: const Text('Change'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.textSecondaryColor,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}