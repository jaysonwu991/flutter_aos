import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String areaCode = '+86';
  bool obscureStatus = true;
  final _formKey = GlobalKey<FormState>();

  String phoneNumber = '';
  String password = '';

  void _changeAreaCode(String newAreaCode) {
    setState(() {
      areaCode = newAreaCode;
    });
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
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    print('PhoneNumber Is $phoneNumber, Password Is $password');

                    return;
                  }
                  print('Data Is Missing!!!');
                },
                child: Text(
                  'Login',
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
