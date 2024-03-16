import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/my_color.dart';

class FibonacciCalculator extends StatefulWidget {
  @override
  _FibonacciCalculatorState createState() => _FibonacciCalculatorState();
}

class _FibonacciCalculatorState extends State<FibonacciCalculator> {
  TextEditingController _controller = TextEditingController();
  String _fibonacciResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff62b5eb),
        title: Text('Fibonacci Calculator',style: TextStyle(
          color:Colors.white,
          fontWeight: FontWeight.bold,),),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white,size: 32),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _controller,
              keyboardType: TextInputType.number,
              cursorColor: Color(0xff62b5eb),
              decoration: InputDecoration(
                focusedBorder:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey,width: 2),
                    borderRadius: BorderRadius.circular(15)
                ),
                prefixIcon: const Icon(Icons.calculate_outlined,color: Colors.grey,),
                labelText: "Enter position",
                labelStyle: TextStyle(fontSize:20,color: Color(0xff62b5eb),fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: BorderSide(color: Colors.black54),
                ),

              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                maximumSize: Size(120, 50),
                backgroundColor: mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
              onPressed: () {
                setState(() {
                  int position = int.tryParse(_controller.text) ?? 0;
                  _fibonacciResult = fibonacci(position).toString();
                });
              },
              child: Text('Calculate',style: TextStyle(color: Colors.white),),
            ),
            SizedBox(height: 20.0),
            Text(
              'Fibonacci result: $_fibonacciResult',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }

  int fibonacci(int n, {Map<int, int>? memo}) {
    memo ??= {};
    if (memo.containsKey(n)) {
      return memo[n]!;
    }
    if (n <= 0) {
      return 0;
    } else if (n == 1) {
      return 1;
    } else {
      int fibValue =
          fibonacci(n - 1, memo: memo) + fibonacci(n - 2, memo: memo);
      memo[n] = fibValue;
      return fibValue;
    }
  }
}