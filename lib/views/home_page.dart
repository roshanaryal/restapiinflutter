import 'package:flutter/material.dart';
import 'package:restapiinflutter/model/Post.dart';
import 'package:restapiinflutter/services/remote_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post>? postList;
  bool isDataLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //load data
    getData();
  }

  getData() async {
    postList = await RemoteServices().getPosts();
    if (postList != null) {
      setState(() {
        isDataLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest api in flutter"),
        centerTitle: true,
      ),
      body: isDataLoaded
          ? ListView.builder(
              itemCount: postList?.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: InkWell(
                    onTap: () {},
                    child: Column(children: [
                      Text(
                        postList![index].title.toString().trimLeft(),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(postList![index].body.toString().trimLeft(),
                          maxLines: 3,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal))
                    ]),
                  ),
                );
              })
          : Center(
              child: CircularProgressIndicator(
                strokeWidth: 3.0,
                color: Colors.red,
              ),
            ),
    );
  }
}
