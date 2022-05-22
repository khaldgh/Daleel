import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:daleel/models/user.dart';
import 'package:daleel/providers/places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  ImagePicker picker = ImagePicker();

  XFile? pickedImage;

  onImageAdded(ImageSource? source, User user) async {
    pickedImage = await picker.pickImage(source: source!, imageQuality: 30);

    var exampleFile = File(pickedImage!.path);

    // Provider.of<Places>(context, listen: false).PostImage(pickedImage!);
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
          local: exampleFile,
          //     options:  S3UploadFileOptions(
          //   accessLevel: StorageAccessLevel.guest,
          //   contentType: 'text/plain',
          //   metadata: <String, String>{
          //     'project': 'ExampleProject',
          //   },
          // ),
          key: 'profilePics/${user.user_id}',
          onProgress: (progress) {
            print("Fraction completed: " +
                progress.getFractionCompleted().toString());
          });
      print('Successfully uploaded file: ${result.key}');
    } on StorageException catch (e) {
      print('Error uploading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var places = Provider.of<Places>(context, listen: false);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              icon: Icon(Icons.photo),
              onPressed: () async {
                User user = await places.whoami();
                onImageAdded(ImageSource.camera, user);
              }),
          IconButton(onPressed: () async {
            String? cookie = await FlutterSecureStorage().read(key: 'cookie');
            print(cookie);
          }, icon: Icon(Icons.cookie))
        ],
      ),
    );
  }
}
