import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novindus_machine_test/Api/Api.dart';
import 'package:novindus_machine_test/Model/NewsCategoryModel.dart';
import 'package:novindus_machine_test/Provider/Provider.dart';
import 'package:provider/provider.dart';

class ReadMoreScreen extends StatefulWidget {
  ReadMoreScreen(this.selectedCat);
  NewsCategoryModel selectedCat = new NewsCategoryModel();

  @override
  _ReadMoreScreenState createState() => _ReadMoreScreenState();
}

class _ReadMoreScreenState extends State<ReadMoreScreen> {

  @override
  void initState() {

      Provider.of<DataProvider>(context, listen: false).getCategoryData(context,widget.selectedCat.id.toString());

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, dataProvider, child)
    {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
          title: Text("Latest News", style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),

              ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: dataProvider.newsCategoryDetailsList.length,
                itemBuilder: (BuildContext context, int position) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                          BorderRadius.circular(
                              15.0),
                          child: Image.network(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: 150,
                            Api.IMAGE_BASE_URL +
                                dataProvider.newsCategoryDetailsList[position].image
                                    .toString(),
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
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(dataProvider.newsCategoryDetailsList[position].title
                              .toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
    );
    }
  }
