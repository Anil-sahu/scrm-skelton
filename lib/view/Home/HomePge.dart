// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skelton/view/Home/pdfPrevew.dart';
import 'package:skelton/view/widget/textField.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController cnameController = TextEditingController();
  TextEditingController caddressController = TextEditingController();
  TextEditingController cphoneController = TextEditingController();
  TextEditingController cemailController = TextEditingController();
  var path;
  var imgPath;
  var imagefile;
  var encodeImage;
  var byteData;

  bool loading = false;
  String errorString = "";
  var connetionStatus = false;
  String errorSring = "";

  String emailRegX =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
//--------------------------GET Image from gallary-----------------------------//
  Future getImages() async {
    var _picker = ImagePicker();
    var img = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    //------------------------Convert file to byteList-----------------
    byteData = await img!.readAsBytes();

    setState(() {
      imgPath = img.path;
      path = imgPath.split("/").last;
      imagefile = File(imgPath);
    });
  }

//-----------------------valid input ------------------------------------//
  validatedInput() {
    if (imagefile == null) {
      errorSring = "Please pick company logo";
      return false;
    }

    if (cnameController.text.length < 3) {
      errorSring = "Enter valid company name";
      return false;
    }

    if (caddressController.text.length<5) {
      errorSring = "Please enter vild adress";
      return false;
    }
    if (cphoneController.text.length != 10) {
      errorSring = "Please Enter valid phone number";
      return false;
    }

    if (!RegExp(emailRegX).hasMatch(cemailController.text)) {
      errorSring = "Please! Enter valid email";
      return false;
    }
    errorSring="";
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    caddressController.dispose();
    caddressController.dispose();
    cphoneController.dispose();
    cemailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Skelton App"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(children: [
            imagefile != null
                ? SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.file(
                      imagefile,
                      fit: BoxFit.cover,
                    ))
                : const Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.blueGrey,
                  ),
            TextButton(
                onPressed: () {
                  getImages();
                },
                child: const Text("Pick logo")),
            CustomTextField(
              controller: cnameController,
              hintText: "Company name",
              type:  TextInputType.text,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              controller: caddressController,
              hintText: "Company address",
              type:  TextInputType.streetAddress,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              controller: cphoneController,
              hintText: "company phone",
              type:  TextInputType.phone,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              controller: cemailController,
              hintText: "Company email address",
            type:   TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              errorSring,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  if (validatedInput()) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return PreviewPage(
                          cnameController.text,
                          caddressController.text,
                          cemailController.text,
                          cphoneController.text,
                          byteData);
                    }));
                  }
                  setState(() {});
                },
                child: const Text("Generate Pdf"))
          ]),
        ),
      ),
    );
  }
}
