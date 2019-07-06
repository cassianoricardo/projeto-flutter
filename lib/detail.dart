import 'package:flutter/material.dart';
import 'package:flutter_app/usuario.dart';
import 'package:flutter_app/usuarioDAO.dart';

class DetailPage extends StatefulWidget {
  Usuario usuario;

  DetailPage({this.usuario});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final _controllerNome = TextEditingController(text: widget.usuario?.name);
    final _controllerEndereco = TextEditingController(text: widget.usuario?.endereco);



    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {Navigator.of(context).pop();},
    );

    Widget yesButtonDelete = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        UsuarioDAO().delete(widget.usuario.id);
         Navigator.pop(context);
         Navigator.pop(context);
      },
    );

    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
        },
    );



    return Scaffold(
      appBar: AppBar(
        title: Text("Dados do usuário"),
      ),
      body: Column(
        children: <Widget>[
          //INPUT DE NOME
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: true,
              controller: _controllerNome,
              decoration: InputDecoration(
                labelText: "Nome:",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          //INPUT DE ENDEREÇO
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: true,
              controller: _controllerEndereco,
              decoration: InputDecoration(
                labelText: "Endereço:",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
              ),
            ),
          ),
       
          RaisedButton(
            onPressed: () {

              if(widget.usuario == null){
                widget.usuario = Usuario(name: _controllerNome.text, endereco: _controllerEndereco.text );
              }
              else{
                widget.usuario.name = _controllerNome.text;
                widget.usuario.endereco = _controllerEndereco.text;
              }

              if(_controllerNome.text.isEmpty  ){
                showDialog(context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      content: new Text("preencha o nome!"),
                      actions: <Widget>[okButton],
                    );
                  }
                );
                return;
              }
              if(_controllerEndereco.text.isEmpty  ){
                showDialog(context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        content: new Text("preencha o endereco!"),
                        actions: <Widget>[okButton],
                      );
                    }
                );
                return;
              }

              UsuarioDAO().insert(usuario: widget.usuario);
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
          widget.usuario  == null ? Container() : RaisedButton(
            onPressed: () {

              showDialog(context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    content: new Text("Tem certeza que deseja remover o usuario "+ _controllerNome.text + "?"),
                    actions: <Widget>[cancelButton, yesButtonDelete],
                  );
                }
              );
            },
            child: Text("Apagar"),
          )
        ],
      ),

    );
  }
}
