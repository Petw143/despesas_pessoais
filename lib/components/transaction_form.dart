import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {

  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  void _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return; // Evita submissão inválida
    }

    widget.onSubmit(title, value); 

    // Limpar os campos após submissão
    titleController.clear();
    valueController.clear();
  }  

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
              onPressed: _submitForm,
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
