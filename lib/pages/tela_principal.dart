import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class TelaDeCaptura extends StatefulWidget {
  @override
  _TelaDeCapturaState createState() => _TelaDeCapturaState();
}

class _TelaDeCapturaState extends State<TelaDeCaptura> {
  TextEditingController _textFieldController = TextEditingController();

  List<String> capturaTexto = [];

  @override
  void initState() {
    super.initState();
    _loadCaptura();
  }

  Future<void> _loadCaptura() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      capturaTexto = prefs.getStringList('capturaTexto') ?? [];
    });
  }

  Future<void> _saveCaptura() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('capturaTexto', capturaTexto);
  }

  Future<void> _editCaptura(int index) async {
    TextEditingController editController = TextEditingController();
    editController.text = capturaTexto[index];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Editar Captura", style: TextStyle(color: Colors.black)),
          content: TextFormField(
            controller: editController,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  capturaTexto[index] = editController.text;
                  _saveCaptura();
                });
                Navigator.of(context).pop();
              },
              child: Text("Salvar", style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar", style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteCaptura(int index) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar Exclusão"),
          content: Text("Tem certeza que deseja excluir esta informação?"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  capturaTexto.removeAt(index);
                  _saveCaptura();
                });
                Navigator.of(context).pop();
              },
              child: Text("Salvar", style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar", style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E4E62),
              Color(0xFF21606F),
              Color(0xFF267177),
              Color(0xFF26797D),
              Color(0xFF2A8485),
            ],
          ),
        ),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Digite seu texto",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              TextFormField(
                                controller: _textFieldController,
                                decoration: InputDecoration(
                                  labelText: "Digite seu texto",
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                                onFieldSubmitted: (text) {
                                  if (text.isNotEmpty) {
                                    setState(() {
                                      capturaTexto.add(text);
                                      _saveCaptura();
                                      _textFieldController.clear();
                                    });
                                  }
                                },
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: capturaTexto.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(capturaTexto[index]),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      _editCaptura(index);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      _deleteCaptura(index);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextButton(
                        onPressed: () async {
                          final url = Uri.parse('https://google.com');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            print('Falha ao acessar');
                          }
                        },
                        child: Text(
                          'Política de Privacidade',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Roboto'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    home: TelaDeCaptura(),
  ));
}
