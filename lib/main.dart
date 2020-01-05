import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:math';

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

  List<String> backgroundList = [
    'https://images.pexels.com/photos/3363341/pexels-photo-3363341.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    'https://images.pexels.com/photos/3336152/pexels-photo-3336152.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/3323694/pexels-photo-3323694.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/3312242/pexels-photo-3312242.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    'https://images.pexels.com/photos/3310822/pexels-photo-3310822.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    'https://images.pexels.com/photos/433142/pexels-photo-433142.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    'https://images.pexels.com/photos/2416871/pexels-photo-2416871.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    'https://images.pexels.com/photos/2827609/pexels-photo-2827609.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
  ];

  Random rnd = new Random();

  Map data =  {
      'backgroundUrl': '',
      'quote':''
  };


  Future<void> getData() async{
    Response response = await get('https://api.kanye.rest/');
    Map contents =jsonDecode(response.body);
    print(contents['quote']);
    int random_index = 0 + rnd.nextInt(6);
    setState(() {
      data = {
        'quote' : contents['quote'],
        'backgroundUrl' : backgroundList[random_index]
      };
      print(data);
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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
              Text('Kanye West Quotes', style: TextStyle(fontSize: 20.0, color: Colors.grey[400], fontFamily: 'Vegan', letterSpacing: 1.0),),
              SizedBox(height: 7.0,),
              Flexible(
                child: Container(
                  width:  400,
                  height: 400,
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Colors.grey[200],
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(10),
                      ),
                    child: Stack(
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[

                              Image(image: NetworkImage(data['backgroundUrl']), height: double.infinity,width: double.infinity, fit: BoxFit.cover,),
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
                                          text: data['quote'],
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
                backgroundColor: Colors.grey[800],
                onPressed: (){
                  getData();
                },
              ),
                ],
              ),
        ),
        ),
      );
  }
}
