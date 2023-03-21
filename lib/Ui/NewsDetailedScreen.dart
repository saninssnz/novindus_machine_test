import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:novindus_machine_test/Api/Api.dart';
import 'package:novindus_machine_test/Model/NewsCategoryDetailsModel.dart';
import 'package:novindus_machine_test/Utils/Utils.dart';

class NewsDetailedScreen extends StatefulWidget {
  NewsDetailedScreen(this.newsdata);
  NewsCategoryDetailsModel newsdata = NewsCategoryDetailsModel();

  @override
  _NewsDetailsedScreenState createState() => _NewsDetailsedScreenState();
}

class _NewsDetailsedScreenState extends State<NewsDetailedScreen> {

  String formatDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    DateFormat formatter = DateFormat('MMMM d, yyyy');
    String formatted = formatter.format(date);
    return formatted;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_circle_left_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Hero(
              tag: 'myHeroTag',
              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(
                    15.0),
                child: Image.network(
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  Api.IMAGE_BASE_URL+ widget.newsdata.image.toString(),
                  fit: BoxFit.fill,
                  loadingBuilder: (BuildContext
                  context,
                      Widget child,
                      ImageChunkEvent?
                      loadingProgress) {
                    if (loadingProgress ==
                        null) return child;
                    return Container(
                      width: 90,
                      height: 90,
                      child: Center(
                        child:
                        CircularProgressIndicator(
                          color:
                          Colors.green,
                          value: loadingProgress
                              .expectedTotalBytes !=
                              null
                              ? loadingProgress
                              .cumulativeBytesLoaded /
                              loadingProgress
                                  .expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(widget.newsdata.title.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[350],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15),
              child: Row(
                children: [
                  Text(
                    "Updated: " +  Utils.formatDate(widget.newsdata.createdAt.toString().split(" ")[0]) +
                    " " + Utils.formatTime(widget.newsdata.createdAt.toString().split(" ")[1]) +
                    " " + Utils.isAm(widget.newsdata.createdAt.toString().split(" ")[1]),
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(widget.newsdata.content.toString()),
          )
        ],
      ),
    );
  }
}
