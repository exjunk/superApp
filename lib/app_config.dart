import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppConfigScreen extends StatefulWidget {
  @override
  _AppConfigScreenState createState() => _AppConfigScreenState();
}

class _AppConfigScreenState extends State<AppConfigScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _isEditing = true;
  bool _isSaving = false;
  late AnimationController _animationController;

  final List<Map<String, dynamic>> _indexConfigs = [
    {'name': 'BANKNIFTY', 'maxQty': 25, 'defaultSL': 0.5, 'defaultTarget': 1.0},
    {'name': 'NIFTY', 'maxQty': 50, 'defaultSL': 0.3, 'defaultTarget': 0.8},
    {'name': 'SENSEX', 'maxQty': 20, 'defaultSL': 0.4, 'defaultTarget': 0.9},
    {'name': 'FINNIFTY', 'maxQty': 40, 'defaultSL': 0.6, 'defaultTarget': 1.2},
  ];

  final List<Map<String, dynamic>> _killSwitchConfigs = [
    {'haltPeriod': '30 min', 'lossPercent': 5.0},
    {'haltPeriod': '1 hr', 'lossPercent': 7.5},
    {'haltPeriod': 'Kill Switch', 'lossPercent': 10.0},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _isEditingAllowed() {
    final now = DateTime.now();
    final startTime = DateTime(now.year, now.month, now.day, 9, 15);
    final endTime = DateTime(now.year, now.month, now.day, 15, 30);
    return now.isBefore(startTime) || now.isAfter(endTime);
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
    if (_isEditing) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _saveChanges() async {
    setState(() {
      _isSaving = true;
    });

    // Simulate saving process
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isEditing = false;
      _isSaving = false;
    });
    _animationController.reverse();

    /*ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Changes saved successfully')),
    );*/
    if (mounted) {
      showSavedSuccessfully(context);
    }
  }

  void showSavedSuccessfully(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Changes saved successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF5F7FA), Color(0xFFE4E8EC)],
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              _buildSideNavigation(),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildHeader(),
                      Expanded(
                        child: _selectedIndex == 0
                            ? _buildIndexConfigView()
                            : _buildKillSwitchConfigView(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _isEditing
          ? FloatingActionButton(
        onPressed: _saveChanges,
        backgroundColor: const Color(0xFF6B8E23),
        child: _isSaving
            ? Lottie.network(
          'https://assets3.lottiefiles.com/packages/lf20_yw3nyrsv.json',
          width: 40,
          height: 40,
        )
            : const Icon(Icons.save),
      )
          : null,
    );
  }

  Widget _buildSideNavigation() {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xFF6B8E23),
            child: Icon(Icons.settings, size: 30, color: Colors.white),
          ),
          const SizedBox(height: 40),
          _buildNavItem(0, 'Index', Icons.list_alt),
          _buildNavItem(1, 'Kill Switch', Icons.warning_amber_rounded),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String title, IconData icon) {
    bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF6B8E23) : const Color(0xFF5D6D7E),
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? const Color(0xFF6B8E23) : const Color(0xFF5D6D7E),
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    ).animate(
      autoPlay: false,
      target: isSelected ? 1 : 0,
    )
        .scale(
      begin: const Offset(1, 1),
      end: const Offset(1.1, 1.1),
      duration: 300.ms,
      curve: Curves.easeInOut,
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _selectedIndex == 0 ? 'Index Configuration' : 'Kill Switch Configuration',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          if (_isEditingAllowed())
            ElevatedButton.icon(
              icon: AnimatedIcon(
                icon: AnimatedIcons.event_add,
                progress: _animationController,
              ),
              label: Text(_isEditing ? 'Cancel' : 'Edit'),
              onPressed: _toggleEditing,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isEditing ? const Color(0xFFE74C3C) : const Color(0xFF6B8E23),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIndexConfigView() {
    return ListView.builder(
      itemCount: _indexConfigs.length,
      itemBuilder: (context, index) {
        final config = _indexConfigs[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ExpansionTile(
            title: Text(config['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF2C3E50))),
            children: [
              _buildConfigItem('Max Quantity', config['maxQty'].toString()),
              _buildConfigItem('Default SL', config['defaultSL'].toString()),
              _buildConfigItem('Default Target', config['defaultTarget'].toString()),
            ],
          ),
        ).animate().fadeIn().scale();
      },
    );
  }

  Widget _buildKillSwitchConfigView() {
    return ListView.builder(
      itemCount: _killSwitchConfigs.length,
      itemBuilder: (context, index) {
        final config = _killSwitchConfigs[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            title: Text(config['haltPeriod'], style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))),
            subtitle: Text('Loss Percent: ${config['lossPercent']}%'),
            trailing: _isEditing
                ? IconButton(
              icon: const Icon(Icons.edit, color: Color(0xFF6B8E23)),
              onPressed: () => _showKillSwitchEditDialog(index),
            )
                : null,
          ),
        ).animate().fadeIn().scale();
      },
    );
  }

  Widget _buildConfigItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Color(0xFF34495E))),
          _isEditing
              ? SizedBox(
            width: 100,
            child: TextFormField(
              initialValue: value,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
            ),
          )
              : Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF6B8E23))),
        ],
      ),
    );
  }

  void _showKillSwitchEditDialog(int index) {
    final config = _killSwitchConfigs[index];
    TextEditingController lossPercentController = TextEditingController(text: config['lossPercent'].toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Kill Switch Config'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Halt Period: ${config['haltPeriod']}'),
              const SizedBox(height: 16),
              TextField(
                controller: lossPercentController,
                decoration: const InputDecoration(labelText: 'Loss Percent'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  config['lossPercent'] = double.parse(lossPercentController.text);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}