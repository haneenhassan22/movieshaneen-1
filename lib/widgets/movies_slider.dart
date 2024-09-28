import 'package:flutflix/api/api.dart';
import 'package:flutflix/constants.dart';
import 'package:flutflix/nav_bar_package.dart/functions.dart';
import 'package:flutflix/nav_bar_package.dart/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/details_screen.dart';

class MoviesSlider extends StatefulWidget {
  const MoviesSlider({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;

  @override
  State<MoviesSlider> createState() => _MoviesSliderState();
}

class _MoviesSliderState extends State<MoviesSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.snapshot.data!.length,
        itemBuilder: (context, index) {
          return widget.snapshot.data![index].posterPath == 'hello'
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                        screen: DetailsScreen(
                          movie: widget.snapshot.data[index],
                        ),
                        withNavBar: false,
                      );
                    },
                    child: Stack(
                      children: [
                        // Movie Poster Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            "${Constants.imagePath}${widget.snapshot.data![index].posterPath}",
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
                                widget.snapshot.data![index].isAdedd =
                                    !widget.snapshot.data![index].isAdedd;
                              });
                              widget.snapshot.data![index].isAdedd == true
                                  ? Api.watchList
                                      .add(widget.snapshot.data![index])
                                  : Api.watchList.removeAt(Api.watchList
                                      .indexOf(widget.snapshot.data![index]));
                            },
                            child: SvgPicture.asset(
                                widget.snapshot.data![index].isAdedd
                                    ? "assets/bookmark_on.svg"
                                    : "assets/bookmark_off.svg"),
                          ),
                        )
                      ],
                    ) /*ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 200,
                  width: 150,
                  child: Image.network(
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    '${Constants.imagePath}${snapshot.data![index].posterPath}',
                  ),
                ),
              )*/
                    ,
                  ),
                );
        },
      ),
    );
  }
}
