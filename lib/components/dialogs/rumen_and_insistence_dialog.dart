// import 'package:flutter/material.dart';
// import 'package:afaq/locale/localization.dart';
// import 'package:afaq/utils/app_colors.dart';
// import 'package:provider/provider.dart';
//
// import '../app_repo/product_state.dart';
//
//
// class RumenAndInsistenceDialog extends StatefulWidget {
//
//
//   @override
//   _RumenAndInsistenceDialogState createState() => _RumenAndInsistenceDialogState();
// }
//
// class _RumenAndInsistenceDialogState extends State<RumenAndInsistenceDialog> {
//
//   @override
//   Widget build(BuildContext context) {
//     final productState = Provider.of<ProductState>(context);
//     return  LayoutBuilder(builder: (context,constraints){
//  return AlertDialog(
//    contentPadding: EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10.0))
//           ),
//       content: productState.rumenAndInsistenceList.length > 8 ? Column(
//             mainAxisSize: MainAxisSize.max,
//           children: <Widget>[
//         Container(
//           decoration: BoxDecoration(
//               color: cAccentColor,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(10.00),
//                 topRight: Radius.circular(10.00),
//               ),
//               border: Border.all(color: cAccentColor)),
//           alignment: Alignment.center,
//           width: MediaQuery.of(context).size.width,
//           height: 40,
//           child: Text(
//             AppLocalizations.of(context).rumenAndInsistence,
//             style: TextStyle(
//                 color: cBlack, fontSize: 16, fontWeight: FontWeight.w700),
//           ),
//         ),
//         Expanded(
//
//           child:    Consumer<ProductState>(
//               builder: (context, productState, child) {
//             return ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: productState.rumenAndInsistenceList.length,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: <Widget>[
//                       GestureDetector(
//                         onTap: () {
//                           productState
//                               .updateChangesOnRumenAndInsistenceList(index);
//                           productState.updateTotalCost();
//                           Navigator.pop(context);
//                         },
//                         child: Container(
//                           alignment: Alignment.center,
//                           height: 40,
//                           child: Text(
//                             productState
//                                 .rumenAndInsistenceList[index].optionsName,
//                             style: TextStyle(
//                                 color: cBlack,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         ),
//                       ),
//                       index != productState.rumenAndInsistenceList.length - 1
//                           ? Divider()
//                           : Container()
//                     ],
//                   );
//                 });
//           })),
//
//           ],
//         )
//
//       : SingleChildScrollView(
//         child:  Column(
//           children: <Widget>[
//
//              Container(
//                 decoration: BoxDecoration(
//                      color: cAccentColor,
//                        borderRadius: BorderRadius.only(
//                           topLeft:  Radius.circular(10.00),
//                           topRight:  Radius.circular(10.00),
//                         ),
//                         border: Border.all(color: cAccentColor)),
//                alignment: Alignment.center,
//                width: MediaQuery.of(context).size.width,
//                height: 40,
//
//                child: Text( AppLocalizations.of(context).rumenAndInsistence,style: TextStyle(
//                  color: cBlack,fontSize: 16,
//                  fontWeight: FontWeight.w700
//                ),),
//              ),
//           LimitedBox(
//             maxHeight: productState.rumenAndInsistenceList.length * 60.0,
//             child: Column(
//                mainAxisSize: MainAxisSize.min,
//               children:  <Widget>[
//                    Consumer<ProductState>(
//                      builder: (context,productState,child){
//             return ListView.builder(
//               shrinkWrap: true,
//                     itemCount: productState.rumenAndInsistenceList.length,
//                     itemBuilder: (context,index){
//                       return Column(
//                        children: <Widget>[
//                           GestureDetector(
//                             onTap: (){
//                               productState.updateChangesOnRumenAndInsistenceList(index);
//                               productState.updateTotalCost();
//                               Navigator.pop(context);
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               height: 40,
//                               child: Text(productState.rumenAndInsistenceList[index].optionsName,style: TextStyle(
//                                 color: cBlack,
//                                 fontSize: 14,fontWeight: FontWeight.w400
//                               ),),
//                             ),
//                           ),
//                           index != productState.rumenAndInsistenceList.length - 1 ? Divider():
//                           Container()
//                        ],
//                       );
//                     }
//             );
//                      }
//                    ),
//                  ],
//                ),
//              )
//           ],
//         )),
//
//     );
//     });
//   }
// }
