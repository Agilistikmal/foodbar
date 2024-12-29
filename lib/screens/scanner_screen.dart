import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodbar/model/food_model.dart';
import 'package:foodbar/model/response_model.dart';
import 'package:foodbar/screens/food_detail_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen>
    with WidgetsBindingObserver {
  String errorMessage = "";
  bool loading = false;
  bool scanned = false;

  Future<void> _handleBarcode(String barcode) async {
    setState(() {
      errorMessage = "";
      loading = true;
      scanned = true;
    });

    if (int.tryParse(barcode) == null) {
      setState(() {
        errorMessage = "Invalid barcode";
        loading = false;
      });
      return;
    }

    final rawResponse = await http.get(
      Uri.parse("https://foodbar-api.safatanc.com/product/$barcode"),
    );

    final Map parseResponse = json.decode(rawResponse.body);
    final response = APIResponse.fromJson(parseResponse);

    if (response.code == 200) {
      final food = Food.fromJson(response.data);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FoodDetailScreen(
            food: food,
          ),
        ),
      );
    } else {
      setState(() {
        errorMessage = "Barcode $barcode ${response.message}";
        loading = false;
      });
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Foodbar",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Center(
              child: loading == true
                  ? const Text("Loading...")
                  : errorMessage == ""
                      ? const Text(
                          "Scan barcode untuk melihat sertifikat halal",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      : const SizedBox(),
            ),
          ),
          scanned == false
              ? Expanded(
                  child: MobileScanner(
                    onDetect: (barcodes) {
                      _handleBarcode(barcodes.barcodes.first.rawValue!);
                    },
                    scanWindow: Rect.fromCenter(
                      center: MediaQuery.sizeOf(context).center(Offset.zero),
                      width: 500,
                      height: 200,
                    ),
                    fit: BoxFit.contain,
                  ),
                )
              : Column(
                  children: [
                    errorMessage != ""
                        ? Text(
                            "Error: $errorMessage",
                            style: const TextStyle(color: Colors.red),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 24,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          errorMessage = "";
                          scanned = false;
                        });
                      },
                      style: const ButtonStyle(
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.green)),
                      child: const Text("Coba Lagi"),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text("Atau"),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          errorMessage = "";
                          scanned = false;
                        });
                      },
                      style: const ButtonStyle(
                        foregroundColor: WidgetStatePropertyAll(Colors.green),
                      ),
                      child: const Text("Gunakan Pencarian"),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
