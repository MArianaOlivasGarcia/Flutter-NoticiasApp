import 'package:flutter/material.dart';
import 'package:noticiasapp/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';
import 'package:noticiasapp/providers/news_provider.dart';

class Tab1Screen extends StatefulWidget {
  @override
  _Tab1ScreenState createState() => _Tab1ScreenState();
}

/* Mantener el Stado del Widget con AutomaticKeepAliveClientMixin */
class _Tab1ScreenState extends State<Tab1Screen> with AutomaticKeepAliveClientMixin {


  @override
  Widget build(BuildContext context) {
    final headlines = Provider.of<NewsProvider>(context).headlines;

    return Scaffold(
      body: ( headlines.length == 0 )
          ? Center ( child: CircularProgressIndicator() )
          : ListaNoticias( headlines )
    );
  }

  @override
  /* Puedo poner condiciones cuando no quier que mantenga el stado
  destruirlo con null */
  bool get wantKeepAlive => true;


  
  
}
