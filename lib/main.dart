
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';





void main() 
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ("VIDEO"),
      theme: ThemeData(primarySwatch: Colors.green),
      home: Video(),
    );
  }
}


class Video extends StatefulWidget {
  const Video({ Key? key }) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context)=> Material( 
    
      child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 32.0,),
            ElevatedButton( child: Text("Download & Open"),
            onPressed: () => openFile(
              url:'https://youtu.be/FNBuo-7zg2Q',
              fileName:'video.mp4',
              
        
              
            ),
            
           
             ),
          ],
        ),
      ),
    );
  

  Future openFile ({required String url,String? fileName}) async{
    final file =await pickFile();

    if(file == null) 
    
    return;

    print('Path:${file.path}');

    OpenFile.open(file.path);
    

  }

  Future<File?> pickFile() async{

    final result =await FilePicker.platform.pickFiles();
    if(result==null) return null;
    return File(result.files.first.path!);
  }

   Future<File?> dowloadFile(String url,String name) async{
     final appStorage=await getApplicationDocumentsDirectory();
     final file=File('${appStorage.path}/$name');

     try{
     final response=await Dio().get(url,
     options: Options(
       responseType: ResponseType.bytes,
       followRedirects: false,
       receiveTimeout: 0,
     ),
     
     );
     final raf=file.openSync(mode:FileMode.write);
     raf.writeFromSync(response.data);
     await raf.close();
     return file;
     }
     catch(e){
       return null;
     } 
    
  
}
}






 

    
   
      
   
  
