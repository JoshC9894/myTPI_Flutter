import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_tpi/Features/SectionsList/SectionsList.dart';
import 'package:my_tpi/Helpers/ApplianceTypeHelper.dart';
import 'package:my_tpi/Models/CreateApplianceDTO.dart';
import 'package:my_tpi/Providers/ApplianceProvider.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectedType;
  DateTime _selectedDate = DateTime.now();
  TextEditingController _assetController = TextEditingController();
  TextEditingController _serialController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.blue.shade400,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Start Inspection",
          style: TextStyle(
            fontFamily: "Helvetica",
            fontWeight: FontWeight.w500,
            color: Colors.blue.shade400,
            fontSize: 22.0,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Material(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: createForm(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: FloatingActionButton(
          backgroundColor: Colors.blue.shade400,
          onPressed: () => _saveInspection(context),
          child: Icon(Icons.check),
        ),
      ),
    );
  }

  Future<void> _displayDatePicker(BuildContext context) async {
    final DateTime _date = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2019, 1, 1),
        lastDate: DateTime.now());

    if (_date != null)
      setState(() {
        _selectedDate = _date;
        _dateController.text =
            "${DateFormat('EEE, dd MMM yy').format(_selectedDate)}";
      });
  }

  String _validateSerialNumber(String value) {
    if (value.isEmpty) return "Serial number required";
    return null;
  }

  String _validateApplianceType(String value) {
    if (value == null || value.isEmpty) return "Appliance type required";
    return null;
  }

  Future<void> _saveInspection(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final form = _formKey.currentState;

    if (form.validate()) {
      var applianceProvider = Provider.of<IApplicationProvider>(context);
      var dto = CreateApplianceDTO(
          date: _selectedDate,
          assetNumber: _assetController.text,
          serialNumber: _serialController.text,
          typeId: ApplianceTypeHelper.getRawValueFromString(_selectedType));
      var newInspection = await applianceProvider.createNewInspection(dto);
      Navigator.pop(context);
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => SectionsList(newInspection)),
      // );
    }
    setState(() {
      isLoading = false;
    });
  }

  List<Widget> _createDropdown() {
    return ApplianceTypeHelper.appliances.map((ApplianceType value) {
      return new DropdownMenuItem<String>(
        value: ApplianceTypeHelper.getDescription(value),
        child: new Text(ApplianceTypeHelper.getDescription(value)),
      );
    }).toList();
  }

  Widget createForm() {
    return Form(
      key: _formKey,
      autovalidate: false,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              hint: Text('Please choose an appliance type'),
              value: _selectedType,
              items: _createDropdown(),
              validator: _validateApplianceType,
              onChanged: (String newValue) {
                setState(() {
                  _selectedType = newValue;
                });
              },
            ),
          ),
          TextFormField(
            controller: _assetController,
            decoration: const InputDecoration(
              hintText: 'Enter an asset number',
              labelText: 'Asset No.:',
            ),
          ),
          TextFormField(
            controller: _serialController,
            decoration: const InputDecoration(
              hintText: 'Enter a serial number',
              labelText: 'Serial No.: *',
            ),
            validator: _validateSerialNumber,
          ),
          TextFormField(
            controller: _dateController,
            decoration: const InputDecoration(
              hintText: 'Select an inspection date',
              labelText: 'Inspection Date: *',
            ),
            validator: _validateSerialNumber,
            onTap: () => _displayDatePicker(context),
          ),
        ],
      ),
    );
  }
}
