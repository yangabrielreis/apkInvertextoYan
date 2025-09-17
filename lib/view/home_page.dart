import 'package:apkinvertexto/view/busca_cep_page.dart';
import 'package:apkinvertexto/view/por_extenso_page.dart';
import 'package:apkinvertexto/view/validar_cpf_cnpj_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/imgs/image.png',
              fit: BoxFit.contain,
              height: 40,
            ),
          ],
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Row(
                children: <Widget>[
                  Icon(Icons.edit, color: Colors.white, size: 50),
                  SizedBox(width: 10),
                  Text(
                    'Por Extenso',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PorExtensoPage()),
                );
              },
            ),
            SizedBox(height: 30),
            GestureDetector(
              child: Row(
                children: <Widget>[
                  Icon(Icons.home, color: Colors.white, size: 50),
                  SizedBox(width: 10),
                  Text(
                    'Busca por CEP',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuscaCepPage()),
                );
              },
            ),
            SizedBox(height: 30),
            GestureDetector(
              child: Row(
                children: <Widget>[
                  Icon(Icons.verified_user, color: Colors.white, size: 50),
                  SizedBox(width: 10),
                  Text(
                    'Validar CPF/CNPJ',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ValidarCpfCnpjPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
