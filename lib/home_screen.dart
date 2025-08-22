import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> featuredImages = [
      'https://picsum.photos/400/200?random=1',
      'https://picsum.photos/400/200?random=2',
      'https://picsum.photos/400/200?random=3',
    ];

    final List<Map<String, String>> products = [
      {"title": "Product 1", "image": "https://picsum.photos/200?random=4"},
      {"title": "Product 2", "image": "https://picsum.photos/200?random=5"},
      {"title": "Product 3", "image": "https://picsum.photos/200?random=6"},
      {"title": "Product 4", "image": "https://picsum.photos/200?random=7"},
    ];

    final List<Map<String, String>> offers = List.generate(
      5,
      (i) => {
        "title": "Offer ${i + 1}",
        "image": "https://picsum.photos/100?random=${i + 10}",
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('ourProducts'.tr()),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              final newLocale = context.locale == const Locale('en', 'US')
                  ? const Locale('ar', 'EG')
                  : const Locale('en', 'US');
              EasyLocalization.of(context)!.setLocale(newLocale);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Products PageView
            SizedBox(
              height: 200,
              child: PageView.builder(
                itemCount: featuredImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        featuredImages[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error, color: Colors.red),
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

            // Grid of Products
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            product["image"]!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error, color: Colors.red),
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return const CircularProgressIndicator();
                            },
                          ),
                        ),
                        Text(product["title"]!),
                        IconButton(
                          icon: const Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('itemAdded'.tr())),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Hot Offers
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'hotOffers'.tr(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: offers.length,
              itemBuilder: (context, index) {
                final offer = offers[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Image.network(
                        offer["image"]!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error, color: Colors.red),
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const CircularProgressIndicator();
                        },
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          offer["title"]!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
