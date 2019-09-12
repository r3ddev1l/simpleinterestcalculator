import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Simple Interest Calculator",
    home: SIform(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

class SIform extends StatefulWidget {
  @override
  _SIformState createState() => _SIformState();
}

class _SIformState extends State<SIform> {
  var _formKey = GlobalKey<FormState>();
  final _minimumPadding = 5.00;
  var curencies = ['Rupees', 'Dollar', 'Pound'];
  var _currentItem = '';

  @override
  void initState() {
    super.initState();
    _currentItem = curencies[0];
  }

  var displayResult = "";
  TextEditingController principalController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
        // resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Simple Interest Calculator"),
          backgroundColor: Colors.black,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(_minimumPadding),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding: EdgeInsets.all(_minimumPadding),
                    child: TextFormField(
                      style: textStyle,
                      controller: principalController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter principal amount.";
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.red),
                          labelText: 'Principal',
                          hintText: 'Enter Principal amount',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.all(_minimumPadding),
                    child: TextFormField(
                      style: textStyle,
                      controller: rateController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter interest rate.";
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.red),
                          labelText: 'Interest',
                          hintText: 'Enter Interest Rate in %',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.all(_minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          style: textStyle,
                          controller: timeController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please enter time.";
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              errorStyle: TextStyle(color: Colors.red),
                              labelText: 'Time',
                              hintText: 'Enter Time period in years',
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )),
                        Container(
                          width: _minimumPadding * 5,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                          style: textStyle,
                          items: curencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currentItem,
                          onChanged: (String newValueSelected) {
                            _onDropDownItemSelected(newValueSelected);
                          },
                        ))
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          child: Text(
                            'Calculate',
                          ),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState.validate())
                                this.displayResult = _calculateTotalReturn();
                            });
                          },
                        ),
                      ),
                      Container(
                        width: _minimumPadding,
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          child: Text(
                            'Reset',
                          ),
                          onPressed: () {
                            setState(() {
                              reset();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding),
                  child: Text(
                    this.displayResult,
                    style: textStyle,
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage("images/sic.png");
    Image image = Image(
      image: assetImage,
      width: 125.00,
      height: 125.00,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 5),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItem = newValueSelected;
    });
  }

  String _calculateTotalReturn() {
    double principal = double.parse(principalController.text);
    double rate = double.parse(rateController.text);
    double time = double.parse(timeController.text);

    double total = (principal * rate * time) / 100;
    String result =
        'After $time years, your investment will be worth $total $_currentItem';
    return result;
  }

  void reset() {
    principalController.text = "";
    rateController.text = "";
    timeController.text = "";
    displayResult = "";
    _currentItem = curencies[0];
  }
}
