import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_tpi/Features/Add/AddPage.dart';
import 'package:my_tpi/Features/SectionsList/SectionsList.dart';
import 'package:my_tpi/Models/Appliance.dart';
import 'package:my_tpi/Providers/ApplianceProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "My Inspections",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontSize: 22.0,
          ),
        ),
      ),
      backgroundColor: Colors.blue.shade200,
      body: SafeArea(
        bottom: false,
        child: Material(
           color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(45.0),
            topLeft: Radius.circular(45.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: RefreshIndicator(
                  child: getBody(context), onRefresh: () => _refresh(context)),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.blue,
          onPressed: () => _navigateToAdd(context),
          label: Text("Start Inspection"),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget getBody(BuildContext context) {
    var applianceProvider = Provider.of<IApplicationProvider>(context);
    final list = applianceProvider.inspections;

    if (list == null) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade300),
      );
    }
    if (list.isEmpty) {
      // return Text("No Data!");
      return Center(
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[],
            ),
            Center(child: Text("No Data!"))
          ],
        ),
      );
    }
    return SafeArea(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        itemCount: list.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            child: Card(
              elevation: 0,
              child: ListTile(
                title: Text("${list[index].assetNumber}"),
                subtitle: Text(
                    "${DateFormat('EEE, dd MMM yy').format(list[index].date)}"),
              ),
            ),
            onLongPress: () => _deleteWithId(list[index].id, context),
            onTap: () => _navigateToSections(list[index], context),
          );
        },
      ),
    );
  }

  Future<void> _deleteWithId(String id, BuildContext context) async {
    var applianceProvider = Provider.of<IApplicationProvider>(context);
    await applianceProvider.deleteInspection(id);

    final snackBar = SnackBar(
      content: Text('Inspection Deleted: "$id"'),
      backgroundColor: Colors.red.shade400,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Future<void> _refresh(BuildContext context) async {
    var applianceProvider = Provider.of<IApplicationProvider>(context);
    await applianceProvider.updateInspectionList();
  }

  void _navigateToAdd(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPage()),
    );
  }

  void _navigateToSections(Appliance model, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SectionsList(model)),
    );
  }
}
