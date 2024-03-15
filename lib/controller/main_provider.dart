import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../screens/home_page.dart';
class MainProvider extends ChangeNotifier{
  FirebaseFirestore db = FirebaseFirestore.instance;
  Reference imgstr=FirebaseStorage.instance.ref("Images");
  Reference vidstr=FirebaseStorage.instance.ref("Videos");


// Image store  to firebase

  Future<void> addImage(BuildContext context) async {
    loader=true;
    notifyListeners();
    String id= DateTime.now().microsecondsSinceEpoch.toString();
    HashMap<String,Object>addItemMap=HashMap();
    addItemMap["ID"]=id;
    if (fileImage != null) {
      String photoId = DateTime.now().millisecondsSinceEpoch.toString();
      imgstr = FirebaseStorage.instance.ref().child(photoId);
      await imgstr.putFile(fileImage!).whenComplete(() async {
        await imgstr.getDownloadURL().then((value) {
          addItemMap["IMAGE"] = value;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    }
    db.collection("IMAGES").doc(id).set(addItemMap);
    loader=true;
    notifyListeners();
    clearMethod();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('File Uploaded Successfully...',style: TextStyle(color: Colors.green),),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.white54,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(70),
    )
    );
    notifyListeners();
  }

//image get from gallery

  File? fileImage;

  Future getImagegallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
    await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      cropImage(pickedImage.path,);
    } else {
      print('No image selected.');
    }
  }

  // Future getImagecamera() async {
  //   final imagePicker = ImagePicker();
  //   final pickedImage =
  //   await imagePicker.pickImage(source: ImageSource.camera);
  //
  //   if (pickedImage != null) {
  //     // print("dfghjk"+pickedImage.path);
  //     cropImage(pickedImage.path);
  //
  //   } else {
  //     print('No image selected.');
  //   }
  // }

// function for crop Image
  Future<void> cropImage(String path) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      fileImage = File(croppedFile.path);
      // print(Registerfileimg.toString() + "fofiifi");
      notifyListeners();
    }
  }

  void clearMethod(){
    fileImage=null;
    controller=null;

  }


  String? videoURL;
  VideoPlayerController? controller;
  // File? videoFile;
  XFile? videoFile;

  pickVideo() async{
    final picker = ImagePicker();

    try{
      videoFile = await picker.pickVideo(source: ImageSource.gallery);
      return videoFile!.path;
    }
    catch(e){
      print('Error Picking Video : $e');
    }
  }

  void dispose(){
    controller?.dispose();
    super.dispose();
  }
  void pPickVideo() async{
    videoURL =  await pickVideo();
    initializeVideoPlayer();
  }

  void initializeVideoPlayer(){
    controller = VideoPlayerController.file(
        File(videoURL!))
      ..initialize().then((_)  {
        notifyListeners();
        controller!.play();
      });
  }
  Future<void> addVideo(BuildContext context) async {
    loader=true;
    notifyListeners();
    String id= DateTime.now().microsecondsSinceEpoch.toString();
    HashMap<String,Object>addItemMap=HashMap();
    addItemMap["ID"]=id;
    if (videoURL != null) {
      String videoId = DateTime.now().millisecondsSinceEpoch.toString();
      vidstr = FirebaseStorage.instance.ref().child(videoId);
      await vidstr.putFile(videoFile as File).whenComplete(() async {
        await vidstr.getDownloadURL().then((value) {
          addItemMap["VIDEO"] = value;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    }
    db.collection("VIDEOS").doc(id).set(addItemMap);
    clearMethod();
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));

  }

  String? downloadURL;
  void uploadVideo(BuildContext context) async{
    loader=true;
    notifyListeners();
    downloadURL = await sUploadVideo(videoURL!);
    await saveVideoData(downloadURL!);
    notifyListeners();
      videoURL = null;
    loader=false;
    notifyListeners();
    clearMethod();
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('File Uploaded Successfully...',style: TextStyle(color: Colors.green),),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.white54,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(70),
    )
    );
    notifyListeners();


  }

  Future<int?> getVideoFileSize(String videoFilePath) async {
    try {
      final file = File(videoFilePath);

      // Check if the file exists
      if (await file.exists()) {
        final fileSize = await file.length();
        return fileSize;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching video file size: $e');
      return null;
    }
  }

 bool loader=false;
  void loaderFunction(){

  }
  // final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> sUploadVideo(String videoUrl) async {
    loader=true;
    File videoFile = File(videoUrl);
    String fileName = 'videos/${DateTime.now()}.mp4';
    await storage.ref().child(fileName).putFile(videoFile);
    String downloadURL = await storage.ref().child(fileName).getDownloadURL();

    return downloadURL;
  }

  Future<void> saveVideoData(String videoDownloadUrl) async {
    await db.collection("videos").add({
      'url': videoDownloadUrl,
      'timeStamp': FieldValue.serverTimestamp(),
      'name': 'User Video'
    });
  }

}

