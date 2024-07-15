import 'package:flutter/material.dart';

class SingerListView extends StatelessWidget {
  const SingerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
      child: SizedBox(
        width: double.infinity,
        height: 120,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              width: 8,
            ),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(5),
            itemCount: 8,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(64),
              child: Image.network(
                'https://picsum.photos/seed/591/600',
                height: 100, // Burada yüksekliği sınırlıyoruz
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
