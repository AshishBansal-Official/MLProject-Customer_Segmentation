import 'dart:ui';

import 'package:flutter/material.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({
    Key? key,
    @required this.customerID,
    @required this.group,
    this.invoiceNo,
    this.stockCode,
    this.quantity,
    this.unitPrice,
    this.amount,
    this.description,
    this.invoiceDate,
  }) : super(key: key);
  final Color textColor = Colors.white;
  final String? customerID;
  final String? group;
  final List? invoiceNo;
  final List? stockCode;
  final List? quantity;
  final List? unitPrice;
  final List? amount;
  final List? description;
  final List? invoiceDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/bg_img_1.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Container(),
            ),
          ),
          SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.red,
                        ),
                        child: Text(
                          'Customer ID : $customerID',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.red,
                        ),
                        child: Text(
                          'Group : $group',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView.builder(
                          itemCount: invoiceNo!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: CustomerScreenTile(
                                textColor: textColor,
                                invoiceNo: invoiceNo![index],
                                stockCode: stockCode![index],
                                quantity: quantity![index].toString(),
                                unitPrice: unitPrice![index].toString(),
                                amount: amount![index].toString(),
                                description: description![index],
                                invoiceDate: invoiceDate![index],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomerScreenTile extends StatelessWidget {
  const CustomerScreenTile({
    Key? key,
    required this.textColor,
    this.invoiceNo,
    this.stockCode,
    this.quantity,
    this.unitPrice,
    this.amount,
    this.description,
    this.invoiceDate,
  }) : super(key: key);

  final Color textColor;
  final String? invoiceNo;
  final String? stockCode;
  final String? quantity;
  final String? unitPrice;
  final String? amount;
  final String? description;
  final String? invoiceDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      margin: const EdgeInsets.only(),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Invoice No. : $invoiceNo',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Stock Code : $stockCode',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                Text(
                  'Invoice Date: $invoiceDate',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Quantity : $quantity',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Unit Price : $unitPrice',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              color: textColor,
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Description : $description',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Amount : $amount',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
