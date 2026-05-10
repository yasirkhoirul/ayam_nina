import 'package:flutter/material.dart';
import 'package:kedai_ayam_nina/core/constant/enum.dart';
import 'package:kedai_ayam_nina/core/utils/validators.dart';
import 'package:kedai_ayam_nina/core/widgets/custom_button_gradient.dart';
import 'package:kedai_ayam_nina/core/widgets/custom_dropdown.dart';
import 'package:kedai_ayam_nina/core/widgets/custom_textfield.dart';
import 'package:kedai_ayam_nina/core/widgets/switcher.dart';
import 'package:kedai_ayam_nina/features/transactions/domain/entities/transaction.dart';

class CardTransaction extends StatefulWidget {
  final Function(Transaction input) onSubmit;
  const CardTransaction({super.key, required this.onSubmit});

  @override
  State<CardTransaction> createState() => _CardTransactionState();
}

class _CardTransactionState extends State<CardTransaction> {
  final List<String> options = ["Pemasukan", "Pengeluaran"];
  final TextEditingController dateController = TextEditingController();
  final TextEditingController nominalController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  KategoriTransaksi? kategoriController;
  DateTime? _selectedDate;
  int selectedIndex = 0; // 0 = Pemasukan, 1 = Pengeluaran

  @override
  void dispose() {
    dateController.dispose();
    nominalController.dispose();
    keteranganController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 16,
      color: Theme.of(context).colorScheme.onPrimary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 10,
            children: [
              Switcher(
                options: options,
                selectedIndex: selectedIndex,
                onChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
              CustomInputField(
                validator: MyValidators.notNull,
                keyboardType: TextInputType.datetime,
                label: "Tanggal Transaksi",
                controller: dateController,
                hintText: "dd/mm/yyyy",
                prefixIcon: Icons.calendar_today,
                readOnly: true,
                onTap: () async {
                  // Saran: Munculkan Date Picker bawaan Flutter saat field ditekan
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    _selectedDate = pickedDate;
                    String formattedDate =
                        "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                    setState(() {
                      dateController.text = formattedDate;
                    });
                  }
                },
              ),

              CustomDropdownField(
                label: "Kategori",
                hintText: "Pilih kategori",
                validator: MyValidators.notNull,
                items: KategoriTransaksi.values.map((e) => e.label).toList(),
                value: null,
                onChanged: (value) {
                  if (value != null) {
                    kategoriController = KategoriTransaksi.values.firstWhere(
                      (e) => e.label == value,
                      orElse: () => KategoriTransaksi.lainnya,
                    );
                  }
                },
              ),
              CustomInputField.number(
                validator: MyValidators.notNull,
                label: "Nominal",
                hintText: "Masukkan nominal transaksi",
                controller: nominalController,
              ),
              CustomInputField(
                validator: MyValidators.notNull,
                label: "Keterangan Tambahan",
                hintText: "Masukkan keterangan tambahan",
                controller: keteranganController,
              ),
              CustomGradientButton(
                leadingIcon: Icons.save,
                text: "Submit",
                onTap: () {
                  if (_formKey.currentState!.validate() &&
                      _selectedDate != null) {
                    // Tentukan jenis dari switcher: 0 = pemasukan, 1 = pengeluaran
                    final jenis = selectedIndex == 0
                        ? JenisTransaksi.pemasukan
                        : JenisTransaksi.pengeluaran;

                    final transaction = Transaction(
                      id: "",
                      tanggal: _selectedDate!,
                      jenis: jenis,
                      kategori: kategoriController!,
                      nominal: int.parse(nominalController.text),
                      keterangan: keteranganController.text,
                    );
                    widget.onSubmit(transaction);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
