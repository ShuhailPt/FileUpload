
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:video_player/video_player.dart';

import '../../constant/my_color.dart';
import '../../controller/main_provider.dart';
import 'file_home_page.dart';


class FileUploadPage extends StatelessWidget {
   FileUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of<MainProvider>(context, listen: false);
    return  Scaffold(
      appBar:AppBar(
        backgroundColor: mainColor,
        title: const Text("File Upload",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,),),
        iconTheme: IconThemeData(color: Colors.white,size: 32),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<MainProvider>(
            builder: (context,value,child) {
              return Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height/8,),
                  Center(
                      child:
                      value.fileImage!=null?
                      InkWell(
                        onTap: (){
                          showBottomSheet(context);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height/3.8,
                          width: MediaQuery.of(context).size.width/1.2,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(image: FileImage(value.fileImage!,),fit: BoxFit.fill)
                          ),
                        ),
                      )
                          :value.videoURL!=null?
                      InkWell(
                        onTap: (){
                          showBottomSheet(context);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height/3,
                          width: MediaQuery.of(context).size.width/1.2,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child:  VideoPlayer(provider.controller!),
                        ),
                      ):
                      Container(
                        height: MediaQuery.of(context).size.height/3.8,
                        width: MediaQuery.of(context).size.width/1.2,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(child: Icon(Icons.perm_media,color: mainColor,size: 36,)),
                      )
                  ),
                  SizedBox(height: 30,),
                  value.fileImage!=null || value.videoURL!=null?
                  ElevatedButton(
                    onPressed: () async {
                      if (value.fileImage != null && value.fileImage!.lengthSync() <= 10 * 1024 * 1024) {
                        value.addImage(context);
                      } else if (value.videoURL != null){
                        int? videoFileSize = await value.getVideoFileSize(value.videoURL!);
                        print(videoFileSize.toString()+"dfghjkljbv");
                      if (videoFileSize != null && videoFileSize <= 10 * 1024 * 1024) {
                        value.uploadVideo(context);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('File size exceeds 10MB limit...',style: TextStyle(color: Colors.red),),
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.white54,
                            shape: StadiumBorder(),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(70),
                        )
                        );
                      }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      maximumSize: Size(120, 50),
                      backgroundColor: mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                    ),
                    child: Center(
                      child:value.loader==true?
                          const CircularProgressIndicator():
                      const Text('Save',style: TextStyle(color: Colors.white,fontSize: 20),),
                    ),
                  ):
                  ElevatedButton(
                    onPressed: () {
                      showBottomSheet(context);
                    },
                    style: ElevatedButton.styleFrom(
                      maximumSize: Size(120, 50),
                      backgroundColor: mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                    ),
                    child: const Row(
                      children: [
                        Text('ADD',style: TextStyle(color: Colors.white,fontSize: 20),),
                        SizedBox(width: 5,),
                        Icon(Icons.video_collection,color: Colors.white,)
                      ],
                    ),
                  )



                ],
              );
            }
        ),
      ),
    );
  }
}

void showBottomSheet(BuildContext context) {
  MainProvider provider = Provider.of<MainProvider>(context, listen: false);

  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          )),
      context: context,
      builder: (BuildContext bc) {
        return Wrap(
          children: <Widget>[
            ListTile(
                leading: Icon(
                  Icons.photo,
                  color: Colors.grey,
                ),
                title: const Text(
                  'Image',
                ),
                onTap: () =>
                {
                  provider.clearMethod(),
                  provider.getImagegallery(), Navigator.pop(context)}),
            ListTile(
                leading: Icon(Icons.video_call, color: Colors.grey),
                title: const Text(
                  'Video',
                ),
                onTap: () =>
                {
                  provider.clearMethod(),
                  provider.pPickVideo(), Navigator.pop(context)}),
          ],
        );
      });
}




