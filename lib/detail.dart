import 'package:flutter/material.dart';
import 'models/stationery_item.dart';

class DetailPage extends StatefulWidget {
  final StationeryItem item;

  const DetailPage({super.key, required this.item});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late TextEditingController _stockController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    // Mengisi input controller
    _stockController = TextEditingController(
      text: widget.item.stock.toString(),
    );
    _descController = TextEditingController(
      text: widget.item.description.toString(),
    );
  }

  @override
  void dispose() {
    _stockController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _simpanStock() {
    int? newStock = int.tryParse(_stockController.text);
    if (newStock != null && newStock >= 0) {
      setState(() {
        // Mengubah porsi item
        widget.item.stock = newStock;
      });

      // Menampilkan snackbar pemberitahuan
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jumlah stok berhasil diperbarui!')),
      );

      // Kembali ke Halaman Beranda
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan jumlah stok yang valid!')),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
              widget.item.name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Gambar Makanan
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.item.imageUrl,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 220,
                    color: Colors.grey[300],
                    child: const Icon(Icons.fastfood, size: 80, color: Colors.grey),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // 2. Nama Makanan
            Text(
              widget.item.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            // 3. Harga per Porsi
            Text(
              'Rp ${widget.item.formattedPrice} / porsi',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),

            // 4. Deskripsi Makanan
            Text(
              widget.item.description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _descController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Stok tersedia (pcs)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit_note),
              ),
            ),
            const SizedBox(height: 16),

            // 5. Input Field untuk Mengubah Jumlah Porsi
            TextField(
              controller: _stockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Stok tersedia (pcs)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit_note),
              ),
            ),
            const SizedBox(height: 16),

            // 6. Ringkasan Total Harga Saat Ini
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp ${widget.item.formattedPrice}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 7. Tombol Simpan Perubahan Porsi
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _simpanStock,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: 
                const Text(
                  'Simpan',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}