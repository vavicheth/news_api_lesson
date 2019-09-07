import 'package:flutter/material.dart';
import 'package:news_api_lession/models/news_model.dart';

class NewsDetail extends StatefulWidget {
  Article news;
  NewsDetail({this.news});

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
//  var newsdetail = widget.news;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.news.title),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    Article newsdetail = widget.news;
    return Container(
      padding: EdgeInsets.all(5.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300.0,
              child: Image.network(
                newsdetail.urlToImage,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5.0),
              child: Text(
                newsdetail.title,
                style: TextStyle(color: Colors.orange, fontSize: 22.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5.0),
              child: Text(
                newsdetail.description,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'Author: ${newsdetail.author}',
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 16.0,
                    fontStyle: FontStyle.italic),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'Source: ${newsdetail.source.name}',
                style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
