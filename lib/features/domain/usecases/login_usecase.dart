import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8080/auth/login/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': _usernameController.text.trim(),
        'password': _passwordController.text.trim(),
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Login failed');
    }
  }

  Future<void> _onLoginPressed() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _login();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('로그인 성공')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 실패: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: '아이디',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? '아이디를 입력하세요' : null,
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    border: const OutlineInputBorder(),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '비밀번호를 입력하세요';
                    }
                    if (value.length < 4) {
                      return '비밀번호는 4자 이상이어야 합니다';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: _isLoading ? null : _onLoginPressed,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('로그인'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
