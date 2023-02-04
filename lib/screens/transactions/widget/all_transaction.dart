import 'package:flutter/material.dart';
import 'package:money_management/models/transaction_model/transaction_model.dart';

class RecentTransaction extends StatefulWidget {
  const RecentTransaction({super.key, required List<TransactionModel> result});

  @override
  State<RecentTransaction> createState() => _RecentTransactionState();
}

class _RecentTransactionState extends State<RecentTransaction> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
