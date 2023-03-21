import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novindus_machine_test/Api/Api.dart';
import 'package:novindus_machine_test/Model/NewsCategoryDetailsModel.dart';
import 'package:novindus_machine_test/Model/NewsCategoryModel.dart';
import 'package:novindus_machine_test/Provider/Provider.dart';
import 'package:novindus_machine_test/Ui/NewsDetailedScreen.dart';
import 'package:novindus_machine_test/Ui/ReadMoreScreen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  NewsCategoryModel selectedCat = new NewsCategoryModel();
  int currentIndex = 0;
  List<NewsCategoryDetailsModel> newsDetailsList = [];

  @override
  void initState() {
    Provider.of<DataProvider>(context, listen: false).getCategories(context).then((value){
      selectedCat =  Provider.of<DataProvider>(context, listen: false).newsCategoryList[0];

      Provider.of<DataProvider>(context, listen: false).getCategoryData(
          context,selectedCat.id.toString()).then((value){
            newsDetailsList =  Provider.of<DataProvider>(context, listen: false).newsCategoryDetailsList;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, dataProvider, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text("News & Blogs", style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),),
          bottom: PreferredSize(
            preferredSize: Size(100,70),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                physics: ScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: dataProvider.newsCategoryList.length,
                itemBuilder: (BuildContext context, int position) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  selectedCat = dataProvider.newsCategoryList[position];
                                  dataProvider.getCategoryData(context, selectedCat.id.toString());
                                });
                              },
                              child: Text(dataProvider.newsCategoryList[position].name.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: selectedCat==dataProvider.newsCategoryList[position]?
                                    Colors.green:
                                    Colors.black
                                ),),
                            ),
                            Visibility(
                                visible: selectedCat == dataProvider.newsCategoryList[position],
                                child: Icon(Icons.arrow_drop_up,color: Colors.green,))
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Visibility(
                visible: selectedCat.id == 0,
                  child: SizedBox(height: 10,)),
              Stack(
                children: [
                  Visibility(
                    visible: selectedCat.id == 0,
                    child: CarouselSlider(
                      // items: banners(),
                      items: newsDetailsList
                          .map((item) => InkWell(
                        onTap: () {},
                        child: Container(
                          child: CachedNetworkImage(
                              imageUrl: Api.IMAGE_BASE_URL+ item.image.toString(),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    decoration: new BoxDecoration(
                                      color: Colors.blueGrey,
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                              placeholder: (context, url) => Container(
                                height: 200,
                                width: 50,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.green,
                                  ),
                                ),
                              ),

                          ),
                        ),
                      ))
                          .toList(),
                      options: CarouselOptions(
                        height: 200,
                        viewportFraction: 1,
                        enableInfiniteScroll: true,
                        onPageChanged: (index, reason) {
                          setState(
                                () {
                            },
                          );
                        },
                      ),)
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 15.0,right:15,top: 8 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("🔥 Latest News",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ReadMoreScreen(selectedCat)));
                      },
                      child: Text("Read more",style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold
                      ),),
                    )
                  ],
                ),
              ),
              dataProvider.isDataLoading?
              Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              ):
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dataProvider.newsCategoryDetailsList.length,
                  itemBuilder: (BuildContext context, int position) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: Colors.grey[350],
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    NewsDetailedScreen(dataProvider.newsCategoryDetailsList[position])));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Hero(
                              tag: 'myHeroTag',
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(
                                        10.0),
                                    child: Image.network(
                                      width: MediaQuery.of(context).size.width,
                                      height: 150,
                                      Api.IMAGE_BASE_URL+ dataProvider.newsCategoryDetailsList[position].image.toString(),
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text(dataProvider.newsCategoryDetailsList[position].title.toString(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
    );
    }
  }
