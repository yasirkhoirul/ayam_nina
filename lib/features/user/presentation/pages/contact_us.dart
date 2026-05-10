import 'package:flutter/material.dart';
import 'package:kedai_ayam_nina/core/widgets/animated_scroll_item.dart';
import 'package:kedai_ayam_nina/features/user/presentation/widgets/user_navbar.dart';
import 'package:kedai_ayam_nina/features/user/presentation/widgets/user_footer.dart';
import 'package:kedai_ayam_nina/features/user/presentation/widgets/user_drawer.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

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
                    id: 'contact_title',
                    child: const Text(
                      "Contact Us",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  AnimatedScrollItem(
                    id: 'contact_desc',
                    child: const Text(
                      "Punya pertanyaan atau masukan? Jangan ragu untuk menghubungi kami.",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  AnimatedScrollItem(id: 'contact_card_email', child: _buildContactCard(Icons.email, "Email", "hello@kedaiayamnina.com")),
                  const SizedBox(height: 16),
                  AnimatedScrollItem(id: 'contact_card_phone', child: _buildContactCard(Icons.phone, "Phone", "+62 812 3456 7890")),
                  const SizedBox(height: 16),
                  AnimatedScrollItem(id: 'contact_card_loc', child: _buildContactCard(Icons.location_on, "Location", "Jl. Ayam Goreng No. 1, Jakarta")),
                ],
              ),
            ),
          ),
          UserFooter(isDesktop: isDesktop),
        ],
      ),
    );
  }

  Widget _buildContactCard(IconData icon, String title, String content) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFDFBF0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF8B4513)),
          ),
          const SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          )
        ],
      ),
    );
  }
}
