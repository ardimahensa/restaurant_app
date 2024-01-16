import 'package:flutter/material.dart';

class AddReviewDialog extends StatefulWidget {
  final String restaurantId;
  final VoidCallback onReviewAdded;
  final Function(String name) onNameChanged;
  final Function(String review) onReviewChanged;

  const AddReviewDialog({
    super.key,
    required this.restaurantId,
    required this.onReviewAdded,
    required this.onNameChanged,
    required this.onReviewChanged,
  });

  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Tambahkan Review"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) {
              widget.onNameChanged(value);
            },
            decoration: const InputDecoration(
              labelText: 'Nama Pengguna',
              hintText: 'Masukkan nama pengguna',
            ),
          ),
          TextField(
            onChanged: (value) {
              widget.onReviewChanged(value);
            },
            decoration: const InputDecoration(
              labelText: 'Ulasan',
              hintText: 'Masukkan ulasan Anda',
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              widget.onReviewAdded;
            },
            child: const Text('Tambahkan Ulasan'),
          ),
        ],
      ),
    );
  }
}
