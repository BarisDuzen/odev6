import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Örneği',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kullanıcı Bilgi Formu'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: UserInfoForm(),
        ),
      ),
    );
  }
}

class UserInfoForm extends StatefulWidget {
  @override
  _UserInfoFormState createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> {
  // FormState'e erişmek için GlobalKey tanımlıyoruz
  final _formKey = GlobalKey<FormState>();

  // Doğrulama işlemleri için e-posta formatını kontrol eden RegExp tanımlıyoruz
  final emailRegex = RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  // Form alanları
  String? name;
  String? email;
  String? password;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Tüm doğrulamalar geçildiğinde yapılacak işlemler
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Form Başarılı"),
            content: Text("Bilgileriniz başarıyla kaydedildi."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Tamam"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'İsim'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'İsim alanı boş olamaz';
              }
              return null;
            },
            onSaved: (value) => name = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'E-posta'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'E-posta alanı boş olamaz';
              } else if (!emailRegex.hasMatch(value)) {
                return 'Geçerli bir e-posta adresi girin';
              }
              return null;
            },
            onSaved: (value) => email = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Şifre'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Şifre alanı boş olamaz';
              } else if (value.length < 6) {
                return 'Şifre en az 6 karakter olmalıdır';
              }
              return null;
            },
            onSaved: (value) => password = value,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Formu Gönder'),
          ),
        ],
      ),
    );
  }
}
