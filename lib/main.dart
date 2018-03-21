import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'places.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Restos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _places = <String>[];
  Map<String,double> _ourPlace;

  @override
  initState() {
    super.initState();
    _places = new List<String>();
    listenForLocation();
    _places = new List.generate(100, (r) => 'Resto $r');    
  }

  listenForLocation() async {
    _ourPlace = await getCurrentLocation();
    print(_ourPlace.values);
  }


  @override
  Widget build(BuildContext context) {
   
    return new Scaffold(
      appBar: new AppBar(       
        title: new Text(widget.title),
      ),
      body: new Center(        
        
        child: new Text(_ourPlace["latitude"].toString() + " " + _ourPlace["longitude"].toString())
      //   child: new ListView(
      //     children: _places.map((r) => new Text(r["latitude"])).toList(),
      // )
    ),
  );
  }
}
