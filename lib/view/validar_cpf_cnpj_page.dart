
import 'package:flutter/material.dart';
import 'package:apkinvertexto/service/invertexto_service.dart';

class ValidarCpfCnpjPage extends StatefulWidget {
	const ValidarCpfCnpjPage({super.key});

	@override
	State<ValidarCpfCnpjPage> createState() => _ValidarCpfCnpjPageState();
}

class _ValidarCpfCnpjPageState extends State<ValidarCpfCnpjPage> {
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
								labelText: 'Digite o CPF ou CNPJ',
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
												future: apiService.validarCpfCnpj(campo),
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
					Text('Valor: ${data["value"] ?? ""}', style: TextStyle(color: Colors.white, fontSize: 16)),
					Text('Tipo: ${data["type"] ?? ""}', style: TextStyle(color: Colors.white, fontSize: 16)),
					Text('Válido: ${data["valid"] == true ? "Sim" : "Não"}', style: TextStyle(color: Colors.white, fontSize: 16)),
					if (data["message"] != null)
						Text('Mensagem: ${data["message"]}', style: TextStyle(color: Colors.white, fontSize: 16)),
				],
			),
		);
	}
}
