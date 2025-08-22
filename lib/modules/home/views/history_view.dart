import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        children: const [
          _Header(title: "History"),
          SizedBox(height: 16),
          _PlaceholderCard(text: "Paid / Failed / Refunded requests"),
          _PlaceholderCard(text: "Filters: date range, issuer, status"),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  const _Header({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _PlaceholderCard extends StatelessWidget {
  final String text;
  const _PlaceholderCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white70)),
    );
  }
}
