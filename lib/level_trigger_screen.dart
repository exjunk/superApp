import 'package:flutter/material.dart';
import 'package:super_app/my_const.dart';

class LevelMarkerScreen extends StatefulWidget {
  @override
  _LevelMarkerScreenState createState() => _LevelMarkerScreenState();
}

class _LevelMarkerScreenState extends State<LevelMarkerScreen> {
  List<Map<String, dynamic>> items = [
    {
      'indexName': bankNifty,
      'triggerPrice': '100',
      'optionType': optionTypeCE,
    },
    {
      'indexName': nifty,
      'triggerPrice': '200',
      'optionType': optionTypeCE,
    },
  ];

  void _editItem(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(
          item: items[index],
        ),
      ),
    );
    if (result != null) {
      setState(() {
        items[index] = result;
      });
    }
  }

  void _addItem() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(
          item: {},
        ),
      ),
    );
    if (result != null) {
      setState(() {
        items.add(result);
      });
    }
  }

  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trade level marker'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(items[index]['indexName'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        'Trigger Price: ${items[index]['triggerPrice']}, Option Type: ${items[index]['optionType']}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _editItem(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteItem(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const VerticalDivider(),
          Expanded(
            child: Center(
              child: ElevatedButton(
                onPressed: _addItem,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Add Item'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  EditScreen({required this.item});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _triggerPrice;
  late String _optionType;
  late String _indexName;

  @override
  void initState() {
    super.initState();
    _indexName = widget.item['indexName'] ?? bankNifty;
    _triggerPrice = widget.item['triggerPrice'] ?? '';
    _optionType = widget.item['optionType'] ?? optionTypeCE;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Index Name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    RadioListTile(
                      title: const Text(bankNifty),
                      value: bankNifty,
                      groupValue: _indexName,
                      onChanged: (value) {
                        setState(() {
                          _indexName = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text(nifty),
                      value: nifty,
                      groupValue: _indexName,
                      onChanged: (value) {
                        setState(() {
                          _indexName = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text(sensex),
                      value: sensex,
                      groupValue: _indexName,
                      onChanged: (value) {
                        setState(() {
                          _indexName = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text(finNifty),
                      value: finNifty,
                      groupValue: _indexName,
                      onChanged: (value) {
                        setState(() {
                          _indexName = value.toString();
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _triggerPrice,
                      decoration: const InputDecoration(
                        labelText: 'Trigger Price',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (value) => _triggerPrice = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a trigger price';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text('Option Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    DropdownButtonFormField<String>(
                      value: _optionType,
                      items: [optionTypeCE,optionTypePE].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _optionType = newValue!;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Navigator.pop(context, {
                              'indexName': _indexName,
                              'triggerPrice': _triggerPrice,
                              'optionType': _optionType,
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          textStyle: const TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
