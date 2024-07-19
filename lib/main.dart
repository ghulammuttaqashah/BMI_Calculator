import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple BMI calculator",
      home: SIForm(),
      theme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.indigo,
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)))));
}

class SIForm extends StatefulWidget {
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formkey = GlobalKey<FormState>();
  TextEditingController weightcontroller = TextEditingController();
  TextEditingController heightcontroller = TextEditingController();
  var displayresult = "";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Simple BMI calculator",
        ),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          children: [
            getImage(),
            Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: weightcontroller,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter weight';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Weight',
                      hintText: 'Enter weight in kg',
                      labelStyle: textStyle,
                      errorStyle:
                          TextStyle(color: Colors.yellowAccent, fontSize: 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 35.0),
                child: TextFormField(
                  style: textStyle,
                  controller: heightcontroller,
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter height';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Height',
                      errorStyle:
                          TextStyle(color: Colors.yellowAccent, fontSize: 15.0),
                      labelStyle: textStyle,
                      hintText: 'Enter height in meters',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            this.displayresult = _calculateBMI();
                          });
                        }
                      },
                      child: Text(
                        textScaleFactor: 1.5,
                        "Calculate",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    )),
                    Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black26),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                            child: Text(
                              "Reset",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white70),
                            )))
                  ],
                )),
            Padding(
              padding: EdgeInsets.all(65.0),
              child: Text(
                displayresult,
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getImage() {
    AssetImage assetImage = AssetImage("images/bmi.png");
    Image image = Image(
      image: assetImage,
      width: 250.0,
      height: 250.0,
    );
    return Container(
      child: image,
      alignment: Alignment.center,
      margin: EdgeInsets.all(10.0),
    );
  }

  String _calculateBMI() {
    double weight = double.parse(weightcontroller.text);
    double height = double.parse(heightcontroller.text);
    double bmi = weight / (height * height);
    String result = "Your BMI is : ${bmi.toStringAsFixed(2)}";
    return result;
  }

  void _reset() {
    weightcontroller.text = '';
    heightcontroller.text = '';
    displayresult = '';
  }
}
