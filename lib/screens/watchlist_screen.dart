import 'package:flutflix/api/api.dart';
import 'package:flutflix/constants.dart';
import 'package:flutflix/nav_bar_package.dart/functions.dart';
import 'package:flutflix/nav_bar_package.dart/model.dart';
import 'package:flutflix/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
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
                  "Watchlist",
                  style: GoogleFonts.aBeeZee(
                    fontSize: 25,
                  ),
                ),
                Api.watchList.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 150),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                            itemCount: Api.watchList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: GestureDetector(
                                  onTap: () {
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.fade,
                                      screen: DetailsScreen(
                                        movie: Api.watchList[index],
                                      ),
                                      withNavBar: false,
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.black,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Api.watchList[index]
                                                        .posterPath ==
                                                    'hello'
                                                ? Container(
                                                    color: Colors.grey,
                                                    width: 120,
                                                    height: 100,
                                                  )
                                                : Image.network(
                                                    "${Constants.imagePath}${Api.watchList[index].posterPath}",
                                                    width: 120,
                                                    height: 80,
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
                                                  Api.watchList[index].title!,
                                                  style: GoogleFonts.openSans(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                Text(
                                                  Api.watchList[index]
                                                      .releaseDate!,
                                                  style: GoogleFonts.openSans(
                                                    fontSize: 10,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        'assets/star.svg'),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      Api.watchList[index]
                                                          .voteAverage!
                                                          .toString(),
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
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
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
