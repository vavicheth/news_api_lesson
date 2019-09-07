import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:news_api_lession/helper/internet_check_helper.dart';
import 'package:news_api_lession/helper/internet_check_ui_helper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_api_lession/models/news_model.dart' as nm;
import 'package:news_api_lession/screens/newsdetail.dart';
import 'package:page_transition/page_transition.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  Future<bool> _internetOn;
  String url;

  @override
  void initState() {
    super.initState();
    _internetOn = checkInternet();
    url =
        "https://newsapi.org/v2/everything?q=bitcoin&apiKey=019b09431ea94a32a56d6f8978b7f36f";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      appBar: _buildAppBar(),
      body: _buildInternetBody(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  _buildDrawer() {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg_drawer_01.jpg"),
              fit: BoxFit.cover),
        ),
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                child: Container(
              padding: EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/Logo.png")),
              ),
            )),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onTap: () {
                //TODO: press home menu
                print("Home clicked!");
              },
            ),
            ListTile(
              leading: Icon(
                Icons.chrome_reader_mode,
                color: Colors.white,
              ),
              title: Text(
                "Documents",
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onTap: () {
                //TODO: press document menu
                print("Document clicked!");
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Container(
          alignment: Alignment.center,
          child: Text(
            "FLASH NEWS",
            style: TextStyle(color: Colors.orangeAccent),
          )),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.power_settings_new),
          onPressed: () {
            //TODO: Press logout
          },
        ),
      ],
    );
  }

  _buildBottomBar() {
    return CurvedNavigationBar(
      color: Colors.black87,
      backgroundColor: Colors.orangeAccent,
      items: <Widget>[
        Icon(Icons.home, size: 30),
        Icon(Icons.calendar_today, size: 30),
        Icon(Icons.language, size: 30),
        Icon(Icons.settings, size: 30),
      ],
      onTap: (index) {
        setState(() {
          if (index == 1) {
            url =
                'https://newsapi.org/v2/everything?q=apple&from=2019-08-31&to=2019-08-31&sortBy=popularity&apiKey=019b09431ea94a32a56d6f8978b7f36f';
          } else if (index == 2) {
            url =
                'https://newsapi.org/v2/everything?domains=wsj.com,nytimes.com&apiKey=019b09431ea94a32a56d6f8978b7f36f';
          } else {
            url =
                'https://newsapi.org/v2/everything?q=bitcoin&apiKey=019b09431ea94a32a56d6f8978b7f36f';
          }
        });
      },
    );
  }

  _buildInternetBody() {
    return buildInternetChecking(internetOn: _internetOn, body: _buildBody());
  }

  _buildBody() {
//    String url =
//        "https://newsapi.org/v2/everything?q=bitcoin&apiKey=019b09431ea94a32a56d6f8978b7f36f";
    return Container(
//      color: Colors.white,
      child: FutureBuilder<nm.NewsRequest>(
        future: nm.getData(url),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot.connectionState);
            if (snapshot.hasData) {
              print(snapshot.data);
              nm.NewsRequest newsRequest = snapshot.data;
              return _buildListView(newsRequest.articles);
            } else {
              return Center(
                  child: SpinKitRing(
                color: Colors.orangeAccent,
                size: 50.0,
              ));
            }
          } else {
            print(snapshot.connectionState);
            return Center(
                child: SpinKitRing(
              color: Colors.orangeAccent,
              size: 50.0,
            ));
          }
        },
      ),
    );
  }

  var _scroll = ScrollController();

  _buildListView(List<nm.Article> articlesList) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: ListView.builder(
              controller: _scroll,
              itemCount: articlesList.length,
              itemBuilder: (context, index) {
                return _buildListViewItem(articlesList[index]);
              }),
        ),
        Positioned(
            bottom: 20.0,
            right: 10.0,
            child: InkWell(
              onTap: () {
                _scroll.animateTo(0.0,
                    duration: Duration(seconds: 1), curve: Curves.easeInOut);
              },
              child: Container(
                alignment: Alignment.center,
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white54.withOpacity(0.5),
                ),
                child: Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.orange,
                  size: 25.0,
                ),
              ),
            )),
      ],
    );
  }

  _buildListViewItem(nm.Article articlesItem) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250.0,
      margin: EdgeInsets.only(bottom: 5.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: NewsDetail(
                    news: articlesItem,
                  )));
        },
        child: Container(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 240.0,
                    child: Image.network(
                      articlesItem.urlToImage,
                      fit: BoxFit.cover,
                    ),
//            child: Image.network(articlesItem.urlToImage),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(5.0),
                height: 80.0,
                color: Colors.black.withOpacity(0.5),
                child: Text(
                  articlesItem.title,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
