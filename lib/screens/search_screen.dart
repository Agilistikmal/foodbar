import 'package:flutter/material.dart';
import 'package:foodbar/model/food_model.dart';
import 'package:foodbar/screens/scanner_screen.dart';
import 'package:foodbar/service/food_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();

  List<HalalData> halalDataList = [];
  bool loading = false;
  String error = "";

  Future<void> handleSearch() async {
    setState(() {
      loading = true;
      error = "";
    });
    final result = await searchHalalFood(_searchController.text);
    setState(() {
      halalDataList = result;
      loading = false;
      error = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search",
          style: TextStyle(fontWeight: FontWeight.bold),
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
             * Search Bar
             */
            Form(
              key: _formKey,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade300,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text("Search"),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        controller: _searchController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Masukkan kata kunci";
                          } else if (value.length < 3) {
                            return "Masukkan minimal 3 kata kunci";
                          }
                          return null;
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () => {
                        if (_formKey.currentState!.validate()) {handleSearch()}
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
              ),
            ),

            /**
             * Result
             */
            const SizedBox(
              height: 8,
            ),
            loading
                ? const LinearProgressIndicator(
                    color: Colors.green,
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: halalDataList.length,
                      itemBuilder: (context, index) {
                        final food = halalDataList[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                food.namaProduk,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Diproduksi oleh ${food.namaProdusen}",
                                style: const TextStyle(fontSize: 11),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  /**
                                   * Certificate Number
                                   */
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.badge,
                                            size: 16,
                                            color: Colors.green,
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            food.nomorSertifikat,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  /**
                                   * Halal Logo
                                   */
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    child: const Image(
                                      image: AssetImage(
                                        "assets/logo_halal.png",
                                      ),
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ],
                              ),

                              /**
                               * Expired At
                               */
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.green,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "Berlaku hingga ${food.expireDate}",
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              )
                            ],
                          ),
                        );
                      },
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
