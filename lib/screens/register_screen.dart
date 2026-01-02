import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final PageController _pageController = PageController();
  final AuthService _auth = AuthService();
  final FirestoreService _fs = FirestoreService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();
  final _partnerNameController = TextEditingController();
  final _anniversaryController = TextEditingController();

  int _currentPage = 0;
  bool _isLoading = false;

  void _handleRegister() async {
    setState(() => _isLoading = true);

    var user = await _auth.registerWithEmail(
        _emailController.text.trim(),
        _passwordController.text.trim()
    );

    if (user != null) {
      await _fs.saveUserProfile(
        _userNameController.text.trim(),
        _partnerNameController.text.trim(),
        _anniversaryController.text.trim(),
      );
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
      }
    } else {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Registration failed. Please check your details."))
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (_currentPage > 0) {
              _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                children: [
                  Expanded(child: _buildProgressIndicator(0)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildProgressIndicator(1)),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => setState(() => _currentPage = index),
                children: [
                  _buildStep1(context),
                  _buildStep2(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(int index) {
    return Container(
      height: 6,
      decoration: BoxDecoration(
        color: _currentPage >= index ? const Color(0xFFEF4444) : const Color(0xFF333333),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _buildStep1(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Step 1/2", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 10),
          const Text("Create Account", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          const Text("Email Address", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(controller: _emailController, decoration: const InputDecoration(hintText: "example@mail.com")),
          const SizedBox(height: 25),
          const Text("Password", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(hintText: "Min. 6 characters")),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF333333)),
              onPressed: () {
                if (_emailController.text.isNotEmpty && _passwordController.text.length >= 6) {
                  _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                }
              },
              child: const Text("Next", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Step 2/2", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 10),
          const Text("Personal Details", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          const Text("Your Name", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(controller: _userNameController, decoration: const InputDecoration(hintText: "Enter your name")),
          const SizedBox(height: 25),
          const Text("Partner's Name", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(controller: _partnerNameController, decoration: const InputDecoration(hintText: "Enter partner's name")),
          const SizedBox(height: 25),
          const Text("Anniversary Date", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _anniversaryController,
            decoration: const InputDecoration(
              hintText: "dd.mm.yyyy",
              suffixIcon: Icon(Icons.calendar_today, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEF4444)),
              onPressed: _isLoading ? null : _handleRegister,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Get Started", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}