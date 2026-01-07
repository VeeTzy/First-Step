import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  final String userName;
  final String userEmail;

  const EditProfileScreen({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _newEmailController;
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isEditingEmail = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userName);
    _emailController = TextEditingController(text: widget.userEmail);
    _newEmailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _newEmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: AppConstants.primaryColor,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: AppConstants.primaryColor,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    // Handle profile picture change
                  },
                  child: const Text('Change'),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppConstants.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  hintText: 'Full Name',
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppConstants.textPrimaryColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isEditingEmail = !_isEditingEmail;
                        });
                      },
                      child: Text(_isEditingEmail ? 'Cancel' : 'Edit'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (!_isEditingEmail)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadiusMedium,
                      ),
                    ),
                    child: Text(
                      widget.userEmail,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                if (_isEditingEmail) ...[
                  CustomTextField(
                    hintText: 'Current Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your current email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: 'New Email',
                    controller: _newEmailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your new email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ],
                const SizedBox(height: 24),
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppConstants.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  hintText: 'Password',
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (_isEditingEmail && (value == null || value.isEmpty)) {
                      return 'Password required to change email';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: _isEditingEmail ? 'Done' : 'Proceed',
                  onPressed: _handleSave,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Back',
                  onPressed: () => Navigator.pop(context),
                  backgroundColor: AppConstants.textSecondaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}