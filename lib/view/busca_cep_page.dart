import 'package:flutter/material.dart';
import 'package:apkinvertexto/service/invertexto_service.dart';

class BuscaCepPage extends StatefulWidget {
  const BuscaCepPage({super.key});

  @override
  State<BuscaCepPage> createState() => _BuscaCepPageState();
}

class _BuscaCepPageState extends State<BuscaCepPage> {
  String resultado = "";
  String campo = "";
  final apiService = InvertextoService();

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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Digite o CEP',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                setState(() {
                  campo = value;
                });
              },
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                future: apiService.buscaCEP(campo),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 8.0,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.error, color: Colors.red, size: 48),
                            SizedBox(height: 10),
                            Text(
                              'Erro',
                              style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${snapshot.error}',
                              style: TextStyle(color: Colors.white, fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return exibeResultado(context, snapshot);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget exibeResultado(BuildContext contexto, AsyncSnapshot snapshot) {
    final data = snapshot.data;
    if (data == null || data is! Map<String, dynamic>) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('CEP: [${data["cep"] ?? ""}', style: TextStyle(color: Colors.white, fontSize: 16)),
          Text('Logradouro: [${data["logradouro"] ?? ""}', style: TextStyle(color: Colors.white, fontSize: 16)),
          Text('Bairro: [${data["bairro"] ?? ""}', style: TextStyle(color: Colors.white, fontSize: 16)),
          Text('Cidade: [${data["cidade"] ?? ""}', style: TextStyle(color: Colors.white, fontSize: 16)),
          Text('Estado: [${data["estado"] ?? ""}', style: TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}
