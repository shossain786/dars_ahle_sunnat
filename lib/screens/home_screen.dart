import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A001D),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black.withOpacity(0.2),
                hintText: 'search song',
                hintStyle: GoogleFonts.poppins(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('RECENTLY PLAYED', onSeeAllPressed: () {}),
            const SizedBox(height: 10),
            _buildRecentlyPlayed(),
            const SizedBox(height: 20),
            _buildSectionTitle('RECOMMENDATION', onSeeAllPressed: () {}),
            const SizedBox(height: 10),
            _buildRecommendations(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title,
      {required VoidCallback onSeeAllPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onSeeAllPressed,
          child: Text(
            'See All',
            style: GoogleFonts.poppins(color: Colors.white70),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentlyPlayed() {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('recently_played').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();
        var documents = snapshot.data!.docs;

        return Row(
          children: documents.map((doc) {
            return Expanded(
              child: Column(
                children: [
                  Image.network(
                      doc['image']), // Use your image URL from Firebase
                  const SizedBox(height: 8),
                  Text(
                    doc['title'],
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    doc['artist'],
                    style: GoogleFonts.poppins(
                        color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildRecommendations() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('recommendations')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          var documents = snapshot.data!.docs;

          return ListView(
            children: documents.map((doc) {
              return ListTile(
                leading: Image.network(doc['image']),
                title: Text(
                  doc['title'],
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                ),
                subtitle: Text(
                  doc['artist'],
                  style:
                      GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
                ),
                trailing:
                    const Icon(Icons.favorite_border, color: Colors.white70),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
