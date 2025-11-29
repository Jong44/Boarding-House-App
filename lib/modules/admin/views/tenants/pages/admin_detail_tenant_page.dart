import 'package:flutter/material.dart';

class AdminDetailTenantPage extends StatefulWidget {
  const AdminDetailTenantPage({Key? key}) : super(key: key);

  @override
  State<AdminDetailTenantPage> createState() => _AdminDetailTenantPageState();
}

class _AdminDetailTenantPageState extends State<AdminDetailTenantPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  String _formatCurrency(int amount) {
    return 'Rp ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Detail Penyewa',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  InkWell(onTap: () {}, child: const Icon(Icons.more_vert)),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Profile Section
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFED7AA),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Color(0xFFFF5722),
                              size: 40,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Rina Putri',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD1FAE5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Kontrak Aktif',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF059669),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Tab Bar
                    Container(
                      color: Colors.white,
                      child: TabBar(
                        controller: _tabController,
                        labelColor: const Color(0xFFFF5722),
                        unselectedLabelColor: const Color(0xFF9CA3AF),
                        indicatorColor: const Color(0xFFFF5722),
                        indicatorWeight: 3,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        tabs: const [
                          Tab(text: 'Info'),
                          Tab(text: 'Kontrak'),
                          Tab(text: 'Pembayaran'),
                          Tab(text: 'Riwayat'),
                        ],
                      ),
                    ),

                    // Tab Content
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 400,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildInfoTab(),
                          _buildContractTab(),
                          _buildPaymentTab(),
                          _buildHistoryTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Action Buttons
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF5722),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Kirim Invoice',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(icon, color: const Color(0xFFFF5722)),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
        ),
      ],
    );
  }

  Widget _buildInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard('Identitas Penyewa', [
            _buildInfoRow('Nama Lengkap', 'Rina Putri'),
            _buildInfoRow('Nomor HP', '081234567890'),
            _buildInfoRow('Email', 'rina.putri@email.com'),
            _buildInfoRow('Tanggal Masuk', '15 Januari 2024'),
            _buildInfoRow('Alamat', 'Jl. Merdeka No. 123, Jakarta'),
          ]),
          const SizedBox(height: 12),
          _buildInfoCard('Informasi Kamar', [
            _buildInfoRow('Nomor Kamar', 'A-12'),
            _buildInfoRow('Tipe Kamar', '3x4 meter'),
            _buildInfoRow('Harga Sewa', _formatCurrency(1200000) + '/bulan'),
            _buildInfoRow('Fasilitas', 'AC, Kasur, Lemari, WiFi'),
            _buildInfoRow('Area Tambahan', 'Parkir Motor'),
            _buildInfoRow('Lokasi', 'Gedung A, Lantai 1'),
          ]),
        ],
      ),
    );
  }

  Widget _buildContractTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard('Kontrak Aktif', [
            _buildInfoRow('Nomor Kontrak', 'KTR-2024-001-A12'),
            _buildInfoRow('Tanggal Mulai', '15 Januari 2024'),
            _buildInfoRow('Tanggal Berakhir', '15 Januari 2025'),
            _buildInfoRow('Durasi Sewa', '12 Bulan'),
            _buildInfoRow(
              'Status',
              'Aktif',
              valueColor: const Color(0xFF059669),
            ),
            _buildInfoRow(
              'Sisa Waktu',
              '178 Hari',
              valueColor: const Color(0xFF059669),
            ),
          ]),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text(
                    'Perpanjang',
                    style: TextStyle(fontSize: 13),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5722),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.close, size: 18),
                  label: const Text('Akhiri', style: TextStyle(fontSize: 13)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFDC2626),
                    side: const BorderSide(color: Color(0xFFDC2626)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoCard('Riwayat Perpanjangan', [
            _buildHistoryItem(
              'Kontrak Pertama',
              '15 Jan 2024 - 15 Jan 2025',
              _formatCurrency(1200000) + '/bln',
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildPaymentTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Payment Summary
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF5722), Color(0xFFFF7043)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tagihan Bulan Ini',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  _formatCurrency(1200000),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Status',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Lunas',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          'Jatuh Tempo',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '15 Nov 2024',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('Riwayat Invoice'),
          _buildInvoiceItem(
            'INV-2024-11-001',
            'November 2024',
            'Paid',
            1200000,
          ),
          _buildInvoiceItem('INV-2024-10-001', 'Oktober 2024', 'Paid', 1200000),
          _buildInvoiceItem(
            'INV-2024-09-001',
            'September 2024',
            'Paid',
            1200000,
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Riwayat Pembayaran'),
          _buildPaymentHistoryItem(
            '15 Nov 2024',
            'Pembayaran Sewa November',
            'Transfer Bank',
            1200000,
          ),
          _buildPaymentHistoryItem(
            '15 Okt 2024',
            'Pembayaran Sewa Oktober',
            'Transfer Bank',
            1200000,
          ),
          _buildPaymentHistoryItem(
            '15 Sep 2024',
            'Pembayaran Sewa September',
            'Transfer Bank',
            1200000,
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('Riwayat Maintenance'),
          _buildMaintenanceItem('10 Nov 2024', 'Perbaikan AC', 'Done', 250000),
          _buildMaintenanceItem(
            '25 Okt 2024',
            'Ganti Lampu Kamar',
            'Done',
            75000,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: valueColor ?? Colors.black87,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String title, String period, String price) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                period,
                style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
            ],
          ),
          Text(
            price,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInvoiceItem(
    String invoiceNo,
    String period,
    String status,
    int amount,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.description_outlined,
              color: Color(0xFFFF5722),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invoiceNo,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  period,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFD1FAE5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF059669),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatCurrency(amount),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentHistoryItem(
    String date,
    String description,
    String method,
    int amount,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFD1FAE5),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(Icons.check_circle, color: Color(0xFF059669)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$date • $method',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          Text(
            _formatCurrency(amount),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0xFF059669),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceItem(
    String date,
    String description,
    String status,
    int cost,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFFED7AA),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(Icons.build_outlined, color: Color(0xFFFF5722)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFD1FAE5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF059669),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatCurrency(cost),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
