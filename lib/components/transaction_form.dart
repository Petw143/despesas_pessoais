import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  @override
  void dispose() {
    // Libera os controladores para evitar vazamento de memória
    titleController.dispose();
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: valueController,
              decoration: InputDecoration(labelText: 'Valor (R\$)'),
            ),
            TextButton(
              onPressed: () {
                print(titleController.text); // Testando a captura do valor
                print(valueController.text);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.purple,
              ),
              child: Text('Nova Transação'),
            ),
          ],
        ),
      ),
    );
  }
}
