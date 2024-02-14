import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:flutter/material.dart';
import 'package:walletapp/database.dart';
import 'package:walletapp/home.dart';
import 'package:walletapp/tiles.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: myapp(),
  ));
}

class myapp extends StatefulWidget {
  const myapp({super.key});
  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController amountcontroller = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  String _date = '';
  int amountctr = 0;

  Database obj = Database();
  final box = Hive.box('mybox');
  @override
  void initState() {
    // TODO: implement initState
    if (box.isNotEmpty) {
      obj.load();
    }
    super.initState();
  }

  // static const List<Widget> _widgetOptions = <Widget>[
  //   home(),
  //   home(),
  //   home(),
  // ];
  // int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          // stops: [
          //   0.5,
          //   0.65,
          //   0.30,
          // ],
          colors: [
            Color.fromARGB(255, 146, 118, 237),
            Color.fromARGB(255, 184, 158, 236),
            Color.fromARGB(255, 243, 213, 247),
          ],
        ),
      ),
      child: Scaffold(
        // bottomNavigationBar: MoltenBottomNavigationBar(
        //   domeHeight: 25,
        //   domeCircleColor: Color.fromARGB(255, 77, 59, 101),
        //   selectedIndex: selectedIndex,
        //   onTabChange: (clickedIndex) {
        //     setState(() {
        //       selectedIndex = clickedIndex;
        //     });
        //   },
        //   tabs: [
        //     MoltenTab(
        //       icon: Icon(Icons.search),
        //     ),
        //     MoltenTab(
        //       icon: Icon(Icons.home),
        //     ),
        //     MoltenTab(
        //       icon: Icon(Icons.person),
        //     ),
        //   ],
        // ),
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(
              height: 45,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),

                Text(
                  " Wallet Acount ",
                  style: TextStyle(
                      color: Color.fromARGB(255, 69, 55, 119),
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 120,
                ),

                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('About'),
                            content: Text(
                                'Developed by:\n     Nimra Khalil \nEmail:\n    nimrakhalilofficial@gmail.com \n\n\n          App Version 1.0.0'),
                            actions: [
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Image.asset(
                      "assets/setting.png",
                      color: Colors.white,
                    )),
                // Container(
                //   padding: EdgeInsets.all(6),
                //   child: Image.asset(
                //     "assets/e.png",
                //   ),
                //   height: 44,
                //   width: 44,
                //   decoration: BoxDecoration(
                //       shape: BoxShape.circle, color: Colors.white),
                // )

// Icon(Icons.notifications, color: Color.fromARGB(255, 163, 43, 43), size: 30,)
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                Text("Available Balance",
                    style: TextStyle(
                      color: Color.fromARGB(255, 72, 42, 98),
                      fontSize: 13,
                    )),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                Text(
                  'Rs. ' + obj.totalAmount.toString(),
                  style: TextStyle(
                      color: Color.fromARGB(255, 72, 42, 98),
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Add balance"),
                          content: Container(
                            height: 40.0,
                            child: TextField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: "enter your amount"),
                            ),
                          ),
                          actions: <Widget>[
                            MaterialButton(
                              onPressed: () {
                                setState(() {
                                  int enteredAmount =
                                      int.parse(_amountController.text);
                                  obj.totalAmount =
                                      enteredAmount + obj.totalAmount;
                                  obj.save();
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Successfuly Added"),
                                  backgroundColor:
                                      Color.fromARGB(255, 120, 64, 197),
                                ));
                                Navigator.of(context).pop();
                                _amountController.clear();
                              },
                              child: Text(
                                'Add',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Color.fromARGB(255, 160, 124, 190),
                            ),
                            MaterialButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Color.fromARGB(255, 160, 124, 190),
                            )
                          ],
                        ),
                      );
                    },
                    child: const Text(
                      ' Add Balance ',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 255, 255, 255)),
                    )),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        obj.totalAmount = 0;
                        obj.expenselist.clear();
                      });
                    },
                    child: const Text(
                      ' Clean Wallet ',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 208, 24, 24)),
                    ))
              ],
            ),
            SizedBox(
              height: 38,
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 179, 155, 226), //New
                    blurRadius: 10.0,
                  )
                ],
                gradient: RadialGradient(
                  colors: [
                    Color.fromARGB(255, 146, 118, 237),
                    Color.fromARGB(255, 184, 158, 236),
                    Color.fromARGB(255, 243, 213, 247),
                  ],
                  center: Alignment(2.0, -0.3),
                  focal: Alignment(1.0, -0.1),
                  focalRadius: 1.0,
                ),
                color: Color.fromARGB(255, 129, 115, 147),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                ),
              ),
              child: ListView.builder(
                  itemCount: obj.expenselist.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return tiles1(
                        date: obj.expenselist[index][2],
                      );
                    }
                    return Dismissible(
                      // Specify the direction to swipe and delete
                      direction: DismissDirection.endToStart,
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        // Removes that item the list on swipwe
                        setState(() {
                          obj.expenselist.removeAt(index);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Successfuly Removed"),
                            backgroundColor: Color.fromARGB(255, 192, 4, 4),
                          ));
                          obj.save();
                        });
                        // Shows the information on Snackbar
                      },
                      background:
                          Container(color: Color.fromARGB(255, 217, 37, 5)),
                      child: ListTile(
                        leading: Container(
                          padding: EdgeInsets.all(7),
                          child: Image.asset(
                            "assets/checklist.png",
                            color: Colors.white,
                            height: 50,
                            width: 50,
                          ),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent),
                        ),
                        trailing: Text(
                          "-" + obj.expenselist[index][1].toString(),
                          style: TextStyle(
                              color: Color.fromARGB(255, 204, 2, 2),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        title: Text(
                          obj.expenselist[index][0],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    );
                  }),
              height: 465,
              width: 400,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(" Add your expenses "),
                content: Container(
                  height: 150,
                  width: 200,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 9.0),
                        child: TextField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: titlecontroller,
                            decoration: InputDecoration(hintText: "Title")),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 9.0),
                        child: TextField(
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.number,
                            controller: amountcontroller,
                            decoration: InputDecoration(hintText: "Amount")),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        setState(() {
                          int amountctr = int.parse(amountcontroller.text);
                          String titlectr = titlecontroller.text;

                          if (obj.totalAmount > amountctr) {
                            setState(() {
                              DateTime now = DateTime.now();
                              _date = DateFormat('yyyy-MM-dd').format(now);
                              obj.expenselist.add([titlectr, amountctr, _date]);
                              obj.totalAmount = obj.totalAmount - amountctr;
                              obj.save();

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Successfuly added"),
                                backgroundColor:
                                    Color.fromARGB(255, 120, 64, 197),
                              ));

                              amountcontroller.clear();
                              titlecontroller.clear();
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Not enough balance"),
                              backgroundColor: Color.fromARGB(255, 204, 2, 2),
                            ));
                          }
                        });
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Color.fromARGB(255, 160, 124, 190),
                  ),
                  MaterialButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Color.fromARGB(255, 160, 124, 190),
                  )
                  // TextButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       int amountctr = int.parse(amountcontroller.text);
                  //       String titlectr = titlecontroller.text;

                  //       if (obj.totalAmount > amountctr) {
                  //         setState(() {
                  //           obj.expenselist.add([titlectr, amountctr]);
                  //           obj.totalAmount = obj.totalAmount - amountctr;
                  //           obj.save();
                  //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //             content: Text("Successfuly added"),
                  //             backgroundColor: Color.fromARGB(255, 31, 29, 29),
                  //           ));
                  //           amountcontroller.clear();
                  //           titlecontroller.clear();
                  //         });
                  //       } else {
                  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //           content: Text("not eough balance"),
                  //           backgroundColor: Color.fromARGB(255, 31, 29, 29),
                  //         ));
                  //       }
                  //     });
                  //     Navigator.of(context).pop();
                  //   },
                  //   child: Container(
                  //     color: Color.fromARGB(255, 160, 124, 190),
                  //     padding: const EdgeInsets.all(14),
                  //     child: const Text(
                  //       "Add",
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          },
          backgroundColor: Color.fromARGB(255, 240, 242, 244),
          child: const Icon(
            Icons.add,
            color: Color.fromARGB(255, 72, 42, 98),
            size: 30,
          ),
        ),
      ),
    );
  }
}
