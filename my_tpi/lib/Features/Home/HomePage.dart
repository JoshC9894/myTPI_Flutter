import 'package:flutter/material.dart';
import 'package:my_tpi/Features/Add/AddPage.dart';
import 'package:my_tpi/Providers/ApplianceProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(title: Text("Appliance Inspections")),
      body: Center(
          child: RefreshIndicator(
              child: getBody(context), onRefresh: () => _refresh(context))),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () => _navigateToAdd(context)),
    );
  }

  Widget getBody(BuildContext context) {
    var applianceProvider = Provider.of<IApplicationProvider>(context);
    final list = applianceProvider.inspections;

    if (list == null) {
      return CircularProgressIndicator();
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
              child: ListTile(
                title: Text("${list[index].name}"),
                subtitle: Text("${list[index].date}"),
              ),
            ),
            onLongPress: () => _deleteWithId(list[index].id, context),
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
}
