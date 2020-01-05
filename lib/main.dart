import 'dart:convert';
import 'package:tiquotes/HexColor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:math';
import 'package:toast/toast.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Random Quotes',
  theme: ThemeData(
    primaryColor: Colors.grey[900],
  ),
  home: Home(),
));

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Random rnd = new Random();
  Map data =  {
      'quote':''
  };

  Map photo = {
    'backgroundUrl' : 'https://images.pexels.com/photos/3408744/pexels-photo-3408744.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    'color' : '#3C3C3C'
  };



  Future<void> getData() async{
    Response response = await get('https://api.kanye.rest/');
    Map contents =jsonDecode(response.body);
    setState(() {
      data = {
        'quote' : contents['quote']
      };
    });
  }

  Future<void> getPhotos() async{
    Response response = await get('https://api.unsplash.com//photos/random/?client_id=826b6240f161adb9c7fdb75985a27713828dac61748440fdf3d343f1d5133b23');
    setState(() {
      if(response.body != 'Rate Limit Exceeded'){
        Map photos = jsonDecode(response.body);
        Map urls = photos['urls'];
        photo = {
          'backgroundUrl' : urls['regular'],
          'color' : photos['color']
        };
      }
      else{
        Toast.show("Daily Rate Limit Exceeded", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      }
    });
  }


  @override
  void initState() {

    super.initState();
    getData();
    getPhotos();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('~Kanye West Quotes~', style: TextStyle(fontSize: 20.0, color: Colors.grey[400], fontFamily: 'Vegan', letterSpacing: 1.2),),
              SizedBox(height: 7.0,),
              Flexible(
                child: Container(
                  width:  400,
                  height: 500,
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Colors.grey[200],
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(15),
                      ),
                    child: Stack(
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                              Image(image: NetworkImage(photo['backgroundUrl']), height: double.infinity,width: double.infinity, fit: BoxFit.cover,),
                              Container(
                              color: Colors.grey[900].withOpacity(0.5),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.whatshot, color: Colors.white, size: 45.0,),
                                    Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: RichText(
                                        text: TextSpan(
                                          text:data['quote'],
                                          style: TextStyle(color: Colors.white, fontSize: 25.0, fontFamily: 'Vegan', letterSpacing: 2.0 ,height: 1.1 ),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    ],
                                  ),
                                ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ),
                  ),
              ),
              SizedBox(height: 20.0,),
              FloatingActionButton(
                child: Icon(Icons.refresh),
                backgroundColor: HexColor(photo['color']),
                onPressed: (){
                  getData();
                  getPhotos();
                },
              ),
                ],
              ),
        ),
        ),
      );
  }
}
