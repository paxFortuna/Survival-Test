import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'result/result_screen.dart';

class BmiMainScreen extends StatefulWidget {
  const BmiMainScreen({super.key});

  @override
  State<BmiMainScreen> createState() => _BmiMainScreenState();
}

class _BmiMainScreenState extends State<BmiMainScreen> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    load();
  }
  @override
  void dispose() {
    super.dispose();
    _heightController.dispose();
    _weightController.dispose();
  }

  Future save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('height', double.parse(_heightController.text));
    await prefs.setDouble('weight', double.parse(_weightController.text));
  }

  Future load() async {
    final prefs = await SharedPreferences.getInstance();
    final double? height = prefs.getDouble('height');
    final double? weight = prefs.getDouble('weight');

    if(height != null && weight != null){
      _heightController.text = '$height';
      _weightController.text = '$weight';
      debugPrint('키: $height');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BMI 계산기')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: _heightController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '키',
                ),
                keyboardType: TextInputType.number,

                onSaved: (value) {
                  value = _heightController.text;
                },
                onChanged: (value) {
                  value = _heightController.text;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '키를 입력하세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '몸무게',
                ),
                keyboardType: TextInputType.number,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '몸무게를 입력하세요';
                  }
                  return null;
                },
                onSaved: (value) {
                  value = _weightController.text;
                },
                onChanged: (value) {
                  value = _weightController.text;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == false) {
                    return;
                  }
                  save();
                  // liveTemp : navpush
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder:
                    (context) => ResultScreen(
                      height: double.parse(_heightController.text),
                      weight: double.parse(_weightController.text),
                      // height: 160.8,
                      // weight: 80.4,
                    )),
                    );
                  // Get.to(() => ResultScreen(
                  //   // height: double.parse(_heightController.text),
                  //   // weight: double.parse(_weightController.text),
                  //   height: 160.8,
                  //   weight: 48.4,
                  // ));
                },
                child: Text('결과'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
