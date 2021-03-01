import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memos/feature/login/model/current_user.dart';
import 'package:memos/feature/memos/presentation/bloc/share/share_bloc.dart';
import 'package:provider/provider.dart';

class EmailAlert extends StatefulWidget {
  final String memoId;
  EmailAlert({
    Key key,
    @required this.memoId,
  }) : super(key: key);

  @override
  _EmailAlertState createState() => _EmailAlertState();
}

class _EmailAlertState extends State<EmailAlert> {
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShareBloc>(context).add(ResetShare());
    _emailController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Inserisci email utente'),
      content: BlocBuilder<ShareBloc, ShareState>(
        builder: (context, state) {
          if (state is ShareInitial) {
            return TextField(
              controller: _emailController,
            );
          } else if (state is ShareFailure) {
            return Text(state.failure.toString());
          } else if (state is ShareUserNotFound) {
            return Text('Utente non trovato');
          } else if (state is ShareSuccess) {
            return Text('Memo condivisa');
          } else if (state is ShareMemoAlreadyShared) {
            return Text('Memo già condivisa');
          }

          return Container(
            height: 35,
            width: 10,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      actions: [
        BlocBuilder<ShareBloc, ShareState>(
          builder: (context, state) {
            if (state is ShareSuccess) {
              return FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Chiudi'),
              );
            }
            return FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Annulla'),
            );
          },
        ),
        BlocBuilder<ShareBloc, ShareState>(
          builder: (context, state) {
            if (state is ShareInitial) {
              return FlatButton(
                onPressed: _emailController.text.isNotEmpty &&
                        _emailController.text !=
                            Provider.of<CurrentUser>(context).data.email
                    ? () {
                        BlocProvider.of<ShareBloc>(context).add(
                            ShareMemo(_emailController.text, widget.memoId));
                      }
                    : null,
                child: Text('Aggiungi'),
              );
            } else if (state is ShareFailure ||
                state is ShareUserNotFound ||
                state is ShareMemoAlreadyShared) {
              return FlatButton(
                onPressed: () {
                  BlocProvider.of<ShareBloc>(context).add(ResetShare());
                  _emailController.clear();
                },
                child: Text('Riprova'),
              );
            }

            return Container();
          },
        ),
      ],
    );
  }
}
