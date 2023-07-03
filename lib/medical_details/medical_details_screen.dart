import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Language/custom_text_input_formatter.dart';

import '../LoginModule/custom_color.dart';
import '../MyText.dart';
import '../bottom_nav/custom_bottom_navi.dart';
import '../color_constant.dart';

import '../custom_button.dart';
import '../ride_start_screens/my_text_fieldform.dart';
import '../utils/CustomLoader.dart';

import 'medical_condition_controller.dart';

class MedicalDetailsScreen extends StatefulWidget {
  const MedicalDetailsScreen({super.key});

  @override
  State<MedicalDetailsScreen> createState() => _MedicalDetailsScreenState();
}

class _MedicalDetailsScreenState extends State<MedicalDetailsScreen> {

  final medicalDetailsController=Get.put(MedicalConditionController());
  MedicalConditionController getDetails=Get.find();
  final formKey = GlobalKey<FormState>();
  var dob;
  DateTime selectedDate = DateTime.now();
  var birthDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMedicalDetails();
  }

  void getMedicalDetails()async{
      await medicalDetailsController.getMedicalConditions();
      medicalDetailsController.medicalCondition.value.text=getDetails.getMedicalDetailsData[0].medicalCondition.toString();
      medicalDetailsController.medicalNotes.value.text=getDetails.getMedicalDetailsData[0].medicalNotes.toString();
      medicalDetailsController.allergies.value.text=medicalDetailsController.getMedicalDetailsData[0].allergiesAndReactions.toString();
      medicalDetailsController.medication.value.text=medicalDetailsController.getMedicalDetailsData[0].medications.toString();
      medicalDetailsController.organDonor.value.text=medicalDetailsController.getMedicalDetailsData[0].organDonar.toString();
      medicalDetailsController.weight.value.text=medicalDetailsController.getMedicalDetailsData[0].weight.toString();
      medicalDetailsController.height.value.text =medicalDetailsController.getMedicalDetailsData[0].height.toString();
      medicalDetailsController.priparyLanguage.value.text =medicalDetailsController.getMedicalDetailsData[0].primaryLanguage.toString();
      medicalDetailsController.dobController.value.text = medicalDetailsController.getMedicalDetailsData[0].dob.toString();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: appBlue,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: IconButton(
                  onPressed: () {
                    Get.back(canPop: true);
                  },
                  icon: const Icon(
                    Icons.arrow_back_sharp,
                    color: CustomColor.white,
                    size: 25,
                  )),
            ),
            title: Text("Medical Details",style: TextStyle(fontFamily: "Gilroy",fontSize: 22,color: Colors.white),),

          ),
          body: Form(
            key: formKey,
              child: Obx((){
                return SingleChildScrollView(
                    child:
                    Column(
                      children: [
                        Padding(padding: const EdgeInsets.all(25),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                const SizedBox(height: 25),
                                MyTextFieldForm(labelText: 'Medical Condition',
                                  controller: medicalDetailsController.medicalCondition.value,
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Enter medical conditions";
                                    }else{
                                      return null;
                                    }
                                  }, fontSize: 16, readOnly: false, onTap: () {  },
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    engHindFormatter,
                                    //FilteringTextInputFormatter.allow(
                                    //  RegExp("[a-zA-Z\]")),
                                    FilteringTextInputFormatter.deny('  '),
                                  ], ),
                                const SizedBox(height: 25),
                                MyTextFieldForm(labelText: 'Medical Notes',
                                  controller: medicalDetailsController.medicalNotes.value,
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Enter medical notes";
                                    }else{
                                      return null;
                                    }
                                  }, fontSize: 16, readOnly: false, onTap: () {  },
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    engHindFormatter,
                                    //FilteringTextInputFormatter.allow(
                                    //  RegExp("[a-zA-Z\]")),
                                    FilteringTextInputFormatter.deny('  '),
                                  ], ),
                                const SizedBox(height: 25),
                                MyTextFieldForm(labelText: 'Allergies and Reactions',
                                  controller: medicalDetailsController.allergies.value,
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Enter Allergies and Reactions";
                                    }else{
                                      return null;
                                    }
                                  }, fontSize: 16, readOnly: false, onTap: () {  },
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    engHindFormatter,
                                    //FilteringTextInputFormatter.allow(
                                    //  RegExp("[a-zA-Z\]")),
                                    FilteringTextInputFormatter.deny('  '),
                                  ], ),
                                const SizedBox(height: 25),
                                MyTextFieldForm(labelText: 'Medications',
                                  controller: medicalDetailsController.medication.value,
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Enter medication";
                                    }else{
                                      return null;
                                    }
                                  }, fontSize: 16, readOnly: false, onTap: () {  },
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    engHindFormatter,
                                    //FilteringTextInputFormatter.allow(
                                    //  RegExp("[a-zA-Z\]")),
                                    FilteringTextInputFormatter.deny('  '),
                                  ], ),
                                const SizedBox(height: 25),
                                MyTextFieldForm(labelText: 'Organ Donar',
                                  controller: medicalDetailsController.organDonor.value,
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Enter organ donar";
                                    }else{
                                      return null;
                                    }
                                  }, fontSize: 16, readOnly: false, onTap: () {  },
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    engHindFormatter,
                                    //FilteringTextInputFormatter.allow(
                                    //  RegExp("[a-zA-Z\]")),
                                    FilteringTextInputFormatter.deny('  '),
                                  ], ),
                                const SizedBox(height: 25),
                                MyTextFieldForm(labelText: 'Weight',
                                  controller: medicalDetailsController.weight.value,
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Enter your weight";
                                    }else{
                                      return null;
                                    }
                                  }, fontSize: 16, readOnly: false, onTap: () {  },
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [

                                    //engHindFormatter,
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9\]")),
                                    FilteringTextInputFormatter.deny('  '),
                                  ], ),
                                const SizedBox(height: 25),
                                MyTextFieldForm(labelText: 'Height',
                                  controller: medicalDetailsController.height.value,
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Enter height";
                                    }else{
                                      return null;
                                    }
                                  }, fontSize: 16, readOnly: false, onTap: () {  },
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.numberWithOptions( decimal: true,
                                    signed: false,),
                                  inputFormatters: [
                                    // engHindFormatter,
                                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                                    FilteringTextInputFormatter.deny('  '),
                                    FilteringTextInputFormatter.deny('..'),
                                  ], ),
                                const SizedBox(height: 25),
                                MyTextFieldForm(labelText: 'Date of Birth',
                                  controller: medicalDetailsController.dobController.value,
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Enter your birth date";
                                    }else{
                                      return null;
                                    }
                                  }, fontSize: 16, readOnly: true, onTap: () {
                                    _selectDate(context);
                                  },
                                  textCapitalization: TextCapitalization.none,
                                  keyboardType: TextInputType.datetime,
                                  inputFormatters: [

                                  ], ),
                                /*Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: TextFormField(
                                      // keyboardType: TextInputType.number,
                                      style: TextStyle(

                                          fontSize: 13,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Gilroy",
                                          color: CustomColor.riderprofileColor),
                                      maxLines: 1,
                                      controller: medicalDetailsController.dobController.value,
                                      decoration: InputDecoration(
                                        labelText: "Date of Birth",

                                        border: const UnderlineInputBorder(),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.black45)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2, color: Colors.black54)),
                                      ),
                                      readOnly: true,

                                      onTap: () async {
                                        _selectDate(context);
                                      },
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty) {
                                          return 'please_enter_your_date_of_birth'.tr;
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        dob = value;
                                      },
                                    ),
                                  ),
                                ),*/
                                const SizedBox(height: 25),
                                MyTextFieldForm(labelText: 'Primary Language',
                                  controller: medicalDetailsController.priparyLanguage.value,
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Enter your primary language";
                                    }else{
                                      return null;
                                    }
                                  }, fontSize: 16, readOnly: false, onTap: () {  },
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    engHindFormatter,
                                    //FilteringTextInputFormatter.allow(
                                    //  RegExp("[a-zA-Z\]")),
                                    FilteringTextInputFormatter.deny('  '),
                                  ], ),
                                const SizedBox(height: 10),



                              ],
                            ),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                          child: CustomButton(press: () {
                          //  if(formKey.currentState!.validate()){
                              medicalDetailsController.updateMedicalConditions().then((value){
                                if(value!=null){
                                  if(value.status==true){
                                    CustomLoader.message(value.message.toString());
                                    Get.to(const CustomBottomNav());
                                  }else{
                                    CustomLoader.message(value.message.toString());
                                  }
                                }
                              });
                         //   }
                          }, buttonText: 'Submit'),
                        ),
                      ],
                    )

                );
              })
              ),
        ));
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: selectedDate);
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthDate =
        "${picked.toLocal().day}-${picked.toLocal().month}-${picked.toLocal().year}";
        medicalDetailsController.dobController.value.text = birthDate;
        // print()
        // Get.snackbar("Selcted Date", birthDate.toString());
        // calAge(birthDate);
        //calculateAge(picked);
      });
    }
  }
}
