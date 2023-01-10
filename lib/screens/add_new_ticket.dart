import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import '../constants.dart';

class AddTicketPage extends StatefulWidget {
  const AddTicketPage({super.key});

  @override
  State<AddTicketPage> createState() => _AddTicketPageState();
}

class _AddTicketPageState extends State<AddTicketPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _desciptionController;
  late TextEditingController _numOrgController;
  late TextEditingController _locationController;
  late TextEditingController _countPremuimController;
  late TextEditingController _pricePremuimController;
  late TextEditingController _countStandardController;
  late TextEditingController _priceStandardController;
  late TextEditingController _timeController;
  late TextEditingController _dateController;
  bool _isPremuim = false;
  bool _isStandard = false;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  _initController() {
    _nameController = TextEditingController();
    _desciptionController = TextEditingController();
    _numOrgController = TextEditingController();
    _locationController = TextEditingController();
    _countPremuimController = TextEditingController();
    _pricePremuimController = TextEditingController();
    _timeController = TextEditingController();
    _dateController = TextEditingController();
    _countStandardController = TextEditingController();
    _priceStandardController = TextEditingController();
  }

  _disposeControllers() {
    _nameController.dispose();
    _desciptionController.dispose();
    _numOrgController.dispose();
    _locationController.dispose();
    _countPremuimController.dispose();
    _pricePremuimController.dispose();
    _timeController.dispose();
    _dateController.dispose();
    _countStandardController.dispose();
    _priceStandardController.dispose();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Add Ticket'),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: kPraimaryColor),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AppTextField(
                    title: 'Name of event',
                    maxLength: 250,
                    controller: _nameController),
                const SizedBox(height: 15),
                _AppTextField(
                  title: 'Description',
                  maxLines: 8,
                  hintText: 'Brief description',
                  controller: _desciptionController,
                ),
                const SizedBox(height: 15),
                _AppTextField(
                    title: 'Number of organization',
                    maxLength: 8,
                    controller: _numOrgController),
                const SizedBox(height: 15),
                const Text('Pick date and time',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PickerField(
                        controller: _dateController,
                        hint: 'Date',
                        onTap: _pickDate,
                        flex: 2),
                    const SizedBox(width: 30),
                    _PickerField(
                        controller: _timeController,
                        hint: 'Time',
                        onTap: _pickTime,
                        flex: 1),
                    const SizedBox(width: 30),
                  ],
                ),
                const SizedBox(height: 15),
                const Text('Categories',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                Row(
                  children: [
                    _Categorie(
                      isStandrad: true,
                      numController: _countStandardController,
                      priceController: _priceStandardController,
                      onChanged: (value) {
                        setState(() {
                          _isStandard = value!;
                        });
                        if (!_isStandard) {
                          _countStandardController.clear();
                          _priceStandardController.clear();
                        }
                      },
                      value: _isStandard,
                    ),
                    const SizedBox(width: 30),
                    _Categorie(
                      numController: _countPremuimController,
                      priceController: _pricePremuimController,
                      onChanged: (value) {
                        setState(() {
                          _isPremuim = value!;
                        });
                        if (!_isPremuim) {
                          _countPremuimController.clear();
                          _pricePremuimController.clear();
                        }
                      },
                      value: _isPremuim,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Center(
                  child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * .9,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: _submit,
                          child: const Text('Submit',
                              style: TextStyle(fontSize: 18)))),
                )
              ],
            ),
          )),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    CollectionReference tickets =
        FirebaseFirestore.instance.collection('tickets');
    String name = _nameController.text;
    String desciption = _desciptionController.text;
    int numOrg = int.parse(_numOrgController.text);
    int countPremuim = int.parse(_countPremuimController.text);
    int countStandard = int.parse(_countStandardController.text);
    int pricePremuim = int.parse(_pricePremuimController.text);
    int priceStandard = int.parse(_priceStandardController.text);

    tickets.add({
      'name': name,
      'desciption': desciption,
      'numOrg': numOrg,
      'countPremuim': countPremuim,
      'countStandard': countStandard,
      'pricePremuim': pricePremuim,
      'priceStandard': priceStandard,
      'date': _dateController.text,
      'user': user!.uid.toString()
    }).then((value) => {});
  }

  void _pickDate() async {
    final formatter = DateFormat('dd/MM/yyyy');
    final date = await showDatePicker(
        context: context,
        initialDate: _dateController.text.isEmpty
            ? DateTime.now()
            : formatter.parse(_dateController.text),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 10));
    if (date != null) {
      _dateController.text = formatter.format(date);
    }
  }

  void _pickTime() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      if (value != null) {
        _timeController.text = value.format(context);
      }
    });
  }
}

class _AppTextField extends StatelessWidget {
  const _AppTextField(
      {Key? key,
      required this.title,
      this.maxLines = 1,
      this.hintText,
      this.maxLength = 300,
      this.isEnabled = true,
      this.onTap,
      this.controller})
      : super(key: key);
  final String title;
  final int maxLines;
  final String? hintText;
  final int maxLength;
  final TextEditingController? controller;
  final bool isEnabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 15),
        TextFormField(
          onTap: onTap,
          readOnly: !isEnabled,
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              counterText: '',
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(8)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          maxLines: maxLines,
          maxLength: maxLength,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) =>
              value == null || value.isEmpty ? 'This field is required' : null,
        ),
      ],
    );
  }
}

class _PickerField extends StatelessWidget {
  const _PickerField(
      {Key? key,
      required this.onTap,
      required this.hint,
      this.controller,
      this.flex = 1})
      : super(key: key);
  final VoidCallback onTap;
  final String hint;
  final TextEditingController? controller;
  final int flex;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: TextFormField(
        onTap: onTap,
        readOnly: true,
        controller: controller,
        validator: (value) =>
            value == null || value.isEmpty ? 'This field is required' : null,
        decoration: InputDecoration(
            hintText: hint,
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(8)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      ),
    );
  }
}

class _Categorie extends StatelessWidget {
  const _Categorie({
    Key? key,
    required this.value,
    required this.numController,
    required this.priceController,
    required this.onChanged,
    this.isStandrad = false,
  }) : super(key: key);
  final bool value;
  final TextEditingController numController;
  final TextEditingController priceController;
  final ValueSetter<bool?> onChanged;
  final bool isStandrad;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          ListTileTheme(
            horizontalTitleGap: 0,
            child: CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(isStandrad ? 'Standard' : 'Premuim'),
                value: value,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: onChanged),
          ),
          TextFormField(
            controller: numController,
            keyboardType: TextInputType.number,
            enabled: value,
            decoration: InputDecoration(
                hintText: 'Number of ticket',
                disabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(8)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
            validator: (value) =>
                value != null && RegExp(r'\d+').hasMatch(value)
                    ? null
                    : 'Wrong value',
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: priceController,
            keyboardType: TextInputType.number,
            enabled: value,
            decoration: InputDecoration(
                hintText: 'Price of ticket',
                disabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(8)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
            validator: (value) =>
                value != null && RegExp(r'\d+').hasMatch(value)
                    ? null
                    : 'Wrong value',
          ),
        ],
      ),
    );
  }
}
