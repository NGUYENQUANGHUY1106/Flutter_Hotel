import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';

class VnPayPage extends StatefulWidget {
  const VnPayPage({super.key});

  @override
  State<VnPayPage> createState() => _VnPayPageState();
}

class _VnPayPageState extends State<VnPayPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<String> _generatePaymentUrl() async {
    const String tmnCode = 'PBXX6NDZ';
    const String secretKey = 'KGEQLUWSJEFNSEVDSYJDRGGTTETVJLUQ';
    

    final DateTime now = DateTime.now();
    final DateTime expireDate = now.add(const Duration(minutes: 15));

    return VNPAYFlutter.instance.generatePaymentUrl(
      url: 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html',
      version: '2.0.1',
      tmnCode: tmnCode,
      txnRef: now.millisecondsSinceEpoch.toString(),
      orderInfo: 'Thanh toan 30,000 VND',
      amount: 30000,
      returnUrl: 'https://abc.com/return',
      ipAdress: '0.0.0.0',
      vnpayHashKey: secretKey,
      vnPayHashType: VNPayHashType.HMACSHA512,
      vnpayExpireDate: expireDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Thanh toán VNPay")),
        body: ElevatedButton(
            onPressed: () async {
              final url = await _generatePaymentUrl();
              sd(url);
            },
            child: const Text("sds")));
  }

  void sd(String paymentUrl) {
    VNPAYFlutter.instance.show(
      paymentUrl: paymentUrl,
      onPaymentSuccess: (map) {
        print(map);
      },
      onPaymentError: (map) {
        print(map);
      },
    );
  }
}
