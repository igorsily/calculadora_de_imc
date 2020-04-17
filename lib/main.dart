import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de IMC',
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _infoText = "";
  bool _isButtonDisabled = true;
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    weightController.clear();
    heightController.clear();
    setState(() {
      _infoText = "";
      _formKey = GlobalKey<FormState>();
      _isButtonDisabled = true;
    });
  }

  void _calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double result = weight / (height * height);

    String aux;
    String imc = result.toStringAsPrecision(4);

    if (result < 18.5) {
      aux = "MAGREZA, Obesidade GRAU 0 ($imc)";
    }

    if (result >= 18.5 && result <= 24.9) {
      aux = "NORMAL, Obesidade GRAU 0 ($imc)";
    }

    if (result >= 25 && result <= 29.9) {
      aux = "SOBREPESO, Obesidade GRAU I ($imc)";
    }

    if (result >= 30 && result <= 39.9) {
      aux = "OBESIDADE, Obesidade GRAU II ($imc)";
    }

    if (result >= 40) {
      aux = "OBESIDADE GRAVE, Obesidade GRAU III ($imc)";
    }

    setState(() {
      _infoText = aux;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        actions: <Widget>[
          Container(
            width: 50,
            child: IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
                size: 30,
              ),
              onPressed: _resetFields,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 22.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 125,
                color: Colors.deepOrange,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: weightController,
                style: TextStyle(
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  labelText: "Peso (Kg)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelStyle: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
                onChanged: (value) {
                  if (weightController.text.isNotEmpty &&
                      heightController.text.isNotEmpty) {
                    setState(() {
                      _isButtonDisabled = false;
                    });
                  } else {
                    setState(() {
                      _isButtonDisabled = true;
                    });
                  }
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira seu Peso";
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: heightController,
                style: TextStyle(
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  labelText: "Altura (Cm)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelStyle: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
                onChanged: (value) {
                  if (weightController.text.isNotEmpty &&
                      heightController.text.isNotEmpty) {
                    setState(() {
                      _isButtonDisabled = false;
                    });
                  } else {
                    setState(() {
                      _isButtonDisabled = true;
                    });
                  }
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira sua altura";
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                child: RaisedButton(
                  color: _isButtonDisabled ? Colors.grey : Colors.deepOrange,
                  child: Text(
                    "Calcular",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(
                      color:
                          _isButtonDisabled ? Colors.grey : Colors.deepOrange,
                    ),
                  ),
                  onPressed: _isButtonDisabled
                      ? null
                      : () {
                          if (_formKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
