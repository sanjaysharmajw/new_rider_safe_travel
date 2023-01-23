import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'Country.dart';
class TabWidget extends StatefulWidget {
  const TabWidget({Key? key}) : super(key: key);

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {


  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 95.0;

  List<Country> countryOptions = <Country>[
    Country(name: 'Mumbai', address: "Maharashtra, India"),
    Country(name: 'Thiruvananthapuram', address: "Kerala, India"),
    Country(name: 'Bangalore', address: "Karnataka, India"),
    Country(name: 'Ranchi', address: "Jharkhand, India"),
    Country(name: 'Shimla', address: "Himachal Pradesh, India"),
    Country(name: 'Chandigarh', address: "Haryana, India"),
    Country(name: 'Panji', address: "Goa, India"),
    Country(name: 'Chennai', address: "TamilNadu, India"),
    Country(name: 'Lucknow', address: "Uttar Pradesh, India"),
    Country(name: 'Dehradun', address: "Uttarakhand, India"),
  ];

  @override
  void initState() {
    super.initState();

    _fabHeight = _initFabHeight;
  }
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery
        .of(context)
        .size
        .height * .80;
    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
           // body: _body(),
            panelBuilder: (sc) => _panel(sc),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            onPanelSlide: (double pos) =>
                setState(() {
                  _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                      _initFabHeight;
                }),
          ),

          // the fab
         /* Positioned(
            right: 20.0,
            bottom: _fabHeight,
            child: FloatingActionButton(
              child: Icon(
                Icons.gps_fixed,
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
              onPressed: () {},
              backgroundColor: Colors.white,
            ),
          ),  */

          Positioned(
              top: 0,
              child: ClipRRect(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: MediaQuery
                            .of(context)
                            .padding
                            .top,
                        color: Colors.transparent,
                      )))),

          //the SlidingUpPanel Title
          /*Positioned(
            top: 52.0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 18.0),
              child: Text(
                "SlidingUpPanel Example",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, .25), blurRadius: 16.0)
                ],
              ),
            ),
          ),  */
        ],
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: sc,
          children: <Widget>[
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            SizedBox(
              height: 18.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Select a location",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
                padding: EdgeInsets.all(15.0),
                child:
              Autocomplete<Country>(
                    optionsBuilder:
                        (TextEditingValue textEditingValue) {
                      return countryOptions
                          .where((Country county) => county.name
                          .toLowerCase()
                          .startsWith(textEditingValue.text
                          .toLowerCase()))
                          .toList();
                    },
                    displayStringForOption: (Country option) =>
                    option.name,
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController
                        fieldTextEditingController,
                        FocusNode fieldFocusNode,
                        VoidCallback onFieldSubmitted) {
                      return Card(
                        child: ListTile(
                          //leading: Icon(Icons.search),
                          title: TextFormField(


                            onChanged: (value) {
                              setState(() {
                                searchString = value.toString();
                              });
                            },
                            controller: fieldTextEditingController,
                            focusNode: fieldFocusNode,
                            decoration: InputDecoration(
                                hintText: "Search",
                                border: InputBorder.none,
                                prefixIcon: IconButton(
                                    onPressed: (){
                                     // searchMemberApi(mobileController.text,widget.userId);
                                    }, icon:  Icon(Icons.search,))
                            ),
                          ),
                          trailing: IconButton(onPressed: (){
                            fieldTextEditingController.clear();
                          }, icon: Icon(Icons.clear)),
                        ),
                      );
                      /* ListTile(
                        title: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                  onPressed: (){
                                   // searchMemberApi(mobileController.text,widget.userId);
                                  }, icon:  Icon(Icons.search)),

                          ),


                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: IconButton(onPressed: (){
                         // mobileController.clear();
                        }, icon: Icon(Icons.clear)),
                      ); */


                    },

                    onSelected: (Country selection) {
                      print('Selected: ${selection.name}');
                    },
                    optionsViewBuilder: (BuildContext context,
                        AutocompleteOnSelected<Country>
                        onSelected,
                        Iterable<Country> options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          child: Container(
                            width: 365,
                            //color: Colors.grey,
                            child: ListView.builder(
                              padding: EdgeInsets.all(10.0),
                              itemCount: options.length,
                              itemBuilder:
                                  (BuildContext context,
                                  int index) {
                                final Country option =
                                options.elementAt(index);

                                return GestureDetector(
                                  onTap: () {
                                    onSelected(option);
                                  },
                                  child: Card(
                                    elevation: 1,
                                    margin: EdgeInsets.symmetric(vertical: 2),
                                    child: ListTile(
                                      leading: Icon(Icons.location_on_rounded,color: Colors.red,),
                                                         title: Text(option.name,
                                          style: const TextStyle(
                                              color:
                                              Colors.black)
                                      ),
                                      subtitle: Text(option.address.toString()),

                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    })
            )

          ],
        ));
  }



 /* _body() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/mapimage.jpg'),
              fit: BoxFit.cover
          )
      ),
      child: Center(
        child: Text("Expoler",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:Colors.white),),
      ),
    );
  } */
}

