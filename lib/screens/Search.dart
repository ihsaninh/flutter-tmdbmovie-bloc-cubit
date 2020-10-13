import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/blocs/SearchMovieCubit.dart';
import 'package:movie_app/configs/Config.dart';
import 'package:movie_app/utils/Debouncer.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController _textFieldController = TextEditingController();
  Debouncer _debouncer = Debouncer(milliseconds: 500);

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  void _getSearchMovies(String query) {
    _debouncer.run(() => context.bloc<SearchMovieCubit>().getSearchMovies(query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: _buildSearchField(),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => _textFieldController.clear(),
          ),
        ],
      ),
      body: BlocBuilder<SearchMovieCubit, SearchMovieState>(
        builder: (context, state) {
          if (state is SearchMovieLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SearchMovieLoadSuccess) {
            return ListView.builder(
              itemCount: state.searchMovieResult.length,
              itemBuilder: (context, index) {
                var data = state.searchMovieResult[index];
                return ListTile(
                  onTap: () {},
                  leading: Container(
                    height: 200,
                    child: Image.network(
                      '${Config.baseImageUrl}${data.posterPath}',
                    ),
                  ),
                  title: Text(
                    data.title,
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  subtitle: Text(
                    data.releaseDate,
                    style: TextStyle(
                      color: Colors.white70
                    ),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      )
    );
  }

  _buildSearchField() {
    return TextField(
      autofocus: true,
      controller: _textFieldController,
      onChanged: (text) => _getSearchMovies(text),
      decoration: InputDecoration(
        hintText: "Search",
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold
        ),
      ),
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0
      ),
    );
  }
}