import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'LoginModule/custom_color.dart';

class RejectedServiceList extends StatefulWidget {
  const RejectedServiceList({Key? key}) : super(key: key);

  @override
  State<RejectedServiceList> createState() => _RejectedServiceListState();
}

class _RejectedServiceListState extends State<RejectedServiceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            elevation: 15,
            margin: EdgeInsets.all(20),


            child:  Container(
              padding: EdgeInsets.all(20),
              child: Column(

                children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Rx Service",style: TextStyle(color: CustomColor.black,fontSize: 20),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {  },
                            child: Text("Rejected"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                            ),

                          ),
                        ),



                      ],
                    ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Car Service",style: TextStyle(fontSize: 17),),
                      ),
                    ],
                  ),
                  Divider(thickness: 2,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text("Kilometer",style: TextStyle(color: Colors.black54,fontSize: 18),),
                            SizedBox(height: 10,),
                            Text("10 Km",style: TextStyle(color: Colors.black87,fontSize: 16),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [


                            Text("Rejected on",style: TextStyle(color: Colors.black54,fontSize: 18),),
                            SizedBox(height: 10,),
                            Text("04 March 2023 05.50 PM",style: TextStyle(color: Colors.black87,fontSize: 16),),

                          ],
                        ),


                      ),





                    ],
                  ),
                  Column(

                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {  }, child: Text("Location"),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFD3ACAD),
                              side: BorderSide(color: CustomColor.yellow, width: 1),
                            ),

                          ),

                        ],
                      ),
                    ],
                  ),





                 /* Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text("Kilometer",style: TextStyle(color: Colors.black54,fontSize: 18),),
                            SizedBox(height: 10,),
                            Text("10 Km",style: TextStyle(color: Colors.black45,fontSize: 16),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text("Rejected on",style: TextStyle(color: Colors.black54,fontSize: 18),),
                            SizedBox(height: 10,),
                            Text("04 March 2023 05.50 PM",style: TextStyle(color: Colors.black54,fontSize: 16),),
                          ],
                        ),


                      ),



                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {  }, child: Text("Location"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          
                        ),
                      ),
                    ],
                  ),  */
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}
