
import 'package:flutter/material.dart';
import 'package:noticiasapp/providers/news_provider.dart';
import 'package:noticiasapp/screens/tabs_screen.dart';
import 'package:noticiasapp/theme/theme.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (_) => new NewsProvider() )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: myTheme,
        title: 'Material App',
        home: TabsScreen()
      ),
    );

  }
}