import 'package:flutter/material.dart';
import 'package:my_tpi/Providers/ApplianceProvider.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Start Insepction")),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : RaisedButton(
                child: Text(
                  "Create",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () => _saveInspection(context),
              ),
      ),
    );
  }

  Future<void> _saveInspection(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    var applianceProvider = Provider.of<IApplicationProvider>(context);
    await applianceProvider.createNewInspection("text");
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
  }
}
