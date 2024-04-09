import 'package:aplikasikosan/service/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

class dataPenyewa extends StatefulWidget {
  const dataPenyewa({super.key});

  @override
  State<dataPenyewa> createState() => _dataPenyewaState();
}

class _dataPenyewaState extends State<dataPenyewa> {
  TextEditingController selecteddate = TextEditingController();
  TextEditingController namacontroller = TextEditingController();
  TextEditingController ktpcontroller = TextEditingController();
  TextEditingController hpcontroller = TextEditingController();
  TextEditingController tglmasukcontroller = TextEditingController();
  TextEditingController nokamarcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    selecteddate.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Data",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              " Penyewa",
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nama",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
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
                  fontSize: 20.0,
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
                  fontSize: 20.0,
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
                  fontSize: 20.0,
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
                  fontSize: 20.0,
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
            SizedBox(height: 10.0),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () async {
                    String id = randomAlphaNumeric(3);
                    Map<String, dynamic> penyewaInfoMap = {
                      "Id": id,
                      "Nama": namacontroller.text,
                      "NoKTP": ktpcontroller.text, //NoKTP nanti dijadikan nama field di database *tidak boleh ada spasi
                      "NoHandphone": hpcontroller.text,
                      "TglMasuk": selecteddate.text,
                      "NoKamar": nokamarcontroller.text
                    };
                    await DatabaseMethods()
                        .tambahPenyewa(penyewaInfoMap, id)
                        .then((value) {
                      Fluttertoast.showToast(
                          msg: "Data Penyewa Berhasil Ditambahkan",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    });
                  },
                  child: Text(
                    "Tambah",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
