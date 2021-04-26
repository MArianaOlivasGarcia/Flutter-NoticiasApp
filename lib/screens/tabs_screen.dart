import 'package:flutter/material.dart';
import 'package:noticiasapp/screens/tab1_screen.dart';
import 'package:noticiasapp/screens/tab2_screen.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavigationModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
      currentIndex: navigationModel.paginaActual,
      onTap: (i) => navigationModel.paginaActual = i,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'Para ti'),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Encabezados')
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavigationModel>(context);

    return PageView(
        controller: navegacionModel.pageController,
        physics: BouncingScrollPhysics(),
        onPageChanged: (i) => navegacionModel.paginaActual = i,
        children: [
          
          Tab1Screen(),

          Tab2Screen()
        
        ]);
  }
}

class _NavigationModel with ChangeNotifier {
  int _paginaActual = 0;
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;
  PageController get pageController => this._pageController;


  set paginaActual(int valor) {
    this._paginaActual = valor;
    _pageController.animateToPage( valor, duration: Duration( milliseconds: 250), curve: Curves.easeOut );
    notifyListeners();
  }

}
