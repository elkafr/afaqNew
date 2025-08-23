// import 'package:flutter/material.dart';
// import 'package:riyadhmarket/components/shared_components/icon_item.dart';
// import 'package:riyadhmarket/utils/app_colors.dart';

// class NotificationItem extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//             builder: (context,constraints){
//               return Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[

//          Container(
//            margin: EdgeInsets.symmetric(horizontal: constraints.maxWidth *0.02 ,
//               vertical: constraints.maxHeight *0.15
//            ),

//                   width: 30,
//                   height: 30,
//                   child: IconItem(
//                     icon: Image.asset('assets/images/notification.png',color: cWhite,),
//                     backgroundColor:cPrimaryColor ,
//                   ),
//                 ),
//                 Container(
//                   height: constraints.maxHeight ,
//                   width: constraints.maxWidth *0.85,
//                   child: Column(
//                   //  mainAxisAlignment: MainAxisAlignment.end,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Container(
//                         width: constraints.maxWidth *0.8,
//                       child: Text('قام متجر إكسترا بتأكيد طلبك " جهاز ايفون برو ماكس 2020 بالوانه',
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,style: TextStyle(
//                         height: 1.5
//                       ),
//                       ),),
//                        Row(

//                         children: <Widget>[
//                           Image.asset('assets/images/wall_clock.png'),
//                           Text('منذ 5 دقائق' ,style: TextStyle(
//                             color: cPrimaryColor ,fontSize: 12
//                           ),)
//                         ],
//                       ),
//                                Divider(

//           ),

//                     ],
//                   ),
//                 ),

//       ],
//               );
//             }
//     );

//   }
// }
