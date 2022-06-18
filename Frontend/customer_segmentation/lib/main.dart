import 'dart:convert';

import 'package:customer_segmentation/customer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

var customersList = {};
var customerRecords = {};
var customersIndex = {};
var customerID = '';
var index = '';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Fetch content from the json file
  Future<void> readCustomerIds() async {
    final String response1 =
        await rootBundle.loadString('assets/files/RFMScore_data.json');
    final customerRfm = await json.decode(response1) as Map;
    final customerIds = customerRfm['CustomerID'].values;
    final cluster = customerRfm['Cluster_3'].values;
    for (int i = 0; i < cluster.length; i++) {
      customersList[customerIds.elementAt(i)] = cluster.elementAt(i);
    }
  }

  Future<void> readRecords() async {
    final String response1 =
        await rootBundle.loadString('assets/files/new_customer_data.json');
    final customers = await json.decode(response1);
    for(int i=0; i<customers['CustomerID'].length;i++) {
      customersIndex[customers['CustomerID'][i.toString()]] = i.toString();
    }
    customerRecords = customers;
  }

  @override
  void initState() {
    super.initState();
    readCustomerIds();
    readRecords();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer Segmentation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _customerIDController = TextEditingController();
  String? status = '';

  @override
  Widget build(BuildContext context) {
    String getGroup(int a) {
      return a == 2 ? 'Platinum' : (a == 0 ? 'Gold' : 'Silver');
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_img_1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        // Central Box
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 3,
            vertical: MediaQuery.of(context).size.height / 3,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: Text(
                      'Customer Segmentation',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          controller: _customerIDController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]'),
                            ),
                          ],
                          decoration: const InputDecoration(
                            hintText: 'Customer ID',
                            icon: Icon(Icons.person),
                          ),
                          validator: (text) {
                            if (text!.trim().isEmpty) {
                              setState(() {
                                status = '';
                              });
                              return 'Enter Customer ID';
                            }
                            return null;
                          },
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (customersList.containsKey(
                                  int.parse(_customerIDController.text))) {
                                setState(() {
                                  status = 'Valid';
                                  customerID = _customerIDController.text.toString();
                                  index = (customersIndex[int.parse(_customerIDController.text.toString())]).toString();
                                });
                              } else {
                                setState(() {
                                  status = 'False';
                                  customerID = '';
                                  index = '';
                                });
                              }
                            }
                          },
                          child: const Text('Search'),
                        ),
                      ],
                    ),
                  ),
                  status! == ''
                      ? Container()
                      : Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                status! == 'False'
                                    ? 'Invalid Customer ID'
                                    : (status! == ''
                                        ? ''
                                        : 'Customer Belongs to Group : ${getGroup(customersList[int.parse(_customerIDController.text)])}     '),
                                style: TextStyle(
                                  color: status! == 'False'
                                      ? Colors.red
                                      : Colors.black,
                                ),
                              ),
                              status! == 'False' || status! == ''
                                  ? Container()
                                  : InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => CustomerScreen(
                                              customerID: customerID.toString(),
                                              group: getGroup(customersList[int.parse(_customerIDController.text)]).toString(),
                                              invoiceNo: customerRecords['InvoiceNo'][index],
                                              stockCode: customerRecords['StockCode'][index],
                                              quantity: customerRecords['Quantity'][index],
                                              unitPrice: customerRecords['UnitPrice'][index],
                                              amount: customerRecords['Amount'][index],
                                              description: customerRecords['Description'][index],
                                              invoiceDate: customerRecords['InvoiceDate'][index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'View',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontStyle: FontStyle.italic,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
