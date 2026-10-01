import 'package:flutter/material.dart';
import 'models/stationery_item.dart';

class DetailPage extends StatefulWidget {
  final StationeryItem item;

  const DetailPage({super.key, required this.item});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late TextEditingController _descController;
  late TextEditingController _stockController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    // Mengisi input controller
    _descController = TextEditingController(
      text: widget.item.description.toString(),
    );
    _stockController = TextEditingController(
      text: widget.item.stock.toString(),
    );
    _priceController = TextEditingController(
      text: widget.item.price.toString(),
    );
  }

  @override
  void dispose() {
    _stockController.dispose();
    _descController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _simpan() {
    String newDesc = _descController.text;
    int? newStock = int.tryParse(_stockController.text);
    int? newPrice = int.tryParse(_priceController.text);

    setState(() {
      widget.item.description = newDesc;
    });

    if (newStock != null && newStock >= 0 && newPrice != null && newPrice >=0) {
      setState(() {
        widget.item.stock = newStock;
      });

      setState(() {
        widget.item.stock = newPrice;
      });
      

      // Menampilkan snackbar pemberitahuan
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Detail berhasil diperbarui!')),
      );

      // Kembali ke Halaman Beranda
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan detail yang valid!')),
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
            // Gambar
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
                    child: const Icon(
                      Icons.fastfood,
                      size: 80,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            //Nama Barang
            Text(
              widget.item.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            //Harga per pcs
            Text(
              'Rp ${widget.item.formattedPrice} / pcs',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 12),

            //Deskripsi
            Text(widget.item.description, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 20),

            // Input Field untuk Mengubah Deskripsi
            TextField(
              controller: _descController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit_note),
              ),
            ),
            const SizedBox(height: 16),

            //Input Field untuk Mengubah Jumlah Stock
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

            //Input Field untuk Mengubah Harga
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Harga (pcs)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit_note),
              ),
            ),
            const SizedBox(height: 16),

            //Ringkasan Total Harga Saat Ini
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
                onPressed: _simpan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
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
