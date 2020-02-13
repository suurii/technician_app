import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lap_app/bloc/bloc.dart';
import 'package:lap_app/data/entities/entities.dart';
import 'package:lap_app/ui/pages/pages.dart';
import 'package:lap_app/ui/widget/widgets.dart';
import 'package:rounded_floating_app_bar/rounded_floating_app_bar.dart';
import 'package:meta/meta.dart';

class SearchResultPage extends StatelessWidget {
  final TokenCredential tokenCredential;
  final String searchString;
  final List<dynamic> jobs;
  SearchResultPage(
      {Key key,
      @required this.tokenCredential,
      @required this.searchString,
      @required this.jobs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchResultBloc(),
      child: SearchResultPageChild(jobs: jobs,searchString: searchString,),
    );
  }
}

class SearchResultPageChild extends StatefulWidget{
  final TokenCredential tokenCredential;
  final String searchString;
  final List<dynamic> jobs;

  const SearchResultPageChild({Key key, this.tokenCredential, this.searchString, this.jobs}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchResultPageChildState(tokenCredential: tokenCredential,searchString: searchString,jobs: jobs);
  }

}
class _SearchResultPageChildState extends State<SearchResultPageChild> {
  final TokenCredential tokenCredential;
  final String searchString;
  final List<dynamic> jobs;
  _SearchResultPageChildState(
      {Key key, this.tokenCredential, this.searchString, this.jobs});
  final txtController = TextEditingController();

  @override
  void initState(){
    txtController.text = this.searchString;
  }

  @override
  void dispose(){
    if(txtController != null){
      txtController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: BlocListener<SearchResultBloc, SearchResultState>(
              listener: (BuildContext context, state) {
                if (state is SearchResultErrorState) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(state.message),
                    backgroundColor: state.color,
                  ));
                } else if (state is SearchResultBackPageState) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<SearchResultBloc>(context),
                        child: HomePage(
                          tokenCredential: tokenCredential,
                        )),
                  ));
                }
              },
              child: buildBody(context),
            )),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, isInnerBoxScroll) {
        return [
          RoundedFloatingAppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.clear,
                  size: 30,
                ),
                onPressed: () {
                  txtController.text = '';
                },
              ),
            ],
            floating: true,
            snap: true,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.keyboard_backspace,
                      size: 30,
                    ),
                    onPressed: () {
                      final searchResultBloc =
                          BlocProvider.of<SearchResultBloc>(context);
                      searchResultBloc.add(SearchResultBackPageEvent());
                    }),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'ค้นหางานใหม่รอดำเนินการ',
                      border: InputBorder.none,
                    ),
                    onFieldSubmitted: (_) =>
                        _onSubmitted(context, txtController.text),
                    controller: txtController,
                    textInputAction: TextInputAction.search,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
          ),
        ];
      },
      body: BlocBuilder(
        bloc: BlocProvider.of<SearchResultBloc>(context),
        builder: (BuildContext context, state) {
          if (state is SearchResultInitial) {
            return ListView.builder(
                itemCount: jobs.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildItem(jobs, index);
                });
          } else if (state is SearchResultRebuildState) {
            return ListView.builder(
                itemCount: state.jobs.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildItem(state.jobs, index);
                });
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: <Widget>[
                    LoadingWidget(width: 100, height: 100),
                  ],
                )
              ],
            );
            
          }
        },
      ),
    );
  }

  _onSubmitted(BuildContext context, String searchString) {
    if (searchString.length != 0) {
      txtController.text = '';
      final searchResultBloc = BlocProvider.of<SearchResultBloc>(context);
      if (searchString.length > 3) { 
        print(searchString);
        searchResultBloc.add(SearchResultSearchEvent(searchString: searchString));
       
      } else {
        searchResultBloc.add(SearchResultErrorEvent(
          message: 'String search length must longer than 3!',
          color: Colors.red,
        ));
      }
    }
  }

  Widget buildItem(List<dynamic> jobs, int index) {
    return Column(
      children: <Widget>[
        Text('Network Configuration'),
        Text('โครงการ : '+jobs[index]['customerName']),
        Text('Project : '+jobs[index]['projectNameEn']),
        Text('Site Code : '+jobs[index]['siteCode']),
      ],
    );
  }
}