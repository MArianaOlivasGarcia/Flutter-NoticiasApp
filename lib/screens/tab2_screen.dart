import 'package:flutter/material.dart';
import 'package:noticiasapp/models/category_model.dart';
import 'package:noticiasapp/providers/news_provider.dart';
import 'package:noticiasapp/theme/theme.dart';
import 'package:noticiasapp/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  
  final newsProvider = Provider.of<NewsProvider>(context);
  
    return Scaffold(
        body: Column(
      children: [
        _ListaCategorias(),

        if ( !newsProvider.isLoading )
            Expanded(
              child: ListaNoticias( newsProvider.getAticulosCategoriaSelecccionada )
            ),

        if ( newsProvider.isLoading )
        Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          )
        )

        ]
      )
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final categorias = Provider.of<NewsProvider>(context).categories;

    return Container(
      width: double.infinity,
      height: 105,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categorias.length,
        itemBuilder: (BuildContext context, int i) {
          final cName = categorias[i].name;

          return Container(
            child: Padding(
                padding: EdgeInsets.all(8),
                child: SafeArea(
                  child: Column(children: [
                    _CategoriaBoton(categorias[i]),
                    SizedBox(height: 5),
                    Text('${cName[0].toUpperCase()}${cName.substring(1)}')
                  ]),
                )),
          );
        },
      ),
    );
  }
}

class _CategoriaBoton extends StatelessWidget {
  final Category categoria;

  const _CategoriaBoton(this.categoria);

  @override
  Widget build(BuildContext context) {

    final newsProvider = Provider.of<NewsProvider>(context);


    return GestureDetector(
      onTap: () {
        final newsProvider = Provider.of<NewsProvider>(context, listen: false);
        newsProvider.selectedCategory = categoria.name;
      },
      child: Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Icon(categoria.icon, 
            color: ( newsProvider.selectedCategory == this.categoria.name )
              ? myTheme.accentColor
              : Colors.black54
            )
          ),
    );
  }
}
