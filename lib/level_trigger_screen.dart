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
            var map = <String,dynamic>{};
            map["id"] = item.id!.toString() ;
            map["indexName"] =  item.indexName! ;
            map["triggerPrice"] = item.priceLevel!.toString();
            map["optionType"] = item.optionType!;
            map["trade_confidence"] = item.tradeConfidence!;
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
                        'Trigger Price: ${items[index]['triggerPrice']}, Option Type: ${items[index]['optionType']}, Trade Confidence: ${items[index]['trade_confidence']}',
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
  late double _tradeConfidence;
  var apiUtils = ApiUtils();

  @override
  void initState() {
    super.initState();
    _indexName = widget.item['indexName'] ?? bankNifty;
    _triggerPrice = widget.item['triggerPrice'] ?? '';
    _optionType = widget.item['optionType'] ?? optionTypeCE;
    _id = widget.item['id'] ?? '';
    if(widget.item['trade_confidence'] != null){
      _tradeConfidence =  double.parse(widget.item['trade_confidence']);
    }else{
      _tradeConfidence = 0.0;
    }

  }

  Future<void> _onSavePress() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final response = await apiUtils.makeGetApiCall("${apiBaseUrl}addLevels?&id=$_id&dhan_client_id=$dhanClientId&index_name=$_indexName&option_type=$_optionType&price_level=$_triggerPrice&trade_confidence=$_tradeConfidence");
      if (response != null) {
        try {
          final Map parsed = jsonDecode(response.body);
          final addTriggerResponse = addTrigger.AddTriggerLevelResponse.fromJson(parsed);
          if (addTriggerResponse.data != null) {
            _id = addTriggerResponse.data!.id.toString();
            _triggerPrice = addTriggerResponse.data!.priceLevel.toString();
            _indexName = addTriggerResponse.data!.indexName.toString();
            _optionType = addTriggerResponse.data!.optionType.toString();
            _tradeConfidence = addTriggerResponse.data!.tradeConfidence!.toDouble();


            Navigator.pop(context, {
              'indexName': _indexName,
              'triggerPrice': _triggerPrice,
              'optionType': _optionType,
              'id': _id,
              'trade_confidence': _tradeConfidence.toString(),
            });
          }
        } on Exception catch(e) {
          Logger.printLogs(e);
          if(mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error saving data: ${e.toString()}')),
            );
          }
        }
      } else {
        if(mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error: Unable to save data')),
          );
        }
      }
    }
  }

  String _getConfidenceLabel(double value) {
    if (value == 0.0) return '0%';
    if (value == 0.25) return '25%';
    if (value == 0.5) return '75%';
    if (value == 1.0) return '100%';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Item'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[50]!, Colors.blue[100]!],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Index Name', style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [bankNifty, nifty, sensex, finNifty].map((String value) {
                          return ChoiceChip(
                            label: Text(value),
                            selected: _indexName == value,
                            onSelected: (bool selected) {
                              setState(() {
                                _indexName = value;
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        initialValue: _triggerPrice,
                        decoration: InputDecoration(
                          labelText: 'Trigger Price',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
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
                      const SizedBox(height: 24),
                      Text('Option Type', style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _optionType,
                        items: [optionTypeCE, optionTypePE].map((String value) {
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
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text('Trade Confidence', style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 8),
                      Text(
                        '${(_tradeConfidence * 100).toInt()}%',
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.blue[700],
                          inactiveTrackColor: Colors.blue[100],
                          trackShape: const RoundedRectSliderTrackShape(),
                          trackHeight: 4.0,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                          thumbColor: Colors.blueAccent,
                          overlayColor: Colors.blue.withAlpha(32),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
                          tickMarkShape: const RoundSliderTickMarkShape(),
                          activeTickMarkColor: Colors.blue[700],
                          inactiveTickMarkColor: Colors.blue[100],
                          valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                          valueIndicatorColor: Colors.blueAccent,
                          valueIndicatorTextStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        child: Slider(
                          value: _tradeConfidence,
                          min: 0,
                          max: 1,
                          divisions: 4,
                          label: _getConfidenceLabel(_tradeConfidence),
                          onChanged: (double value) {
                            setState(() {
                              _tradeConfidence = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: ElevatedButton(
                          onPressed: _onSavePress,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            textStyle: const TextStyle(fontSize: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Text('Save',style: TextStyle(color: Colors.white),)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
