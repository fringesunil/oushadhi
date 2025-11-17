import 'package:flutter/material.dart';
import 'package:oushadhi/Core/colors.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  bool _obscure = true; 

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; 

    return Scaffold(
      backgroundColor: AppColors.bgLightGreen,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -size.width * 0.25,
              left: -size.width * 0.2,
              child: _buildCircle(size.width * 0.6, AppColors.lightAccent.withOpacity(0.25)),
            ),
            Positioned(
              bottom: -size.width * 0.3,
              right: -size.width * 0.2,
              child: _buildCircle(size.width * 0.7, AppColors.primaryGreen.withOpacity(0.08)),
            ),

            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 34),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 12,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.local_florist_rounded,
                              size: 64,
                              color: AppColors.primaryGreen,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Oushadhi',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.green[900],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Natural remedies. Trusted care.',
                          style: TextStyle(color: Colors.green[800]?.withOpacity(0.7)),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 18,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email field (UI)
                          TextFormField(
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              filled: true,
                              fillColor: AppColors.white,
                              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Icon(Icons.email_outlined, color: AppColors.primaryGreen),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _passwordCtrl,
                            obscureText: _obscure,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              filled: true,
                              fillColor: AppColors.white,
                              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Icon(Icons.lock_outline, color: AppColors.primaryGreen),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscure ? Icons.visibility_off : Icons.visibility,
                                  color: AppColors.primaryGreen,
                                ),
                                onPressed: () => setState(() => _obscure = !_obscure),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {}, 
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.primaryGreen,
                                padding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                              ),
                              child: const Text('Forgot password?'),
                            ),
                          ),

                          const SizedBox(height: 6),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {}, 
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryGreen,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 2,
                              ),
                              child: const Text('Sign In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            ),
                          ),

                          const SizedBox(height: 12),

                         
                          Row(
                            children: [
                              const Expanded(child: Divider(thickness: 1)),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text('OR', style: TextStyle(color: Colors.grey[600])),
                              ),
                              const Expanded(child: Divider(thickness: 1)),
                            ],
                          ),

                          const SizedBox(height: 12),

                          
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {}, 
                              icon: const Icon(Icons.g_mobiledata, size: 22),
                              label: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Text('Sign in with Google', style: TextStyle(color: Colors.black87)),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.grey.shade300),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                backgroundColor: Colors.white,
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                onPressed: () {}, 
                                style: TextButton.styleFrom(foregroundColor: AppColors.primaryGreen),
                                child: const Text('Sign up'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.lightAccent.withOpacity(0.16),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: AppColors.primaryGreen),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Trusted herbal remedies and guidance. By signing in you agree to our terms.',
                            style: TextStyle(color: Colors.green[900]?.withOpacity(0.85), fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
