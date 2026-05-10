import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedai_ayam_nina/core/widgets/animated_scroll_item.dart';
import 'package:kedai_ayam_nina/core/widgets/card/card_product.dart';
import 'package:kedai_ayam_nina/features/produk/presentation/bloc/product_catalog_bloc.dart';
import 'package:kedai_ayam_nina/features/user/presentation/widgets/user_navbar.dart';
import 'package:kedai_ayam_nina/features/user/presentation/widgets/user_footer.dart';
import 'package:kedai_ayam_nina/features/user/presentation/widgets/user_drawer.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  String selectedCategory = "All";

  @override
  void initState() {
    super.initState();
    context.read<ProductCatalogBloc>().add(LoadProducts());
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF0),
      drawer: isDesktop ? null : const UserDrawer(),
      body: CustomScrollView(
        slivers: [
          UserNavBar(isDesktop: isDesktop),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 64.0 : 24.0,
                vertical: 48.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedScrollItem(
                    id: 'catalog_title',
                    child: const Text(
                      "Our Menu",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AnimatedScrollItem(
                    id: 'catalog_subtitle',
                    child: const Text(
                      "Discover the golden, crispy perfection of Kedai Ayam Nina. From our signature\noriginal recipe to fiery geprek, every bite is a taste of home.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  AnimatedScrollItem(id: 'catalog_cats', child: _buildCategories()),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          BlocBuilder<ProductCatalogBloc, ProductCatalogState>(
            builder: (context, state) {
              if (state is ProductCatalogLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is ProductCatalogLoaded) {
                final products = state.products;
                if (products.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: Text("Menu belum tersedia.")),
                  );
                }

                // Temporary filter logic
                final filteredProducts = selectedCategory == "All" 
                    ? products 
                    : products.where((p) => p.category.toLowerCase() == selectedCategory.toLowerCase()).toList();

                return SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 64.0 : 24.0,
                  ).copyWith(bottom: 64.0),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isDesktop ? 3 : 1,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 24,
                      childAspectRatio: isDesktop ? 0.8 : 0.85,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return AnimatedScrollItem(
                          id: 'product_$index',
                          child: ProductGridItem(
                            product: filteredProducts[index],
                            isAdmin: false,
                            onDelete: () {}, // No action for user side
                          ),
                        );
                      },
                      childCount: filteredProducts.length,
                    ),
                  ),
                );
              }
              return const SliverFillRemaining(
                child: Center(child: Text("Gagal memuat produk")),
              );
            },
          ),
          UserFooter(isDesktop: isDesktop),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    final categories = ["All", "Food", "Beverage"];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: categories.map((cat) {
        final isSelected = selectedCategory == cat;
        return InkWell(
          onTap: () {
            setState(() {
              selectedCategory = cat;
            });
          },
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF8B4513) : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isSelected ? const Color(0xFF8B4513) : Colors.grey.shade300,
              ),
            ),
            child: Text(
              cat,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
