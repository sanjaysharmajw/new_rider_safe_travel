import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';
import '../Language/custom_text_input_formatter.dart';
import '../LoginModule/custom_color.dart';
import '../LoginModule/preferences.dart';
import '../Widgets/my_textfield_with_hint.dart';
import '../Widgets/text_field_theme.dart';
import '../color_constant.dart';
import '../custom_button.dart';
import '../new_widgets/my_new_text.dart';
import 'add_co_passanger/add_co_passanger_request.dart';
import 'add_co_passanger_controller.dart';
import 'dummy_data.dart';

class AddCoPassangerScreen extends StatefulWidget {
  String rideId;
  AddCoPassangerScreen({Key? key,required this.rideId}) : super(key: key);

  @override
  State<AddCoPassangerScreen> createState() =>
      _AddCoPassangerScreen();
}

class _AddCoPassangerScreen extends State<AddCoPassangerScreen> {
  final _formKey = GlobalKey<FormState>();
  final controllerName=TextEditingController();
  final controllerAge=TextEditingController();
  final controllerBloodGroup=TextEditingController();
  final controllerAddCoPassanger=Get.put(AddCoPassangerController());
  int id = 1;
  String radioButtonItem = 'Female';

  void addCoPassanger()async{
    var ageValue = int.parse(controllerAge.text.toString());
    var age = ageValue;
    AddCoPassangerRequest request=AddCoPassangerRequest(
      rideId: widget.rideId.toString(),
      userId: Preferences.getId(Preferences.id).toString(),
      name: controllerName.text.toString(),
      age: age,
      gender: radioButtonItem.toString(),
      bloodgroup: controllerBloodGroup.text.toString()
    );

   await controllerAddCoPassanger.addCoPassangerApi(request).then((value){
     if(value!=null){
       if(value.status==true){
         LoaderUtils.message(value.message.toString());
         Get.back(result: true);
       }
     }

   });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBlue,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: IconButton(
                onPressed: () {
                  Get.back(result: true);
                },
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  color: CustomColor.white,
                  size: 25,
                )),
          ),
          title: Text("add_co_passanger".tr,style: TextStyle(fontFamily: "Gilroy",fontSize: 22,color: Colors.white),),

        ),

        body:  SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(right: 25,left: 25,top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 35),
                 /* InkWell( onTap: (){
                    Get.back();
                  },child: Image.asset('new_assets/new_back.png',width: 17,height: 17)),
                  const SizedBox(height: 25),
                  const NewMyText(textValue: 'Add Co-Passanger', fontName: 'Gilroy', color: appBlack, fontWeight: FontWeight.w800, fontSize: 20),*/

                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          inputFormatters: [
                            engHindFormatter,
                            //FilteringTextInputFormatter.allow(
                            // RegExp("[a-zA-Z\]")),
                            FilteringTextInputFormatter.deny('  ')
                          ],
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 2) {
                              return 'enter_co_passanger_name'.tr;
                            }
                            return null;
                          },
                          controller: controllerName,
                          style: const TextStyle(fontFamily: 'Gilroy', fontSize: 14),
                          decoration:  InputDecoration(
                           
                            labelText: 'name'.tr,
                            hintText: 'name'.tr,
                          ),
                        ),
                       /* TextFieldTheme.buildTextField(hint: 'name'.tr,
                            maxLength: null,
                            keyboardType: TextInputType.text,
                            controller: controllerName, validator: (value) {
                              if (value.toString().isEmpty) {
                                return "enter_co_passanger_name".tr;
                              }else{
                                return null;
                              }
                            }, onTap: (){}),*/

                        const SizedBox(height: 10),
                        TextFieldTheme.buildTextField(hint: 'age'.tr,
                            maxLength: null,
                            keyboardType: TextInputType.text,
                            controller: controllerAge, validator: (value) {
                              if (value.toString().isEmpty) {
                                return "enter_your_age".tr;
                              }else{
                                return null;
                              }
                            }, onTap: (){}),
                        const SizedBox(height: 10),

                        MyTextFieldWithHint(
                            hintText: 'select_blood_group'.tr, controller:
                        controllerBloodGroup, validator: (value) {
                          if (value.toString().isEmpty) {
                            return "select_your_blood_group".tr;
                          }else{
                            return null;
                          }
                        }, fontSize: 16, readOnly: true, onTap: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: bloodGroupDialogBox(),
                                );
                              });

                        }, keyboardType: TextInputType.text, inputFormatters: null),
                        const SizedBox(height: 20),
                        genderWidget(),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: CustomButton(press: () {
                      if(_formKey.currentState!.validate()){
                        addCoPassanger();
                      }
                    }, buttonText: 'submit'.tr),
                  ),
                ],
              ),
            ),
          ),
        )
    ));
  }

  Widget bloodGroupDialogBox() {
    return SizedBox(
      width: 200.0,
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NewMyText(textValue: 'Select Blood Group', fontName: 'Gilroy', color: appBlack, fontWeight: FontWeight.w700, fontSize: 16),
          const Padding(
            padding:  EdgeInsets.only(right: 10,left: 10,top: 10),
            child: Divider(),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: bloodGroupData.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    controllerBloodGroup.text=bloodGroupData[index];
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: NewMyText(textValue: bloodGroupData[index], fontName: 'Gilroy', color: appBlack, fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget genderWidget(){
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const NewMyText(textValue: 'Gender : ', fontName: 'Gilroy', color: appBlack,
            fontWeight: FontWeight.w700, fontSize: 16),
        Row(
         mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:  CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                Radio(
                  fillColor: MaterialStateColor.resolveWith((states) => appBlue),
                  focusColor:
                  MaterialStateColor.resolveWith((states) => appBlue),
                  value: 1,
                  groupValue: id,
                  onChanged: (val) {
                    setState(() {
                      radioButtonItem = 'Female';
                      id = 1;
                    });
                  },
                ),
                const NewMyText(textValue: 'Female', fontName: 'Gilroy', color: appBlack, fontWeight: FontWeight.w500, fontSize: 16)
              ],
            ),
            Row(
              children: [
                Radio(
                  fillColor: MaterialStateColor.resolveWith(
                          (states) => appBlue),
                  focusColor:
                  MaterialStateColor.resolveWith(
                          (states) => appBlue),
                  value: 2,
                  groupValue: id,
                  onChanged: (val) {
                    setState(() {
                      radioButtonItem = 'Male';
                      id = 2;
                    });
                  },
                ),
                const NewMyText(textValue: 'Male', fontName: 'Gilroy', color: appBlack, fontWeight: FontWeight.w500, fontSize: 16)
              ],
            ),
            Row(
              children: [
                Radio(
                  fillColor: MaterialStateColor.resolveWith((states) => appBlue),
                  focusColor:
                  MaterialStateColor.resolveWith((states) => appBlue),
                  value: 3,
                  groupValue: id,
                  onChanged: (val) {
                    setState(() {
                      radioButtonItem = 'Other';
                      id = 3;
                    });
                  },
                ),
                const NewMyText(textValue: 'Other', fontName: 'Gilroy', color: appBlack,
                    fontWeight: FontWeight.w500, fontSize: 16)
              ],
            )
          ],
        ),
      ],
    );
  }

}
