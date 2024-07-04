import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:super_app/my_const.dart';
import 'package:super_app/api_call_util.dart';
import 'package:super_app/response/GetTriggerLevelsResponse.dart' as triggerLevel;
import 'package:super_app/utils/Logger.dart';
import 'package:super_app/response/AddTriggerLevelResponse.dart' as addTrigger;


class LevelMarkerScreen extends StatefulWidget {
  @override
  _LevelMarkerScreenState createState() => _LevelMarkerScreenState();
}

class _LevelMarkerScreenState extends State<LevelMarkerScreen> {

  var apiUtils = ApiUtils();
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    _initList();
  }

  void _initList() async{
    final response =  await apiUtils.makeGetApiCall("${apiBaseUrl}getLevels?dhan_client_id=$dhanClientId");
    if(response != null){
      try {
        final Map parsed = jsonDecode(response.body);
        final triggerLevelResponse = triggerLevel.GetTriggerLevelsResponse.fromJson(parsed);
        var data = triggerLevelResponse.data;
        if(data != null) {

          List<Map<String, dynamic>> tempList = [];
          for (triggerLevel.Data item in data) {
            var map = <String,String>{};
            map["id"] = item.id!.toString() ;
            map["indexName"] =  item.indexName! ;
            map["triggerPrice"] = item.priceLevel!.toString();
            map["optionType"] = item.optionType!;
            tempList.add(map);
          }
          setState(() {
            items.clear();
            items.addAll(tempList);
          });
        }

      }on Exception catch(e){
        Logger.printLogs(e);
      }
    }
  }



  void _editItem(int index) async {
    print(items[index]);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(
          item: items[index],
        ),
      ),
    );
    if (result != null) {
     // _initList();
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
      print(result);
      setState(() {
        items.add(result);
      });
    }
  }

  void _deleteItem(int index) {
    var item = items[index];
    deleteLevels(item['indexName'],item['triggerPrice']);
    setState(() {
      items.removeAt(index);
    });
  }

  void deleteLevels(String index,String level) async{
    final response = await apiUtils.makeGetApiCall("${apiBaseUrl}deleteLevels?dhan_client_id=$dhanClientId&index_name=$index&price_level=$level");
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
  late String _id;
  var apiUtils = ApiUtils();

  @override
  void initState() {
    super.initState();
    _indexName = widget.item['indexName'] ?? bankNifty;
    _triggerPrice = widget.item['triggerPrice'] ?? '';
    _optionType = widget.item['optionType'] ?? optionTypeCE;
    _id = widget.item['id']?? '';
  }

  Future<addTrigger.AddTriggerLevelResponse?>  _onSavePress() async{
     final response = await apiUtils.makeGetApiCall("${apiBaseUrl}addLevels?&id=$_id&dhan_client_id=$dhanClientId&index_name=$_indexName&option_type=$_optionType&price_level=$_triggerPrice");
     if (response != null) {
       try {
         final Map parsed = jsonDecode(response.body);
         final addTriggerResponse = addTrigger.AddTriggerLevelResponse.fromJson(parsed);
          return addTriggerResponse;
       } on Exception catch(e){
         Logger.printLogs(e);
       }
     }
     return null;
     //Logger.printLogs(response);
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
                            _onSavePress().then((addTriggerResponse){
                              if(addTriggerResponse != null) {
                                _id = addTriggerResponse.data!.id.toString();
                                _triggerPrice =
                                    addTriggerResponse.data!.priceLevel
                                        .toString();
                                _indexName = addTriggerResponse.data!.indexName
                                    .toString();
                                _optionType =
                                    addTriggerResponse.data!.optionType
                                        .toString();

                                Navigator.pop(context, {
                                  'indexName': _indexName,
                                  'triggerPrice': _triggerPrice,
                                  'optionType': _optionType,
                                  'id':_id
                                });
                              }
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
