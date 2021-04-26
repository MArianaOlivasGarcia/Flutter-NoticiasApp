import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noticiasapp/models/category_model.dart';
import 'package:noticiasapp/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL = 'https://newsapi.org/v2';
final _APIKEY = 'e578b81ff47b49c988568bb5c245ae63';

class NewsProvider with ChangeNotifier {

  List<Article> headlines = [];
  String _selectedCategory = 'business';

  bool _isLoading = true;

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  /* Almacenar lo que trae el getArticlesByCategory */
  Map<String, List<Article>> categoryArticles = {};

  NewsProvider() {
    this.getTopHeadlines();

    /* Barrer el arreglo de categorias y para crear
     la llave del map con el nombre de la categori */
    categories.forEach((cat) {
      this.categoryArticles[cat.name] = [];
    });

    this.getArticlesByCategory(this._selectedCategory);
  }

  bool get isLoading => this._isLoading;

  get selectedCategory => this._selectedCategory;

  set selectedCategory(String valor) {
    this._selectedCategory = valor;

    this._isLoading = true;
    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> get getAticulosCategoriaSelecccionada =>
      this.categoryArticles[this.selectedCategory];

  getTopHeadlines() async {
    final url = '$_URL/top-headlines?apiKey=$_APIKEY&country=mx';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    /* Si ya tengo la data no quiero insertar duplicados */
    if (this.categoryArticles[category].length > 0) {
      this._isLoading = false;
      notifyListeners();
      return this.categoryArticles[category];
    }

    final url =
        '$_URL/top-headlines?apiKey=$_APIKEY&country=mx&category=$category';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);

    /* Insertar los articles en la categoria correspondient a la llave del map */
    this.categoryArticles[category].addAll(newsResponse.articles);

    this._isLoading = false;
    notifyListeners();
  }
}
