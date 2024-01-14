import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:josm/resources/firestore_methods.dart';
import 'package:josm/resources/storage_methods.dart';
import 'package:josm/screens/greeting.dart';

import '../global.dart';
import '../resources/auth_methods.dart';
import '../utils/utils.dart';
import '../widget/text_field_input.dart';


class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _adhaarController = TextEditingController();
  final TextEditingController _nameController =  TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _squareftController = TextEditingController();
  final TextEditingController _pincodeController  = TextEditingController();
  final TextEditingController _wardnoController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  var selectedValue = value1;
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _addressController.dispose();
    _squareftController.dispose();
    _phoneController.dispose();
    _adhaarController.dispose();
    _nameController.dispose();
    _wardnoController.dispose();
    _longitudeController.dispose();
    _latitudeController.dispose();


  }

  void Adddetail() async {
    if(_image != null){
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    String res = await FireStoreMethods().addDetail(
        address: _addressController.text.trim(),
        pincode: _pincodeController.text.trim(),
        Latitude: _latitudeController.text.trim(),
        Longitude: _longitudeController.text.trim(),
        ward: _wardnoController.text.trim(),
        name: _nameController.text.trim(),
        adhaar: _adhaarController.text.trim(),
        phone: _phoneController.text.trim(),
        area: _squareftController.text.trim(),
        house_type: selectedValue,
        file: _image! ,
      email: _emailController.text.trim(),

    );
    // if string returned is sucess, user has been created
    if (res == "s") {
      setState(() {
        _isLoading = false;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) =>Greeting(),
          ),
        );
        Fluttertoast.showToast(msg: 'Added');
      });


    }
    else if(res == 'empty'){
      setState(() {
        _isLoading = false;
      });

    }
  }
    else{
      Fluttertoast.showToast( msg: 'image can\'t be empty');
    }
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('House Details'),
      // ),
      body: Container(
        padding: Width > 600
            ? EdgeInsets.symmetric(horizontal: Width / 2.9)
            : const EdgeInsets.symmetric(horizontal: 32),
        child: ListView(
          children: [
            // const SizedBox(
            //   height: 64,
            // ),
            Center(
              child: Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(_image!),
                    backgroundColor: Colors.red,
                  )
                      :  CircleAvatar(
                    radius: 64,
                    backgroundImage:AssetImage('assets/img.png'),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldInput(
              hintText: 'Enter user address',
              textInputType: TextInputType.text,
              textEditingController: _addressController,
              lenght: 100,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldInput(
              hintText: 'Enter pincode',
              textInputType: TextInputType.number,
              textEditingController: _pincodeController,
              lenght: 6,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFieldInput(
                    hintText: 'Enter Latitude',
                    textInputType: TextInputType.number,
                    textEditingController: _latitudeController,
                    lenght: 15,
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: TextFieldInput(
                    hintText: 'Enter Longitude',
                    textInputType: TextInputType.number,
                    textEditingController: _longitudeController,
                    lenght: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldInput(
              hintText: 'Enter ward number',
              textInputType: TextInputType.number,
              textEditingController: _wardnoController,
              lenght: 12,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldInput(
              hintText: "Enter Owner's name",
              textInputType: TextInputType.name,
              textEditingController: _nameController,
              lenght: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldInput(
              hintText: "Enter Owner's email",
              textInputType: TextInputType.name,
              textEditingController: _emailController,
              lenght: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldInput(
              hintText: 'Enter adhaar number',
              textInputType: TextInputType.number,
              textEditingController: _adhaarController,
              lenght: 12,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldInput(
              hintText: 'Enter phone number',
              textInputType: TextInputType.phone,
              textEditingController: _phoneController,
              lenght: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldInput(
              hintText: 'Enter square feet area',
              textInputType: TextInputType.number,
              textEditingController: _squareftController,
              lenght: 20,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: DropdownButton<String>(
                autofocus: true,
                borderRadius: BorderRadius.circular(10),
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items: <String>[
                  value1,
                  value2,
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: Adddetail,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  color: Colors.blue,
                ),
                child: !_isLoading
                    ? const Text(
                  'Submit',
                )
                    : const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}