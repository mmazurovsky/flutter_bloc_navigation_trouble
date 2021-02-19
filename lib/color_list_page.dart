import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bug_in_bloc_project/bloc/bloc/colors_bloc.dart';

class ColorsListPage extends StatefulWidget {
  ColorsListPage({this.color, this.title, this.onPush});
  final MaterialColor color;
  final String title;
  final ValueChanged<int> onPush;

  @override
  State<StatefulWidget> createState() => _ColorsListPageState();
}

class _ColorsListPageState extends State<ColorsListPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ColorsBloc>(context)..add(InitialLoadColors());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), backgroundColor: widget.color),
      body: BlocConsumer<ColorsBloc, ColorsState>(
        listener: (context, state) {
          if (state is ColorsLoadingState) {
            print('loading ' + DateTime.now().toString());
          } else if (state is ColorsLoadedState) {
            print('loaded ' + DateTime.now().toString());
          } else {
            print('some unknown state');
          }
        },
        builder: (context, state) {
          if (state is ColorsLoadingState) {
            return _Loading();
          } else if (state is ColorsLoadedState) {
            return _ListView(
              colorsList: state.loadedColors,
              color: widget.color,
              onPush: widget.onPush,
            );
          }
          // Purple Container which is unexpectedly returned on navigator push
          return Container(
            color: Colors.purple,
            child: Center(
              child: Text('Lost ColorsLoadedState'),
            ),
          );
        },
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.grey,
      ),
    );
  }
}

class _ListView extends StatelessWidget {
  const _ListView({
    Key key,
    @required this.colorsList,
    @required this.color,
    @required this.onPush,
  }) : super(key: key);

  final List<int> colorsList;
  final MaterialColor color;
  final void Function(int) onPush;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
          itemCount: colorsList.length,
          itemBuilder: (BuildContext content, int index) {
            int materialIndex = colorsList[index];
            return Container(
              color: color[materialIndex],
              child: ListTile(
                title: Text('$materialIndex', style: TextStyle(fontSize: 24.0)),
                trailing: Icon(Icons.chevron_right),
                onTap: () => onPush(materialIndex),
              ),
            );
          }),
    );
  }
}
