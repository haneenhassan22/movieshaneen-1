import 'package:flutflix/api/api.dart';
import 'package:flutflix/nav_bar_package.dart/functions.dart';
import 'package:flutflix/nav_bar_package.dart/model.dart';
import 'package:flutflix/screens/genres_movies.dart';
import 'package:flutflix/widgets/categories_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Future<List<dynamic>> genres;

  @override
  void initState() {
    // TODO: implement initState
    genres = Api().fetchGenres();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Browse Category ',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: genres,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          int itemsPerRow = 2;
                          int baseIndex = index * itemsPerRow;

                          return Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(itemsPerRow, (i) {
                                int currentIndex = baseIndex + i;

                                if (currentIndex < snapshot.data!.length) {
                                  /* var service =
                                        controller.needApprovalRequestedServices[
                                            currentIndex];*/
                                  return Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: i < itemsPerRow - 1 ? 15 : 0,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          PersistentNavBarNavigator
                                              .pushNewScreen(
                                            context,
                                            pageTransitionAnimation:
                                                PageTransitionAnimation.fade,
                                            screen: GenreMovies(
                                              genredId: snapshot
                                                  .data![currentIndex]['id'],
                                              genreName: snapshot
                                                  .data![currentIndex]['name'],
                                            ),
                                            withNavBar: false,
                                          );
                                        },
                                        child: CategoriesCard(
                                          title: snapshot.data![currentIndex]
                                              ['name'],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const Expanded(child: SizedBox());
                                }
                              }),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
