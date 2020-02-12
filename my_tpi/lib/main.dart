import 'package:flutter/material.dart';
import 'package:my_tpi/Features/Home/HomePage.dart';
import 'package:my_tpi/Providers/ApplianceProvider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<IApplicationProvider>(
          create: (context) => ApplianceProvider(),
        ),
      ],
      child: MaterialApp(title: "myTPI", home: HomePage()),
    );
  }
}
