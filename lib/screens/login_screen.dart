import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodbar/model/response_model.dart';
import 'package:foodbar/screens/home_screen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  bool loading = true;
  String error = "";
  String success = "";

  Future<void> _sendOTP(String phone) async {
    setState(() {
      loading = true;
      error = "";
      success = "";
    });

    final rawResponse = await http.post(
      Uri.parse(
        "https://foodbar-api.safatanc.com/otp/send/$phone",
      ),
    );

    final Map parseResponse = json.decode(rawResponse.body);
    final response = APIResponse.fromJson(parseResponse);

    if (response.code != 200) {
      setState(() {
        error = response.message;
      });
    } else {
      setState(() {
        success = "Berhasil mengirim OTP ke $phone";
      });
    }

    setState(() {
      loading = false;
    });
  }

  Future<void> _verifyOTP(String phone, String otp) async {
    setState(() {
      loading = true;
      error = "";
      success = "";
    });

    final rawResponse = await http.post(
      Uri.parse(
        "https://foodbar-api.safatanc.com/otp/verify",
      ),
      body: jsonEncode(
        {
          "phone": phone,
          "otp": otp,
        },
      ),
    );

    final Map parseResponse = json.decode(rawResponse.body);
    final response = APIResponse.fromJson(parseResponse);

    if (response.code != 200) {
      setState(() {
        error = response.message;
      });
    } else {
      setState(() {
        success = "Berhasil verifikasi OTP";
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /**
               * Hero
               */
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/logo.png"),
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Foodbar App",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),

              /**
               * Form Login
               */
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                width: MediaQuery.sizeOf(context).width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    const Text(
                      "LOGIN",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                        color: Colors.green,
                      ),
                    ),
                    success != ""
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.green,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 8,
                            ),
                            margin: const EdgeInsets.only(bottom: 8, top: 8),
                            child: Text(
                              success,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    error != ""
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 8,
                            ),
                            margin: const EdgeInsets.only(bottom: 8, top: 8),
                            child: Text(
                              error,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          /**
                           * Phone Input
                           */
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: "Nomor HP",
                                    ),
                                    keyboardType: TextInputType.phone,
                                    controller: phoneController,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      _sendOTP(phoneController.text),
                                  icon: const Icon(
                                    Icons.send_and_archive_rounded,
                                    color: Colors.green,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),

                          /**
                           * OTP Input
                           */
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: "Kode OTP",
                              ),
                              controller: otpController,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          /**
                           * Button Verify
                           */
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.green,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            child: TextButton(
                              onPressed: () => _verifyOTP(
                                phoneController.text,
                                otpController.text,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
