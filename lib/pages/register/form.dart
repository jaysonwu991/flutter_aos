import 'package:flutter/material.dart';

import '../login/index.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String areaCode = '+86';
  bool obscureStatus = true;
  final _formKey = GlobalKey<FormState>();

  String phoneNumber = '';
  String password = '';
  String rePassword = '';
  String vCode = '';

  void _changeAreaCode(String newAreaCode) {
    setState(() {
      areaCode = newAreaCode;
    });
  }

  void validateAndSave() {
    final FormState? form = _formKey.currentState;
    if (form?.validate() ?? false) {
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter Your Phone Number',
              prefixIcon: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: AreaCodePicker(areaCode, _changeAreaCode),
              ),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }

              return null;
            },
            onSaved: (String? value) => phoneNumber = value ?? '',
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
          ),
          TextFormField(
            obscureText: obscureStatus,
            decoration: InputDecoration(
              hintText: 'Enter Your Password',
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.lock_outline,
                  color: Colors.grey,
                ),
                tooltip: 'Show or hide our password',
                onPressed: () {
                  setState(() {
                    obscureStatus = !obscureStatus;
                  });
                },
              ),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }

              return null;
            },
            onSaved: (String? value) => password = value ?? '',
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
          ),
          TextFormField(
            obscureText: obscureStatus,
            decoration: InputDecoration(
              hintText: 'Enter Your Password Again',
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.lock_outline,
                  color: Colors.grey,
                ),
                tooltip: 'Show or hide our password',
                onPressed: () {
                  setState(() {
                    obscureStatus = !obscureStatus;
                  });
                },
              ),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password again';
              }

              return null;
            },
            onSaved: (String? value) => rePassword = value ?? '',
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter Your VCode',
              suffixIcon: Material(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                  child: Text(
                    "Get VCode",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
                borderRadius: BorderRadius.circular(30.0),
                // shadowColor: Colors.grey,
                // elevation: 5.0,
              ),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your vcode';
              }

              return null;
            },
            onSaved: (String? value) => vCode = value ?? '',
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 40.0),
          ),
          Center(
            child: SizedBox(
              width: 800.0,
              height: 40.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                onPressed: () {
                  print(_formKey.currentState?.validate());
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    print(
                        'PhoneNumber Is $phoneNumber, Password Is $password, RePassword Is $rePassword, VCode Is $vCode');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage(),
                      ),
                    );
                    _formKey.currentState?.reset();

                    return;
                  }
                  print('Data Is Missing!!!');
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AreaCodePicker extends StatelessWidget {
  final String areaCode;
  final Function changeAreaCode;

  AreaCodePicker(this.areaCode, this.changeAreaCode);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: areaCode,
      isDense: false,
      // isExpanded: true,
      onChanged: (String? newAreaCode) {
        changeAreaCode(newAreaCode!);
      },
      items: <String>['+86', '+852', '+853', '+886']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
