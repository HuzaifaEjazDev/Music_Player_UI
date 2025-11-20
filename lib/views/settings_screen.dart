import 'package:flutter/material.dart';
import '../../core/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        children: [
          _buildSectionHeader(context, 'Account'),
          _buildSettingItem(context, 'Audio Quality', 'High'),
          _buildSettingItem(context, 'Notifications', 'On'),

          const SizedBox(height: 20),
          _buildSectionHeader(context, 'App'),
          _buildSettingItem(context, 'Theme', 'Dark Mode'),
          _buildSettingItem(context, 'Language', 'English'),

          const SizedBox(height: 20),
          _buildSectionHeader(context, 'About'),
          _buildSettingItem(context, 'Version', '1.0.0'),
          _buildSettingItem(context, 'Terms of Service', ''),
          _buildSettingItem(context, 'Privacy Policy', ''),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, String title, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: const TextStyle(color: Colors.grey)),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
      onTap: () {},
    );
  }
}
