import 'package:flutflix/api/api.dart';
import 'package:flutflix/colors.dart';
import 'package:flutflix/constants.dart';
import 'package:flutflix/models/movie.dart';
import 'package:flutflix/widgets/back_button.dart';
import 'package:flutflix/widgets/movies_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Future<Map<String, dynamic>?> movieDetails;
  late Future<List<Movie>> similarMovies;

  @override
  void initState() {
    // TODO: implement initState
    movieDetails = Api().fetchMovieDetails(widget.movie.id);
    similarMovies = Api().fetchSimilarMovies(widget.movie.id);
    print(widget.movie.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.movie.originalTitle!,
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Image.network(
                    "${Constants.imagePath}${widget.movie.posterPath}",
                    // Replace with actual image URL
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 150,
                    left: MediaQuery.of(context).size.width / 2 - 30,
                    child: Icon(
                      Icons.play_circle_fill,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.movie.title!,
                      style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.movie.releaseDate!,
                      style: GoogleFonts.openSans(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            // Movie Poster Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                "${Constants.imagePath}${widget.movie.posterPath}",
                                width: 100,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),

                            // Overlay with "+" button
                            Positioned(
                              top: 0,
                              left: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.movie.isAdedd =
                                        !widget.movie.isAdedd!;
                                  });
                                },
                                child: SvgPicture.asset(widget.movie.isAdedd!
                                    ? "assets/bookmark_on.svg"
                                    : "assets/bookmark_off.svg"),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder(
                                  future: movieDetails,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text(snapshot.error.toString()),
                                      );
                                    } else if (snapshot.hasData) {
                                      return SizedBox(
                                        width: 220,
                                        height: 30,
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,

                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              snapshot.data!['genres'].length,
                                          // Number of rows
                                          itemBuilder: (context, index) =>
                                              Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                    color: Colors.white
                                                        .withOpacity(0.1)),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: Text(
                                                    snapshot.data!['genres']
                                                        [index]['name'],
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                widget.movie.overview!,
                                style: GoogleFonts.roboto(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                                // textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset('assets/star.svg'),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${widget.movie.voteAverage}",
                                    style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    // textAlign: TextAlign.justify,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      color: Color(0xFF282A28),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              'More Like This',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 15),
                            FutureBuilder(
                              future: similarMovies,
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text(snapshot.error.toString()),
                                  );
                                } else if (snapshot.hasData) {
                                  return MoviesSlider(
                                    snapshot: snapshot,
                                  );
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
