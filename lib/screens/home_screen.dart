import 'package:flutter/material.dart';
import 'package:foodbar/screens/scanner_screen.dart';
import 'package:foodbar/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Foodbar",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /**
             * Hero
             */
            const Row(
              children: [
                Image(
                  image: AssetImage("assets/logo.png"),
                  width: 60,
                  height: 60,
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Foodbar App",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                        "Pastikan makanan dalam kemasan\nbersertifikasi halal asli."),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),

            /**
             * Quick Start
             */
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade300,
              ),
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
                children: [
                  const Text(
                    "Quick Start",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /**
                       * Scan Barcode
                       */
                      TextButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ScannerScreen(),
                            ),
                          ),
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 100,
                          child: const Column(
                            children: [
                              Icon(
                                Icons.qr_code_scanner,
                                color: Colors.white,
                              ),
                              Text(
                                "Scan Barcode",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      /**
                       * Search
                       */
                      TextButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchScreen(),
                            ),
                          )
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 100,
                          child: const Column(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              Text(
                                "Search",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        constraints: BoxConstraints.loose(const Size.fromHeight(50)),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          color: Colors.green,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -20,
              child: IconButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScannerScreen(),
                    ),
                  ),
                },
                icon: const Icon(
                  Icons.qr_code_scanner,
                ),
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Colors.green.shade100),
                  foregroundColor: const WidgetStatePropertyAll(Colors.green),
                  minimumSize: const WidgetStatePropertyAll(Size(100, 60)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
