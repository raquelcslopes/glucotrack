import 'package:flutter/material.dart';
import 'package:flutter_app/core/router/routes.dart';
import 'package:flutter_app/core/theme/app_theme.dart';
import 'package:flutter_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:flutter_app/features/user/domain/entities/user.dart';
import 'package:flutter_app/features/user/presentation/provider/user_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class CompleteProfileScreen extends ConsumerStatefulWidget {
  final String? userName;
  final String? profilePic;

  const CompleteProfileScreen({
    super.key,
    required this.userName,
    required this.profilePic,
  });

  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends ConsumerState<CompleteProfileScreen> {
  int currentStep = 1;
  double? imcValue;
  bool? takesInsulin;
  bool termsAccepted = false;
  bool privacyAccepted = false;

  late TextEditingController _heightController;
  late TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  // --------------------------------------- BUILDS -----------------------------------------------------------
  Widget _buildStepsHeader() {
    return Container(
      color: AppTheme.primaryDark,
      padding: EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            'Complete your profile',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: AppTheme.primaryLight),
          ),
          SizedBox(height: 15),
          _buildProgressSteps(),
        ],
      ),
    );
  }

  Widget _buildProgressSteps() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 1; i <= 3; i++) ...[
          _buildSteps(i),
          if (i < 3) _buildStepLine(i),
        ],
      ],
    );
  }

  Widget _buildSteps(int step) {
    final isActive = currentStep >= step;
    final isCompleted = currentStep > step;

    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.white : AppTheme.primaryMedium,
      ),
      child: Center(
        child: isCompleted
            ? const Icon(Icons.check, color: Colors.green)
            : Text(
                '$step',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isActive ? AppTheme.primaryDark : Colors.white,
                ),
              ),
      ),
    );
  }

  Widget _buildStepLine(int step) {
    final isCompleted = currentStep > step;
    return Container(
      width: 48,
      height: 4,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.white : AppTheme.primaryMedium,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            TextFormField(
              initialValue: widget.userName,
              decoration: InputDecoration(
                hintText: 'Your name',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
              ),
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBiometricDataCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.straighten_outlined,
                            size: 16,
                            color: AppTheme.primaryMedium,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Height (cm)',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textColor,
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _heightController,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: '170',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.monitor_weight_outlined,
                            size: 16,
                            color: AppTheme.primaryMedium,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Weight (kg)',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textColor,
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _weightController,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: '70',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),
            _imcCalculation(),
          ],
        ),
      ),
    );
  }

  Widget _takesInsulinCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 190,
            height: 170,
            child: InkWell(
              onTap: () {
                setState(() {
                  takesInsulin = true;
                });
              },
              borderRadius: BorderRadius.circular(12),
              splashColor: const Color.fromARGB(73, 29, 120, 116),
              highlightColor: Colors.transparent,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: takesInsulin == true
                      ? AppTheme.primaryLight
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: takesInsulin == true
                        ? AppTheme.primaryDark
                        : Colors.grey.shade300,
                    width: takesInsulin == true ? 3 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: takesInsulin == true
                          ? const Color.fromARGB(141, 29, 120, 116)
                          : const Color.fromARGB(99, 158, 158, 158),
                      spreadRadius: takesInsulin == true ? 2 : 1,
                      blurRadius: takesInsulin == true ? 8 : 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/5219/5219619.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Yes',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: AppTheme.primaryDark,
                              fontWeight: takesInsulin == true
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                      ),
                      Text(
                        'I use insulin regularly',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: takesInsulin == true
                              ? AppTheme.textColor
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 10),
          SizedBox(
            width: 190,
            height: 170,
            child: InkWell(
              onTap: () {
                setState(() {
                  takesInsulin = false;
                });
              },
              borderRadius: BorderRadius.circular(12),
              splashColor: const Color.fromARGB(73, 29, 120, 116),
              highlightColor: Colors.transparent,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: takesInsulin == false
                      ? AppTheme.primaryLight
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: takesInsulin == false
                        ? AppTheme.primaryDark
                        : Colors.grey.shade300,
                    width: takesInsulin == false ? 3 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: takesInsulin == false
                          ? const Color.fromARGB(141, 29, 120, 116)
                          : const Color.fromARGB(99, 158, 158, 158),
                      spreadRadius: takesInsulin == false ? 2 : 1,
                      blurRadius: takesInsulin == false ? 8 : 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/2001/2001386.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'No',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: AppTheme.primaryDark,
                              fontWeight: takesInsulin == false
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                      ),
                      Text(
                        "I don't use insulin",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: takesInsulin == false
                              ? AppTheme.textColor
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildTermsCard(),
          SizedBox(height: 16),
          _buildCheckboxItem(
            title: 'I accept the Terms & Conditions',
            subtitle: 'I have read and agree to the terms of service',
            isChecked: termsAccepted,
            onTap: () {
              setState(() {
                termsAccepted = !termsAccepted;
              });
            },
          ),
          SizedBox(height: 12),
          _buildCheckboxItem(
            title: 'I accept the Privacy Policy',
            subtitle: 'I understand how my data will be collected and used',
            isChecked: privacyAccepted,
            onTap: () {
              setState(() {
                privacyAccepted = !privacyAccepted;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTermsCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: BoxConstraints(maxHeight: 300),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms of Service',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.primaryDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Last updated: January 2026',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
              SizedBox(height: 16),

              _buildTermsSection(
                '1. Acceptance of Terms',
                'By accessing and using GlucoTrack, you accept and agree to be bound by the terms and provision of this agreement.',
              ),

              _buildTermsSection(
                '2. Use of Service',
                'GlucoTrack is a health tracking application designed to help you monitor your glucose levels. The service is provided "as is" and "as available".',
              ),

              _buildTermsSection(
                '3. Medical Disclaimer',
                'GlucoTrack is not a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of your physician or other qualified health provider.',
              ),

              Text(
                '4. Data Collection',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We collect and process the following data:',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textColor,
                  height: 1.6,
                ),
              ),
              SizedBox(height: 4),
              _buildBulletPoint('Personal information (name, email)'),
              _buildBulletPoint(
                'Health metrics (glucose levels, weight, height)',
              ),
              _buildBulletPoint('Usage data and analytics'),
              SizedBox(height: 12),

              _buildTermsSection(
                '5. Privacy & Security',
                'Your data is encrypted and stored securely. We do not sell your personal information to third parties. Data is used only to improve your experience and provide personalized insights.',
              ),

              Text(
                '6. User Responsibilities',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'You are responsible for:',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textColor,
                  height: 1.6,
                ),
              ),
              SizedBox(height: 4),
              _buildBulletPoint(
                'Maintaining the confidentiality of your account',
              ),
              _buildBulletPoint('Ensuring accuracy of data entered'),
              _buildBulletPoint(
                'Using the app in compliance with applicable laws',
              ),
              SizedBox(height: 12),

              _buildTermsSection(
                '7. Limitation of Liability',
                'GlucoTrack and its affiliates shall not be liable for any indirect, incidental, special, consequential, or punitive damages resulting from your use of the service.',
              ),

              _buildTermsSection(
                '8. Changes to Terms',
                'We reserve the right to modify these terms at any time. We will notify you of any changes by posting the new terms on this page.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermsSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.textColor,
          ),
        ),
        SizedBox(height: 8),
        Text(
          content,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppTheme.textColor,
            height: 1.6,
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 16, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppTheme.textColor),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textColor,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxItem({
    required String title,
    required String subtitle,
    required bool isChecked,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: isChecked
                ? AppTheme.primaryLight.withOpacity(0.3)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isChecked ? AppTheme.primaryDark : Colors.grey.shade300,
              width: isChecked ? 2 : 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isChecked ? AppTheme.primaryDark : Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isChecked
                          ? AppTheme.primaryDark
                          : Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  child: isChecked
                      ? Icon(Icons.check, size: 16, color: Colors.white)
                      : null,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //----------------------------------------------- FUNCTIONS -------------------------------------------------------
  Widget _imcCalculation() {
    final heightText = _heightController.text;
    final weightText = _weightController.text;

    if (heightText.isEmpty || weightText.isEmpty) return SizedBox.shrink();

    final heightCm = double.tryParse(heightText);
    final weightKg = double.tryParse(weightText);

    if (heightCm == null || weightKg == null) return SizedBox.shrink();

    final heightM = heightCm / 100;
    final imc = weightKg / (heightM * heightM);

    imcValue = imc;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(167, 232, 243, 241),
      ),
      child: RichText(
        text: TextSpan(
          text: 'IMC: ',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
          children: [
            TextSpan(
              text: imc.toStringAsFixed(1),
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppTheme.textColor),
            ),
          ],
        ),
      ),
    );
  }

  bool _canContinue() {
    if (currentStep == 1) {
      return _weightController.text.isNotEmpty &&
          _heightController.text.isNotEmpty;
    }
    if (currentStep == 2) {
      return takesInsulin != null;
    }
    if (currentStep == 3) {
      return termsAccepted && privacyAccepted;
    }
    return false;
  }

  void _handleContinue() {
    if (currentStep == 1) {
      if (_canContinue()) {
        setState(() {
          currentStep = 2;
        });
      }
    } else if (currentStep == 2) {
      if (_canContinue()) {
        setState(() {
          currentStep = 3;
        });
      }
    } else if (currentStep == 3) {
      if (_canContinue()) {
        _finish();
      }
    }
  }

  void _finish() async {
    final userNotifier = ref.read(userNotifierProvider.notifier);
    final authState = ref.read(authNotifierProvider);

    if (authState is! AuthAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User not authenticated. Please log in again.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final userId = authState.user.id;

    final height = int.tryParse(_heightController.text) ?? 0;
    final weight = double.tryParse(_weightController.text) ?? 0;

    final user = User(
      id: userId,
      name: widget.userName ?? '',
      height: height,
      weight: weight,
      imc: imcValue ?? 0,
      takesInsulin: takesInsulin ?? false,
      isCompelete: true,
    );

    final isFormValid =
        height > 0 &&
        weight > 0 &&
        takesInsulin != null &&
        termsAccepted &&
        privacyAccepted;

    if (!termsAccepted || !privacyAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please accept the Terms & Conditions and Privacy Policy.',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (isFormValid) {
      try {
        await userNotifier.createUser(user);
        Navigator.of(context).pushNamed(AppRoutes.home);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving profile: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      _buildStepsHeader(),

                      //STEP 1
                      if (currentStep == 1) ...[
                        SizedBox(height: 30),
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: AppTheme.primaryDark,
                          backgroundImage: NetworkImage(
                            widget.profilePic ??
                                "https://img.icons8.com/ios/50/FFFFFF/user-male-circle--v1.png",
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Hey! Let's start",
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(color: AppTheme.black),
                        ),
                        Text(
                          'Tell us a little about yourself',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(height: 20),
                        _buildInfoCard(),
                        _buildBiometricDataCard(),
                      ],

                      // STEP 2
                      if (currentStep == 2) ...[
                        SizedBox(height: 30),
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: AppTheme.primaryDark,
                          child: ClipOval(
                            child: Image.network(
                              'https://cdn-icons-png.flaticon.com/512/5219/5219619.png',
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Do you take insulin?',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(color: AppTheme.black),
                        ),
                        Text(
                          'This helps us personalize your care',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppTheme.textColor),
                        ),
                        SizedBox(height: 20),
                        _takesInsulinCards(),
                      ],

                      //STEP 3
                      if (currentStep == 3) ...[
                        SizedBox(height: 30),
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: AppTheme.primaryDark,
                          child: ClipOval(
                            child: Image.network(
                              'https://cdn-icons-png.flaticon.com/512/4514/4514821.png',
                              width: 70,
                              height: 60,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Terms & Conditions',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(color: AppTheme.black),
                        ),
                        Text(
                          'Please review and accept to continue',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppTheme.textColor),
                        ),
                        SizedBox(height: 20),
                        _buildTermsAndConditions(),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            //BUTTONS
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (currentStep > 1) ...[
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentStep -= 1;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        backgroundColor: const Color.fromARGB(
                          158,
                          164,
                          206,
                          197,
                        ),
                        foregroundColor: AppTheme.primaryDark,
                      ),
                      child: Text('Back'),
                    ),
                    SizedBox(width: 10),
                  ],

                  ElevatedButton(
                    onPressed: _canContinue() ? _handleContinue : null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          currentStep == 3 ? 'Finish' : 'Continue',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: AppTheme.primaryLight,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.arrow_forward_rounded),
                      ],
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
