import 'package:aplikasikosan/pages/datapenyewa.dart';
import 'package:aplikasikosan/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

//test untuk git
//test untuk pull
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController selecteddate = TextEditingController();
  TextEditingController namacontroller = TextEditingController();
  TextEditingController ktpcontroller = TextEditingController();
  TextEditingController hpcontroller = TextEditingController();
  TextEditingController tglmasukcontroller = TextEditingController();
  TextEditingController nokamarcontroller = TextEditingController();
  Stream? PenyewaStream;

  getontheload()async{
    PenyewaStream = await DatabaseMethods().getPenyewa();
    setState(() {
      
    });
  }

  @override
  void initState() {
    getontheload();// TODO: implement initState
    super.initState();
  }

  Widget semuaPenyewa() {
    return StreamBuilder(
        stream: PenyewaStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Nama : "+ds["Nama"], //variable di dalam ds harus sama kayak di table firebase
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: (){
                                      namacontroller.text = ds["Nama"];
                                      ktpcontroller.text = ds["NoKTP"];
                                      hpcontroller.text = ds["NoHandphone"];
                                      selecteddate.text = ds["TglMasuk"];
                                      nokamarcontroller.text = ds["NoKamar"];
                                      EditPenyewa(ds["Id"]);
                                    },
                                    child: Icon(Icons.edit, color: Colors.orange,)),
                                    SizedBox(width: 5.0,),
                                    GestureDetector(
                                      onTap: ()async{
                                        await DatabaseMethods().deletePenyewa(ds["Id"]);
                                      },
                                      child: Icon(Icons.delete, color: Colors.orange))
                                ],
                              ),
                              Text(
                                "No. Kamar : "+ds["NoKamar"],
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              ),
                              Text(
                                "Tgl. Masuk : "+ds["TglMasuk"],
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              Text(
                                "No. HP : "+ds["NoHandphone"],
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => dataPenyewa()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Kost",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              " Grandma",
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: Column(
          children: [
            Expanded(child: semuaPenyewa()),
          ],
        ),
      ),
    );
  }

  Future EditPenyewa(String Id)=>showDialog(context: context, builder: (context)=> AlertDialog(
    content: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(children: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.cancel)),
            SizedBox(width: 60.0,),
            Text(
              "Edit",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              " Penyewa",
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            )
        ],),
        SizedBox(height: 15.0,),
        Text(
              "Nama",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15)),
              child: TextField(
                controller: namacontroller,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "No. KTP",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15)),
              child: TextField(
                controller: ktpcontroller,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "No. Handphone",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15)),
              child: TextField(
                controller: hpcontroller,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Tgl. Masuk",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15)),
              child: TextField(
                controller: selecteddate,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  // prefixIcon: Icon(Icons.calendar_today)
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickeddate = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2018),
                      lastDate: DateTime(2100));
                  if (pickeddate != null) {
                    String formatdate =
                        DateFormat('dd-MMM-yyyy').format(pickeddate);
                    setState(() {
                      selecteddate.text = formatdate;
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "No. Kamar",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15)),
              child: TextField(
                controller: nokamarcontroller,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () async{
                  Map<String, dynamic> editInfoMap={
                      "Id": Id,
                      "Nama": namacontroller.text,
                      "NoKTP": ktpcontroller.text, //NoKTP nanti dijadikan nama field di database *tidak boleh ada spasi
                      "NoHandphone": hpcontroller.text,
                      "TglMasuk": selecteddate.text,
                      "NoKamar": nokamarcontroller.text
                  };
                  await DatabaseMethods().editPenyewa(Id, editInfoMap).then((value) {
                    Navigator.pop(context);
                  });
                }, child: Text("Edit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
            )
      ],),
    ),
  ));

}
