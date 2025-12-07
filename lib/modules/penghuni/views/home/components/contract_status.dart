import 'package:boarding_house_app/models/contract_model.dart';
import 'package:boarding_house_app/utils/format_date.dart';
import 'package:flutter/material.dart';

class ContractStatus extends StatefulWidget {
  final ContractModel contract;
  const ContractStatus({super.key, required this.contract});

  @override
  State<ContractStatus> createState() =>
      _ContractStatusState(contract: contract);
}

class _ContractStatusState extends State<ContractStatus> {
  final ContractModel contract;

  _ContractStatusState({required this.contract});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Kontrak Aktif',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  contract.status,
                  style: TextStyle(
                    color: Color(0xFF4CAF50),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            contract.propertyDetails?.name ?? 'Nama Properti',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.room_outlined,
                size: 18,
                color: Color(0xFF757575),
              ),
              const SizedBox(width: 4),
              Text(
                "Kamar ${contract.roomDetails?.id ?? 'N/A'}",
                style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.calendar_today_outlined,
                size: 18,
                color: Color(0xFF757575),
              ),
              const SizedBox(width: 4),
              Text(
                "${contract.contractType == 'monthly' ? 'Bulanan' : 'Tahunan'}",
                style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B2C).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  color: Color(0xFFFF6B2C),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 13, color: Color(0xFF1A1A1A)),
                      children: [
                        TextSpan(text: 'Kontrak akan berakhir dalam '),
                        TextSpan(
                          text:
                              '${contract.endDate.difference(DateTime.now()).inDays} hari',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF6B2C),
                          ),
                        ),
                        TextSpan(
                          text:
                              ' ${formatDate(contract.endDate, withDayName: true)}.',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
