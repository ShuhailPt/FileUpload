import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constant/my_color.dart';
import '../../controller/main_provider.dart';
import 'file_upload_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of<MainProvider>(context, listen: false);
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/12,),
            const Image(image: AssetImage("assets/home.png")),
            const SizedBox(height: 5,),
            const Text("Upload File",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),),
            const Text("Choose the file you want to Upload",style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black26,
              fontSize: 16,
            ),),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                provider.clearMethod();
                Navigator.push(context, MaterialPageRoute(builder: (context)=> FileUploadPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(18),
              ),
              child: const Icon(Icons.arrow_forward,color: Colors.white,),
            )

          ],
        ),
      ),
    );
  }
}
