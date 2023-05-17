

import 'package:flutter/material.dart';
import 'package:ride_safe_travel/request_widgets.dart';



import 'LoginModule/custom_color.dart';
import 'MyText.dart';


class VolunteerRequestItems extends StatelessWidget {
  const VolunteerRequestItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: CustomColor.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(text: 'Sanjay Sharma', fontSize: 16, fontFamily: 'Gilroy', color: Colors.black,),
                    const SizedBox(
                      height: 8,
                    ),
                    MyText(text: 'Drive: Amit, MH0412345',  fontSize: 14,  fontFamily: 'Gilroy', color: Colors.black,),
                    const SizedBox(
                      height: 8,
                    ),
                    MyText(text: '10 Km', fontSize: 14, fontFamily: 'Gilroy', color: Colors.black,),
                  ],
                ),
              ),

              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                child: Row(
                  children:  [
                    Flexible(
                        flex: 2,
                        child: RequestWidget(textValue: 'Ready to Go', onClick: () {  })),
                   const  SizedBox(width: 10),
                    Flexible(
                        flex: 2,
                        child: RequestWidget(textValue: 'Not ready to go', onClick: () {  })),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
