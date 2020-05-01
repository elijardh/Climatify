import 'package:flutter/material.dart';


class changecity extends StatefulWidget {
  @override
  _changecityState createState() => _changecityState();
}

class _changecityState extends State<changecity> {

  void test(String weather){

  }

  var cityfieldcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text('Climaify'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.asset('asset/lit.jpg', fit: BoxFit.fill,width: 500, height: MediaQuery.of(context).size.height,),
              Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 200.0)),
                  TextField(
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: 'Enter The City',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white,style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(80.0))),
                    controller: cityfieldcontroller,


                  ),
                  SizedBox(height: 250.0,),
                  IconButton(icon: Icon(Icons.add_circle, color: Colors.blue, size: 40.0,), onPressed:() {
                    Navigator.pop(context, {
                      'enter': cityfieldcontroller.text
                    });}),
//                  Align(
//                    child: FloatingActionButton(onPressed: () {
//                      Navigator.pop(context, {
//                        'enter': cityfieldcontroller.text
//                      });},
//                      child: Icon(Icons.search),),
//                  )
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }
}
