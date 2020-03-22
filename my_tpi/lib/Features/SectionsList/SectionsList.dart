import 'package:flutter/material.dart';
import 'package:my_tpi/Models/Appliance.dart';

class SectionsList extends StatelessWidget {
  final Appliance model;
  SectionsList(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${model.assetNumber}")),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
          itemCount: model.sections.length ?? 0,
          itemBuilder: (context, index) {
            return InkWell(
              child: Card(
                child: ListTile(
                  title: Text("${model.sections[index].title}"),
                  subtitle: Text(""),
                ),
              ),
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}
