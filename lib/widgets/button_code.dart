import 'package:flutter/material.dart';

class EcoButton extends StatelessWidget {
  String txt;
  bool? isloginButton;
  VoidCallback? onPress;
  bool? isLoading;

  EcoButton({
    required this.txt,
    this.isloginButton,
    this.onPress,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 17, vertical: 7),
        height: MediaQuery.of(context).size.height / 100 * 7,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isloginButton == false ? Colors.black : Colors.black,
          ),
          color: isloginButton == false ? Colors.white : Colors.black,
        ),
        child: Stack(
          children: [
            Visibility(
              visible: isLoading! ? false : true,
              child: Center(
                child: Text(
                  txt,
                  style: TextStyle(
                    color: isloginButton == false ? Colors.black : Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoading!,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
//
// class EcoButton extends StatelessWidget {
//   String? txt;
//   bool? isloginButton;
//   VoidCallback? onPress;
//
//   EcoButton({this.txt, this.isloginButton, this.onPress});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPress,
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 17, vertical: 7),
//         height: MediaQuery.of(context).size.height / 100 * 7,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//             color: isloginButton == false ? Colors.black : Colors.black,
//           ),
//           color: isloginButton == false ? Colors.white : Colors.black,
//         ),
//         child: Center(
//           child: Text(
//             txt!,
//             style: TextStyle(
//               color: isloginButton == false ? Colors.black : Colors.white,
//               fontSize: 16,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
