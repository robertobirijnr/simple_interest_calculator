import "package:flutter/material.dart";

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest Calculator",
    home: Interest(),
    theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.green),
  ));
}

class Interest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InterestState();
    throw UnimplementedError();
  }
}

class _InterestState extends State<Interest> {
  var _formKey = GlobalKey<FormState>();
  var _currencies = ["Cedis", "Dollars", "Pounds"];
  final _minimum_padding = 5.0;
  final _minimum_margin = 5.0;

  var _currencySeleted = "Cedis";

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResults = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Simple Interest App"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimum_margin * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimum_padding, bottom: _minimum_padding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: principalController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "please return principal Amount";
                      }
                      // if(value.String){
                      //
                      // }
                    },
                    decoration: InputDecoration(
                        labelText: 'Principal',
                        hintText: "Enter Principal e.g 12000",
                        errorStyle: TextStyle(
                          color:Colors.yellowAccent,
                          fontSize: 15.0
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimum_padding, bottom: _minimum_padding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: roiController,
                    validator: (String value){
                      if(value.isEmpty){
                        return "Please enter validator";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Rate of Interest",
                        hintText: "Enter Rate of Interest Here",
                        errorStyle: TextStyle(
                          color:Colors.yellowAccent,
                          fontSize:15.0
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimum_padding, bottom: _minimum_padding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: termController,
                          validator: (String value){
                            if(value.isEmpty){
                              return "Please enter term";
                            }
                          },
                          decoration: InputDecoration(
                              labelText: "Terms",
                              hintText: "Terms",
                              errorStyle: TextStyle(
                                color:Colors.yellowAccent,
                                fontSize: 15.0
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                      Container(width: _minimum_margin * 5),
                      Expanded(
                        child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currencySeleted,
                          onChanged: (String newValuesSelected) {
                            _onDropDownItemSelected(newValuesSelected);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        child: Text("Calculate"),
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState.validate()) {
                              this.displayResults = _calculateTotalInterest();
                            }
                          });
                        },
                      ),
                    ),
                    Container(width: _minimum_margin * 2),
                    Expanded(
                        child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      child: Text("Reset", textScaleFactor: 1.5),
                      onPressed: () {
                        setState(() {
                          reset();
                        });
                      },
                    ))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(_minimum_padding * 2),
                  child: Text(this.displayResults),
                )
              ],
            )),
      ),
    );
    throw UnimplementedError();
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/download.png');
    Image image = Image(image: assetImage, width: 125.0, height: 125.0);
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimum_padding * 10),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currencySeleted = newValueSelected;
    });
  }

  String _calculateTotalInterest() {
    double principal = double.parse(principalController.text);
    double rio = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * rio * term) / 100;
    String result =
        "After $term years your Investment will be worth $totalAmountPayable $_currencySeleted";

    return result;
  }

  void reset() {
    principalController.text = "";
    roiController.text = "";
    termController.text = "";
    displayResults = "";
    _currencySeleted = _currencies[0];
  }
}
