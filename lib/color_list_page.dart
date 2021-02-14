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
// if "with TickerProviderStateMixin" uncommented, navigator push unexpectedly triggers BlocBuilder to return purple Container by the way
// with TickerProviderStateMixin 
{
  List<int> colorsList;

  @override
  void initState() {
    BlocProvider.of<ColorsBloc>(context)..add(InitialLoadColors());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        backgroundColor: widget.color,
      ),
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
            return _buildLoading();
          } else if (state is ColorsLoadedState) {
            if (colorsList != state.loadedColors) {
              colorsList = state.loadedColors;
              return _buildList();
            }
          }
          // returning this is not good :)
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

  Widget _buildList() {
    return Container(
      color: Colors.white,
      child: ListView.builder(
          itemCount: colorsList.length,
          itemBuilder: (BuildContext content, int index) {
            int materialIndex = colorsList[index];
            return Container(
              color: widget.color[materialIndex],
              child: ListTile(
                title: Text('$materialIndex', style: TextStyle(fontSize: 24.0)),
                trailing: Icon(Icons.chevron_right),
                onTap: () => widget.onPush(materialIndex),
                // BlocProvider.of<ColorsBloc>(context)
                //     .add(NavigateDetailColor(materialIndex)),
              ),
            );
          }),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.grey,
      ),
    );
  }
}
