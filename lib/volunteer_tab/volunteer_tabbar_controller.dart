import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTabBar extends GetxController with SingleGetTickerProviderMixin{
 TabController? tabController;

 List<Tab> tabNames = <Tab> [
 Tab(text: "All",),
  Tab(text: "Accepted",),
  Tab(text: "Rejected",)
 ];

 void onInit(){
  super.onInit();
  tabController = TabController(length: 3, vsync: this);
 }

 void onClose(){
  tabController?.dispose();
  super.onClose();
 }


}