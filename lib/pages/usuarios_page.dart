


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';


class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  



  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  final usuarios = [
    Usuario(uid: '1', nombre: 'Maria', email: 'maria@test.com', online: true),
    Usuario(uid: '2', nombre: 'José', email: 'jose@test.com', online: false),
    Usuario(uid: '3', nombre: 'Antonio', email: 'antonio@test.com', online: true),
    Usuario(uid: '4', nombre: 'Huã', email: 'hua@test.com', online: true),
    Usuario(uid: '5', nombre: 'Pedro', email: 'pedro@test.com', online: true)
  ];
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    return Scaffold(
      appBar: AppBar(
          title: Text(usuario!.nombre, 
          style: TextStyle(
            color: Colors.black87
            ),
            ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            //TODO: desconectar el socket server

            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          }, 
          icon: Icon(Icons.exit_to_app), 
          color: Colors.black87
          ),
          actions: [
            Container(
              margin: EdgeInsets.only( right: 10 ),
              child: Icon(Icons.check_circle, color: Colors.blue[400]),
            )
          ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(
            Icons.check, 
            color: Colors.blue[400]
          ),
          waterDropColor: Colors.blue.shade400
        ),
        child: _listViewUsuarios()
      )
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]), 
      separatorBuilder:(_, i) => Divider(), 
      itemCount: usuarios.length
      );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
        title: Text(usuario.nombre),
        subtitle: Text(usuario.email),
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(usuario.nombre.substring(0,2),
          style: TextStyle(color: Colors.blue)
          ),
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)
          ),
        ),
      );
  }

  void _cargarUsuarios() async{
    
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();

  }

  
}