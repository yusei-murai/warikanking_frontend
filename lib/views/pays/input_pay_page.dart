import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentProvider with ChangeNotifier {
  List<String> _payerList = ['Aさん', 'Bさん', 'Cさん'];
  //List<Payment> _paymentList = [];

  List<String> get payerList => [..._payerList];

  //List<Payment> get paymentList => [..._paymentList];

  //void addPayment(Payment payment) {
    //_paymentList.add(payment);
    //notifyListeners();
  //}
}

class InputPayPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _eventController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _selectedPayer='Aさん';

  @override
  Widget build(BuildContext context) {
    final payerList = Provider.of<PaymentProvider>(context).payerList;
    return Scaffold(
      appBar: AppBar(
        title: Text('支払い入力'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'イベント'),
                controller: _eventController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'イベント名は必須です';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '内容'),
                controller: _descriptionController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return '内容は必須です';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '金額'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return '金額は必須です';
                  }
                  if (double.tryParse(value) == null) {
                    return '金額は数字で入力してください';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: '支払い者'),
                value: _selectedPayer,
                onChanged: (value) {
                  _selectedPayer = value!;
                },
                validator: (value) {
                  if (value == null) {
                    return '支払い者を選択してください';
                  }
                  return null;
                },
                items: payerList.map<DropdownMenuItem<String>>((payer) {
                  return DropdownMenuItem<String>(
                    value: payer,
                    child: Text(payer),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              TextButton(
                child: Text('保存'),
                onPressed: () {

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}