import 'package:flutter/material.dart';
import 'package:tem_test_app/constant/my_color.dart';

import 'fibonacci_screens/fibonacci_page.dart';
import 'file_upload_screens/file_home_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text("Home Page",
          style: TextStyle(
            color:Colors.white,
            fontWeight: FontWeight.bold,),),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white,size: 32),
      ),
      drawer: const Drawer(
        width: 200,
      ),
      body: Column(
        children: [
          InkWell(
          onTap: (){
             Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()));
    },
      child: Padding(
        padding: const EdgeInsets.only(top: 80,left: 20,right: 20,bottom: 20),
        child: Card(
          color: Colors.blueGrey,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: 50,

            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [mainColor,Colors.white60 ],
                begin: Alignment.topRight,
                end: Alignment.center,

              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            margin: EdgeInsets.all(7),
            child: const Center(
              child: Text(
                'File Upload',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,

                ),
              ),
            ),
          ),
        ),
      ),
    ),
          InkWell(
          onTap: (){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>FibonacciCalculator()));
    },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          color: Colors.blueGrey,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: 50,

            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [mainColor,Colors.white60 ],
                begin: Alignment.topRight,
                end: Alignment.center,

              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            margin: EdgeInsets.all(7),
            child: const Center(
              child: Text(
                'Fibonacci Calculator',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,

                ),
              ),
            ),
          ),
        ),
      ),
    ),
        ],
      ),

    );
  }
}
