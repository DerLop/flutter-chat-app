

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat/widgets/chat_message.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

final _textController = TextEditingController();
final _focusNode = FocusNode();

final List<ChatMessage> _messages = [
  //ChatMessage(texto: 'Hola mundo', uid: '123'),
  //ChatMessage(texto: 'Hola mundo', uid: '123'),
  //ChatMessage(texto: 'Hola mundo', uid: '4544545454'),
 // ChatMessage(texto: 'Hola mundo', uid: '123'),
  //ChatMessage(texto: 'Hola mundo', uid: '454564'),
  //ChatMessage(texto: 'Hola mundo', uid: '123')
];

bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue[100],
                maxRadius: 14,
                child: Text('Te', style: TextStyle(fontSize: 12, color: Colors.blue)
                ),
              ),
              SizedBox(height: 3),
              Text('Melissa Flores', style: TextStyle(color: Colors.black87, fontSize: 12))
            ],
          ),
          centerTitle: true,
          elevation: 1,
      ),

      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
              ),
            ),
            Divider(height: 1),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (texto) {
                  setState(() {
                    if(texto.trim().isNotEmpty){
                      _estaEscribiendo = true;
                    }
                    else{
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar mensaje'
                ),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
              ? CupertinoButton(
                onPressed: _estaEscribiendo
                    ? () => _handleSubmit(_textController.text.trim())
                    : null,
                child: Text('Enviar', style: TextStyle(
                  color: _estaEscribiendo ? Colors.blue[400]
                  : CupertinoColors.inactiveGray)
                ),
              )
              : Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: IconTheme(
                  data: IconThemeData(color: Colors.blue[400]),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: _estaEscribiendo
                    ? () => _handleSubmit(_textController.text.trim())
                    : null,
                    icon: Icon(Icons.send)
                  ),
                ),
              )
            )
          ],
        ),
      )
    );
  }

void _handleSubmit(String texto){

  if(texto.isEmpty) return;

    print(texto);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(texto: texto, uid: '123', 
      animationController: AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400)
      )
    );
    _messages.insert(0, newMessage);

    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    // TODO: off socket
    for(ChatMessage message in _messages ){
      message.animationController.dispose();
    }
    super.dispose();
  }
}

