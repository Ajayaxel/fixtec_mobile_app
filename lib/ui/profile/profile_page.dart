import 'package:flutter/material.dart';
import 'package:fixteck/const/fixtec_btn.dart';
import 'package:fixteck/bloc/profile_bloc.dart';
import 'package:fixteck/bloc/profile_event.dart';
import 'package:fixteck/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixteck/ui/widgets/global_loading_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const Color _backgroundColor = Color(0xFFF5F6FB);
  static const Color _buttonColor = Color(0xFF003B40); // Approximated dark teal

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch profile data when screen loads
    context.read<ProfileBloc>().add(const FetchProfile());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
        ),
        title: Text(
          'Profile',
          style: textTheme.titleMedium?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSuccess) {
              final customer = state.response.data.customer;
              _nameController.text = customer.name;
              _emailController.text = customer.email;
              _phoneController.text = customer.phone;
              _addressController.text = customer.address;
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading || state is ProfileInitial) {
              return const GlobalLoadingWidget();
            }
            
            if (state is ProfileFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProfileBloc>().add(const FetchProfile());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Edit profile',
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildLabel(textTheme, 'Full name'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _nameController,
                          enabled: true,
                        ),
                        const SizedBox(height: 16),
                        _buildLabel(textTheme, 'Email'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _emailController,
                          enabled: true,
                        ),
                        const SizedBox(height: 16),
                        _buildLabel(textTheme, 'Phone number'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _phoneController,
                          enabled: true,
                        ),
                        const SizedBox(height: 16),
                        _buildLabel(textTheme, 'Address'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _addressController,
                          enabled: true,
                        ),
                        if (state is ProfileSuccess) ...[
                          const SizedBox(height: 16),
                          _buildLabel(textTheme, 'Status'),
                          const SizedBox(height: 8),
                          _buildTextField(
                            initialValue: state.response.data.customer.status ? 'Active' : 'Inactive',
                            enabled: false,
                          ),
                          const SizedBox(height: 16),
                          _buildLabel(textTheme, 'Member since'),
                          const SizedBox(height: 8),
                          _buildTextField(
                            initialValue: state.response.data.customer.formattedCreatedAt,
                            enabled: false,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FixtecBtn(
                    onPressed: () {},
                    bgColor: _buttonColor,
                    textColor: Colors.white,
                    child: Text(
                      'Save information',
                      style: textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLabel(TextTheme textTheme, String label) {
    return Text(
      label,
      style: textTheme.bodyMedium?.copyWith(
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTextField({
    TextEditingController? controller,
    String? initialValue,
    bool enabled = true,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: enabled ? Colors.transparent : Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        initialValue: controller == null ? initialValue : null,
        enabled: enabled,
        textAlign: textAlign,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: enabled ? const Color(0xFFF5F6FB) : Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black26),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
