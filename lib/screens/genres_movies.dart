import 'dart:developer';

import 'package:flutflix/api/api.dart';
import 'package:flutflix/constants.dart';
import 'package:flutflix/models/movie.dart';
import 'package:flutflix/nav_bar_package.dart/functions.dart';
import 'package:flutflix/nav_bar_package.dart/model.dart';
import 'package:flutflix/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class GenreMovies extends StatefulWidget {
  GenreMovies({super.key, required this.genredId, required this.genreName});

  int genredId;
  String genreName;

  @override
  State<GenreMovies> createState() => _GenreMoviesState();
}

class _GenreMoviesState extends State<GenreMovies> {
  late Future<List<Movie>> filteredMovies;

  @override
  void initState() {
    // TODO: implement initState
    filteredMovies = Api().getFilteredMovies(widget.genredId);
    print("filtered $filteredMovies , ${widget.genredId}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.genreName,
                  style: GoogleFonts.aBeeZee(
                    fontSize: 25,
                  ),
                ),
                FutureBuilder(
                  future: filteredMovies,
                  builder: (context, snapshot) {
                    print(snapshot.hasData);
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return snapshot.data!.isEmpty
                          ? Padding(
                              padding: EdgeInsets.only(top: 150),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.genreName,
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: 25,
                                      ),
                                    ),
                                    SvgPicture.asset("assets/no_movies.svg"),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "No Movies Found",
                                      style: GoogleFonts.openSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 15),
                                      child: GestureDetector(
                                        onTap: () {
                                          PersistentNavBarNavigator
                                              .pushNewScreen(
                                            context,
                                            pageTransitionAnimation:
                                                PageTransitionAnimation.fade,
                                            screen: DetailsScreen(
                                              movie: snapshot.data![index],
                                            ),
                                            withNavBar: false,
                                          );
                                        },
                                        child: Container(
                                          color: Colors.black,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: snapshot.data![index]
                                                            .posterPath ==
                                                        'hello'
                                                    ? Container(
                                                        color: Colors.grey,
                                                        width: 120,
                                                        height: 100,
                                                      )
                                                    : Image.network(
                                                        "${Constants.imagePath}${snapshot.data![index].posterPath}",
                                                        width: 120,
                                                        height: 100,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      snapshot
                                                          .data![index].title!,
                                                      style:
                                                          GoogleFonts.openSans(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Text(
                                                      snapshot.data![index]
                                                          .releaseDate!,
                                                      style:
                                                          GoogleFonts.openSans(
                                                        fontSize: 10,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
