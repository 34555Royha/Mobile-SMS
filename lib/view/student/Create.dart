import 'dart:convert';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pms/configuration/BaseUrl.dart';
import 'package:flutter_app_pms/configuration/CustomeFormDateTime.dart';
import 'package:flutter_app_pms/configuration/CustomerForm.dart';
import 'package:flutter_app_pms/configuration/apiService.dart';
import 'package:flutter_app_pms/configuration/uploadFile.dart';
import 'package:flutter_app_pms/model/student/CreateStudent.dart';
import 'package:flutter_app_pms/repositories/drowdown/sexRepository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

String responses;
// Repository
Future<bool> createStudents(CreateStudent createStudent) async {

  final response = await ApiService().postAPIWithToken(url: urlAPI+'student', body: jsonEncode(createStudent.toMap()));
  responses = json.decode(response.body)['message'];
  if (response.statusCode == 200) {
    print('insert success');
    return true;
  } else {
    
    print('insert field!');
    // throw Exception('Failed to create Student.');
    return false;
  }
}

class StudentNew extends StatefulWidget {
  @override
  _StudentNewState createState() => _StudentNewState();
}

class _StudentNewState extends State<StudentNew>
    with SingleTickerProviderStateMixin, CustomeFormDateTime{
      
  // AnimationController _controller;

final _formKey = GlobalKey<FormState>();
  

  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
        final List<String> sex = <String>['Select', 'Male', 'Female'];

    TextEditingController photo = TextEditingController();
    TextEditingController name = TextEditingController();
     TextEditingController address = TextEditingController();
      TextEditingController phone = TextEditingController();
    TextEditingController dob = TextEditingController();
    // StudentRepository studentRepository;

    String codeReasontype;

  var txtphoto = CustomerForm.textBox(
      photo,
      'Photo',
      validate: true,
    );
     var txtname = CustomerForm.textBox(
      name,
      'Name',
      validate: true,
    );
     var txtaddress = CustomerForm.textBox(
      address,
      'Address',
      validate: true,
    );
     var txtphone = CustomerForm.textBox(
      phone,
      'Phone',
      validate: true,
    );

      final TextFormField fromdate = TextFormField(
      controller: dob,
      keyboardType: TextInputType.datetime,
      autofocus: false,
      readOnly: true,
      decoration: CustomerForm.textFormFieldDecorationPrefixIcon(
          labelText: 'Date Of Birth', prefixIcon: Icon(Icons.date_range)),
      onTap: () async {
        DateTime value = DateTime.now();
        value = await datePicker(context, value);
        dob.text = DateFormat('yyyy-MM-dd').format(value).toString();
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter Date Of Birth';
        } else {
          return null;
        }
      },
    );
String valueSex = '';
      final reasontype = DropdownSearch<String>(
      hint: 'Sex',
      mode: Mode.MENU,
      label: 'Sex',
      showClearButton: true,
      showSearchBox: false,
      items:
          List.generate(sexs.length, (index) => sexs[index].name),
      onChanged: (value) {
        print('onchange');
        if (value != null) {
          valueSex =
              sexs.where((element) => element.name == value).first.value;
        } else {
          valueSex = '';
        }
      },
      validator: (String item) {
        if (item == null)
          return "Please select Sex";
        else
          return null;
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
      searchBoxDecoration: CustomerForm.searchBoxDecoration(),
      dropdownSearchDecoration: CustomerForm.dropdownSearchDecoration(),
    );
    
    void functionCreate() async{
    CreateStudent createStudent = CreateStudent(
       address: address.text,
       dateOfBirth: dob.text,
       name: name.text,
       phone: phone.text,
       photo: '',
       sex: valueSex,
     );
    //  createAlbum(createStudent);
     print ("Clicked submit");
    //  print(jsonEncode(createStudent.toMap()));     
    if(await createStudents(createStudent)){
      CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  title: "Success",
                  text: responses,
                  onConfirmBtnTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }).then((value) => {
                  });
                  
    }else {
      CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: "Create Failed",
            text: responses,
          );
    }
    }

 final Padding submitButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: CustomerForm.borderRadius(),
        ),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            functionCreate();
          }
        },
        padding: EdgeInsets.all(12),
        color: Colors.blue[900],
        child: Text('Submit', style: TextStyle(color: Colors.white)),
      ),
    );
    final Padding cancelButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: CustomerForm.borderRadius(),
        ),
        onPressed: () async {
          Navigator.pop(context);
        },
        padding: EdgeInsets.all(12),
        color: Colors.red[900],
        child: Text('Cancel', style: TextStyle(color: Colors.white)),
      ),
    );

 

File _file;
      void opemCamera () async{
        File file = await getImage(imageSource: ImageSource.camera);
        if(file != null) {
          setState(() {
            _file = file;
          });
           print('Image path: ${_file.path}');
        }
       
      }
      void opemImage () async{
           File file = await getImage();
        if(file != null) {
          setState(() {
            _file = file;
          });
          print('Image path: ${_file.path}');
        }
        
      }
      void uploadImage () async{
        if(_file != null) {
          UploadStatus uploadStatus = await uploadFile(_file);
          if(uploadStatus == UploadStatus.Successful){
            print("File Uploaded successs");
          }else{
             print("File Uploaded failed");
          }
        }else{
           print("No file, Please select file");
        }
      }

     return Scaffold(
      appBar: AppBar(
        title: Text("New Student"),
        backgroundColor: Colors.blue[900],
        actions: <Widget>[
          IconButton(icon: Icon(Icons.camera_alt), onPressed: (){
            opemImage();
          }),
          IconButton(icon: Icon(Icons.image), onPressed: (){
            opemImage();
          }),
          IconButton(icon: Icon(Icons.file_upload), onPressed: (){
            uploadImage();
          }),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0),
          children: <Widget>[
            // SizedBox(height: 10.0),
            // txtphoto,
            SizedBox(height: 50.0),
            txtname,
            SizedBox(height: 10.0),
            txtaddress,
            SizedBox(height: 10.0),
            fromdate,
            SizedBox(height: 10.0),
            reasontype,
            SizedBox(height: 10.0),
            txtphone,
             Row(
              children: <Widget>[
                Expanded(child: cancelButton),
                SizedBox(width: 10.0),
                Expanded(child: submitButton),
              ],
            )
          ],
        ),
      ),
    );
  }
}