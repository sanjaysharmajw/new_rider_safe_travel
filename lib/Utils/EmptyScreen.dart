import 'package:flutter/cupertino.dart';

import '../color_constant.dart';
import '../new_widgets/my_new_text.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('new_assets/no_data.png',width: 100,height: 100,fit: BoxFit.fill),
          const SizedBox(height: 10),
          const NewMyText(textValue: 'No Data Found', fontName: 'Gilroy', color: appBlack, fontWeight: FontWeight.w500, fontSize: 14)
        ],
      ),
    );
  }
}
