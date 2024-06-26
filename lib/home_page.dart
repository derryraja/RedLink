import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:redlink/all_emergencies.dart';
import 'package:redlink/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Colors.dart';
import 'My_Requests.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  bool isActive = false;
  @override
  void initState() {
    loggedInUser=_auth.currentUser;
    super.initState();
    isActive = true;
  }

  @override
  void dispose() {
    super.dispose();
    isActive = false;
  }
  var _firbaseref = FirebaseDatabase().reference().child("Emergencies");
  List<Map<dynamic, dynamic>> lists = [];

  void _showcontent(String bloodType,String contactNumber,String unitsReq,String deadline,String hospitalName) {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Confirm Booking'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                Text('Hospital Name : '+hospitalName,style: TextStyle(fontFamily: 'nunito'),),
                Text('Units Required : '+unitsReq,style: TextStyle(fontFamily: 'nunito'),),
                Text('Deadline : '+deadline,style: TextStyle(fontFamily: 'nunito'),),
                Text('Contact Number : '+contactNumber,style: TextStyle(fontFamily: 'nunito'),),
                Text('Would you like to confirm your availability? ',style: TextStyle(fontFamily: 'nunito'),),
              ],
            ),
          ),
          actions: [
            new FlatButton(
              child: new Text('confirm',style:TextStyle(color: Colors.red) ,),
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                  f=1;
                });
                FirebaseDatabase.instance.reference().child('User/${loggedInUser.uid}/MyDonations/').push().set({
                  "BloodType": bloodType,
                  "Units": unitsReq,
                  "Deadline": deadline,
                  "Hospital": hospitalName,
                  "ContactNumber": contactNumber,
                }).then((_) {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Your Request posted')));
                  // ageController.clear();
                  // nameController.clear();
                }).catchError((onError) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text(onError)));
                });
              },
            ),
            new FlatButton(
              child: new Text('cancel',style:TextStyle(color: Colors.red) ,),
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                  f=1;
                });

              },
            ),
          ],
        );
      },
    );
  }

  int count1=5;
  int count2=3;
  int _value = 8;
  int _value1 = 1;
  String type;
  int f=0;
  @override
  int getNumber(int count){
    if(f==1)
      return count--;
    else
      return count;
  }
  Color getColor(){
    if(f==1)
     return Color(0xffCB282D);
    else
      return Colors.white.withOpacity(0.9);
  }
  Color getColor1(){
    if(f==1)
      return Colors.white.withOpacity(0.9);
    else
      return Color(0xFFBC002D);
  }
  Color getColor2(){
    if(f==1)
      return Colors.white.withOpacity(0.9);
    else
      return Colors.black;
  }

  String getText(){
    if(f==1)
      return "Confirmed";
    else
      return "Type";
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 35,),
            Padding(
              padding: const EdgeInsets.only(top:15.0,left:20),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.black.withOpacity(0.1), width: 1.5)),
                    padding: EdgeInsets.all(5.5),
                    child: CircleAvatar(
                      radius: 45.0,
                      backgroundImage: AssetImage('images/profile.jpg'),
                    ),
                  ),
                  SizedBox(width: 5,),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(loggedInUser.displayName!=null?loggedInUser.displayName:loggedInUser.email,style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w600,
                        ),
                        ),
                        SizedBox(height: 2,),
                        Text(
                          'Donate Blood, Save Lives!',style: GoogleFonts.montserrat(fontSize: 12,color: Colors.black.withOpacity(0.8)
                        ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20.0,right: 20,left:20,bottom: 5),
              child: Container(
                height:160,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFFE53033),Color(0xFFBC002D), ],
                      tileMode: TileMode.clamp
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromRGBO(49, 39, 79, 1),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x30bc002d),
                        blurRadius: 5,
                        offset: Offset(0, 10),
                      )
                    ]
                ),
                child:Row(
                  children: <Widget>[
                    SizedBox(width: 10,),
                   Column(
                     children: <Widget>[
                       Padding(
                         padding: const EdgeInsets.only(top:30.0,right: 17,left: 25),
                         child: Text('${getNumber(count1)}'.toString(),style: TextStyle(fontSize: 60,color: Colors.white.withOpacity(0.8),fontFamily: 'Montserrat'),),
                       ),
                       Text('   Requests',style: TextStyle(fontSize: 16,color: Colors.white.withOpacity(0.8)),)
                     ],
                   ),
                    SizedBox(width: 10,),
                    SizedBox(height: 50, child: VerticalDivider(color: Colors.white.withOpacity(0.8),thickness: 1,)),
                   SizedBox(width: 10,),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       height: 95,
                       width: 55,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15),
                           color: Color(0x90BC002D),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0x30bc002d),
//                               blurRadius: 5,
//                               offset: Offset(0, 10),
//                             )
//                           ]
                       ),
                       child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           SizedBox(height: 9,),
                           Text('A-',style: TextStyle(color:Colors.white.withOpacity(0.8),fontWeight: FontWeight.bold,fontFamily: 'nunito',fontSize: 25),),
                           SizedBox(width:35,child: Divider(color: Colors.white,)),
                           Text('1',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'nunito',fontSize: 20,color: Colors.white.withOpacity(0.8)),),
                           SizedBox(height: 6,),
                         ],
                       ),
                     ),
                   ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 95,
                        width: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0x90E53033),
//                            boxShadow: [
//                              BoxShadow(
//                                color: Color(0x30bc002d),
//                                blurRadius: 5,
//                                offset: Offset(0, 10),
//                              )
//                            ]
                        ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(height: 9,),
                            Text('B-',style: TextStyle(color:Colors.white.withOpacity(0.8),fontWeight: FontWeight.bold,fontFamily: 'nunito',fontSize: 25),),
                            SizedBox(width:35,child: Divider(color: Colors.white,)),
                            Text('1',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'nunito',fontSize: 20,color: Colors.white.withOpacity(0.8)),),
                            SizedBox(height: 6,),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 95,
                        width: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0x90E53033),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x30bc002d),
                                blurRadius: 5,
                                offset: Offset(0, 10),
                              )
                            ]
                        ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(height: 9,),
                            Text('O+',style: TextStyle(color:Colors.white.withOpacity(0.8),fontWeight: FontWeight.bold,fontFamily: 'nunito',fontSize: 25),),
                            SizedBox(width:35,child: Divider(color: Colors.white,)),
                            Text('2',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'nunito',fontSize: 20,color: Colors.white.withOpacity(0.8)),),
                            SizedBox(height: 6,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
           SizedBox(height: 20,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal:25.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Text('Select Location',style: GoogleFonts.montserrat(fontSize: 14,fontWeight:  FontWeight.w500,color: kMainRed,),),
                         SizedBox(height: 10,),
                         Container(
                           width: 170,
                           //height: 50,
                          // padding: EdgeInsets.all(5),
                           child: Container(
                             //padding: EdgeInsets.all(20.0),
                             child: DropdownButton(
                                 value: _value1,
                                 items: [
                                   DropdownMenuItem(
                                     child: Text("-select-",style: TextStyle(color: Colors.grey),),
                                     value: 0,
                                   ),
                                   DropdownMenuItem(
                                     child: Text("Chennai",style: TextStyle(color: Colors.black,fontSize: 14),),
                                     value: 1,
                                   ),
                                   DropdownMenuItem(
                                     child: Text("Bangalore",style: TextStyle(color: Colors.black,fontSize: 14),),
                                     value: 2,
                                   ),
                                 ],
                                 onChanged: (value) {
                                   setState(() {
                                     _value1 = value;
                                   });
                                 }),
                           ),
                         ),
                       ],
                     ),
                     //SizedBox(width: 25,),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Text('Blood Type',style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w500,color: kMainRed,),),
                         SizedBox(height: 10,),
                         Container(
                           width: 145,
                           // padding: EdgeInsets.all(5),
                           decoration: BoxDecoration(
//                               border: Border(bottom: BorderSide(
//                                   color: Colors.grey[200]
//                               ))
                           ),
                           child:  Container(
                             //padding: EdgeInsets.all(20.0),
                             child: DropdownButton(
                                 value: _value,
                                 items: [
                                   DropdownMenuItem(
                                     child: Text("-select-",style: TextStyle(color: Colors.black,fontSize: 14),),
                                     value: 0,
                                   ),
                                   DropdownMenuItem(
                                     child: Text("A+ (Positive)",style: TextStyle(color: Colors.black,fontSize: 14),),
                                     value: 1,
                                   ),
                                   DropdownMenuItem(
                                     child: Text("A- (Negative)",style: TextStyle(color: Colors.black,fontSize: 14),),
                                     value: 2,
                                   ),
                                   DropdownMenuItem(
                                       child: Text("B+ (Positive)",style: TextStyle(color: Colors.black,fontSize: 14),),
                                       value: 3
                                   ),
                                   DropdownMenuItem(
                                       child: Text("B- (Negative)",style: TextStyle(color: Colors.black,fontSize: 14),),
                                       value: 4
                                   ),
                                   DropdownMenuItem(
                                     child: Text("AB+ (Positive)",style: TextStyle(color: Colors.black,fontSize: 14),),
                                     value: 5,
                                   ),
                                   DropdownMenuItem(
                                     child: Text("AB- (Negative)",style: TextStyle(color: Colors.black,fontSize: 14),),
                                     value: 6,
                                   ),
                                   DropdownMenuItem(
                                     child: Text("O+ (Positive)",style: TextStyle(color: Colors.black,fontSize: 14),),
                                     value: 7,
                                   ),
                                   DropdownMenuItem(
                                     child: Text("O- (Negative)",style: TextStyle(color: Colors.black,fontSize: 14),),
                                     value: 8,
                                   ),
                                   DropdownMenuItem(
                                     child: Text("Oh/hh",style: TextStyle(color: Colors.black,fontSize: 14),),
                                     value: 9,
                                   ),
                                 ],
                                 onChanged: (value) {
                                   setState(() {
                                     _value = value;
                                   });
                                 }),
                           )
                         ),
                       ],
                     ),
                     //SizedBox(width: 1,)
                   ],
                 ),
                 SizedBox(height: 20,),
                 GestureDetector(
                   onTap: (){Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) {
                         return MyRequests();
                       },
                     ),
                   );
                   },
                   child: Container(height: 53,
                     width: double.infinity,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       border: Border.all(color: kMainRed,width: 1.5),
                     ),
                     padding: EdgeInsets.all(15),
                     child:Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text('My Requests',style:TextStyle(color:kMainRed,fontSize: 13,fontWeight: FontWeight.bold,fontFamily: 'Montserrat')),
                         Icon(Icons.arrow_forward,color: kMainRed,size: 20,),
                       ],
                     ),
                     ),
                 ),
                 SizedBox(height: 30,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                     Text('My Donations',style: GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.w500,),)
                   ],
                 ),
                 SizedBox(height: 10,),
                 Container(
                   height: 120,
                   width: 450,
                   child: FutureBuilder(
                     // stream: dbRef.onValue,
                       future: FirebaseDatabase().reference().child("User/${loggedInUser.uid}/MyDonations").once(),
                       builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                         if (!snapshot.hasData) {
                         return Container(
                         child: Text("Nothing to Show"),
                         );
                         }
                         else {
                           if (snapshot.data != null) {
                             lists.clear();
                             Map<dynamic, dynamic> values = snapshot.data.value;
                             if(values!=null){
                               values.forEach((key, values) {
                                 lists.add(values);
                               });
                               // count1 = lists.length;
                               return new ListView.builder(
                                 // shrinkWrap: true,
                                   itemCount: lists.length,
                                   // physics: ScrollPhysics(),
                                   scrollDirection: Axis.horizontal,
                                   itemBuilder:
                                       (BuildContext context, int index) {
                                     return Row(
                                       children: [
                                         Padding(
                                           padding: const EdgeInsets.symmetric(
                                             vertical: 8.0,
                                           ),
                                           child: Container(
                                             height: 109,
                                             width: MediaQuery.of(context)
                                                 .size
                                                 .width -
                                                 20,
                                             decoration: BoxDecoration(
                                                 color: Colors.white,
                                                 borderRadius:
                                                 BorderRadius.circular(15),
                                                 border: Border.all(
                                                     color: kMainRed,
                                                     width: 1.2),
                                                 boxShadow: [
                                                   BoxShadow(
                                                     color: Colors.black
                                                         .withOpacity(0.1),
                                                     blurRadius: 8,
                                                     offset: Offset(0, 4),
                                                   )
                                                 ]),
                                             child: Row(
                                               children: <Widget>[
                                                 Container(
                                                   width: 75,
                                                   child: Column(
                                                     crossAxisAlignment:
                                                     CrossAxisAlignment
                                                         .center,
                                                     mainAxisAlignment:
                                                     MainAxisAlignment
                                                         .center,
                                                     children: <Widget>[
                                                       SizedBox(height:1),
                                                       Text(
                                                         "  ${lists[index]["BloodType"].toString()}",
                                                         style: TextStyle(
                                                             fontSize: 22,
                                                             color: kMainRed,
                                                             fontWeight:
                                                             FontWeight
                                                                 .bold,
                                                             fontFamily:
                                                             'nunito'),
                                                       ),
                                                       Padding(
                                                         padding:
                                                         const EdgeInsets
                                                             .only(
                                                             left: 5),
                                                         child: Text(
                                                           'Type',
                                                           style: TextStyle(
                                                               fontSize: 13,
                                                               color: Colors
                                                                   .black,
                                                               fontFamily:
                                                               'nunito'),
                                                         ),
                                                       ),
                                                     ],
                                                   ),
                                                 ),
                                                 SizedBox(
                                                     height: 35,
                                                     child: VerticalDivider(
                                                       color: Colors.black,
                                                       thickness: 1,
                                                     )),
                                                 SizedBox(
                                                   width: 5,
                                                 ),
                                                 Column(
                                                   crossAxisAlignment:
                                                   CrossAxisAlignment
                                                       .start,
                                                   mainAxisAlignment:
                                                   MainAxisAlignment
                                                       .center,
                                                   children: <Widget>[
                                                     Text(
                                                       'Hospital Name :  ${lists[index]["Hospital"].toString()}',
                                                       style: TextStyle(
                                                           fontSize: 12.5,
                                                           fontFamily:
                                                           'nunito',
                                                           color:
                                                           Colors.black),
                                                     ),
                                                     Text(
                                                       'Units Required :  ${lists[index]["Units"].toString()}',
                                                       style: TextStyle(
                                                           fontSize: 12.5,
                                                           fontFamily:
                                                           'nunito',
                                                           color:
                                                           Colors.black),
                                                     ),
                                                     Text(
                                                       'Deadline :  ${lists[index]["Deadline"].toString()}',
                                                       style: TextStyle(
                                                           fontSize: 12.5,
                                                           fontFamily:
                                                           'nunito',
                                                           color:
                                                           Colors.black),
                                                     ),
                                                     Text(
                                                       'Contact Number :  ${lists[index]["ContactNumber"].toString()}',
                                                       style: TextStyle(
                                                           fontSize: 12.5,
                                                           fontFamily:
                                                           'nunito',
                                                           color:
                                                           Colors.black),
                                                     ),
                                                     SizedBox(height:2),
                                                     Container(
                                                       alignment: Alignment.centerRight,
                                                       width: MediaQuery.of(context).size.width-140,
                                                       child: GestureDetector(
                                                         onTap: (){
                                                           setState(() {

                                                             FirebaseDatabase.instance.reference().child('User/${loggedInUser.uid}/MyDonations/$index')
                                                                 .remove()
                                                                 .then((_) {
                                                               Scaffold.of(context).showSnackBar(
                                                                   SnackBar(content: Text('Canceled Successfully')));
                                                             }).catchError((onError) {
                                                               Scaffold.of(context)
                                                                   .showSnackBar(SnackBar(content: Text(onError)));
                                                             });


//                                                           FirebaseDatabase.instance.reference()
//                                                               .child('User/${loggedInUser.uid}/MyDonations')
//                                                               .equalTo('${lists[index]}')
//                                                               .once()
//                                                               .then(
//                                                                   (DataSnapshot snapshot) {
//                                                                 Map<dynamic, dynamic> children =
//                                                                     snapshot.value;
//                                                                 children.forEach((key, value) {
//                                                                   FirebaseDatabase.instance.reference()
//                                                                       .child('User/${loggedInUser.uid}/MyDonations')
//                                                                       .child(key)
//                                                                       .remove().then((_) {
//                                                                     Scaffold.of(context).showSnackBar(
//                                                                         SnackBar(content: Text('Canceled Successfully')));
//                                                                   }).catchError((onError) {
//                                                                     Scaffold.of(context)
//                                                                         .showSnackBar(SnackBar(content: Text(onError)));
//                                                                   });
//
//
//                                                                 });
//                                                               });
//


                                                           });

                                                         },
                                                         child: Text(
                                                           'Cancel Availability',
                                                           style: TextStyle(
                                                               fontWeight: FontWeight.w700,
                                                               fontSize: 11,
                                                               fontFamily: 'nunito',
                                                               color: kMainRed),
                                                         ),
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                               ],
                                             ),
                                           ),
                                         ),
                                         SizedBox(
                                           width: 15,
                                         )
                                       ],
                                     );
                                   });
                             }

                           }
                         }

                          return Container(
                            color: kGrey.withOpacity(0.1),
                            child: Center(child: Text('Nothing to show')),);
                       }
                       ),
                 ),
                 SizedBox(height: 30,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                     Text('Emergencies Near me',style: GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.w500,),),
                     GestureDetector(
                         onTap: (){
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) {
                                 return AllEmergencies();
                               },
                             ),
                           );
                         },
                         child: Text('view all',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),)),
                   ],
                 ),
                 SizedBox(height: 10,),
                 Container(
                   height: 110,
                   width: 450,
                   child: FutureBuilder(
                     // stream: dbRef.onValue,
                       future: _firbaseref.once(),
                       builder:
                           (context, AsyncSnapshot<DataSnapshot> snapshot) {
                         // builder: (context, snapshot) {
                         if (snapshot.hasData) {
                           lists.clear();
                           Map<dynamic, dynamic> values = snapshot.data.value;
                           values.forEach((key, values) {
                             lists.add(values);
                           });
                           count1 = lists.length;

                           return new ListView.builder(
                             // shrinkWrap: true,
                               itemCount: 3,
                               // physics: ScrollPhysics(),
                               scrollDirection: Axis.horizontal,
                               itemBuilder: (BuildContext context, int index) {
                                 String bt=lists[index]["BloodType"].toString();
                                 String hp=lists[index]["Hospital"].toString();
                                 String dl=lists[index]["Deadline"].toString();
                                 String ut=lists[index]["Units"].toString();
                                 String cn=lists[index]["ContactNumber"].toString();

                                 return Row(
                                   children: [
                                     GestureDetector(
                                       onTap: () {
                                         setState(() {
                                           _showcontent(bt,cn,ut,dl,hp);
                                         });
                                       },
                                       child: Padding(
                                         padding: const EdgeInsets.symmetric(
                                           vertical: 8.0,
                                         ),
                                         child: Container(
                                           height: 100,
                                           width: MediaQuery.of(context)
                                               .size
                                               .width -
                                               20,
                                           decoration: BoxDecoration(
                                               color: Colors.white,
                                               borderRadius:
                                               BorderRadius.circular(15),
                                               border: Border.all(
                                                   color: kMainRed,
                                                   width: 1.2),
                                               boxShadow: [
                                                 BoxShadow(
                                                   color: Colors.black
                                                       .withOpacity(0.1),
                                                   blurRadius: 8,
                                                   offset: Offset(0, 4),
                                                 )
                                               ]),
                                           child: Row(
                                             children: <Widget>[
                                               Container(
                                                 width: 75,
                                                 child: Column(
                                                   crossAxisAlignment:
                                                   CrossAxisAlignment
                                                       .center,
                                                   mainAxisAlignment:
                                                   MainAxisAlignment
                                                       .center,
                                                   children: <Widget>[
                                                     Text(
                                                       "  ${lists[index]["BloodType"].toString()}",
                                                       style: TextStyle(
                                                           fontSize: 22,
                                                           color: kMainRed,
                                                           fontWeight:
                                                           FontWeight.bold,
                                                           fontFamily:
                                                           'nunito'),
                                                     ),
                                                     Padding(
                                                       padding:
                                                       const EdgeInsets
                                                           .only(left: 5),
                                                       child: Text(
                                                         'Type',
                                                         style: TextStyle(
                                                             fontSize: 13,
                                                             color:
                                                             Colors.black,
                                                             fontFamily:
                                                             'nunito'),
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                               ),
                                               SizedBox(
                                                   height: 35,
                                                   child: VerticalDivider(
                                                     color: Colors.black,
                                                     thickness: 1,
                                                   )),
                                               SizedBox(
                                                 width: 5,
                                               ),
                                               Column(
                                                 crossAxisAlignment:
                                                 CrossAxisAlignment.start,
                                                 mainAxisAlignment:
                                                 MainAxisAlignment.center,
                                                 children: <Widget>[
                                                   Text(
                                                     'Hospital Name :  ${lists[index]["Hospital"].toString()}',
                                                     style: TextStyle(
                                                         fontSize: 12.5,
                                                         fontFamily: 'nunito',
                                                         color: Colors.black),
                                                   ),
                                                   Text(
                                                     'Units Required :  ${lists[index]["Units"].toString()}',
                                                     style: TextStyle(
                                                         fontSize: 12.5,
                                                         fontFamily: 'nunito',
                                                         color: Colors.black),
                                                   ),
                                                   Text(
                                                     'Deadline :  ${lists[index]["Deadline"].toString()}',
                                                     style: TextStyle(
                                                         fontSize: 12.5,
                                                         fontFamily: 'nunito',
                                                         color: Colors.black),
                                                   ),
                                                   Text(
                                                     'Contact Number :  ${lists[index]["ContactNumber"].toString()}',
                                                     style: TextStyle(
                                                         fontSize: 12.5,
                                                         fontFamily: 'nunito',
                                                         color: Colors.black),
                                                   ),
                                                 ],
                                               ),
                                             ],
                                           ),
                                         ),
                                       ),
                                     ),
                                     SizedBox(
                                       width: 15,
                                     )
                                   ],
                                 );
                               });
                         } else {
                           return Container(
                             child: Center(child: Text("Nothing To Show")),
                           );
                         }
                         return CircularProgressIndicator();
                       }),
                 ),

               ],
             ),
           )
          ],
        ),
      ),
//      bottomNavigationBar: CurvedNavigationBar(
//        index: 1,
//        backgroundColor: Colors.white,
//        color: Color(0xffE53033),
//        buttonBackgroundColor: Color(0xffE53033),
//        height: 50,
//        items: <Widget>[
//          Icon(Icons.add, size: 22,color: Colors.white,),
//          Icon(Icons.home, size: 22,color: Colors.white,),
//          Icon(Icons.person, size: 22,color: Colors.white,),
//        ],
//        onTap: (index) {
//          if(index==1)
//            {
//
//            }
//          else if(index==2)
//            {
//              Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) {
//                    return Profile();
//                  },
//                ),
//              );
//            }
//          else
//            {
//
//            }
//          //Handle button tap
//        },
//      ),
    );
  }
}

