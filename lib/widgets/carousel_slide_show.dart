import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/champion_info_model.dart';
import '../models/skin_model.dart';

class CarouselSlideShow extends StatelessWidget {
  const CarouselSlideShow({
    super.key,
    required this.controller,
    required this.onPageChanged,
    required this.championInfoModel,
    required this.currentIndex,
    required this.toggleOnPressed,
  });

  final CarouselController controller;
  final void Function(int index, CarouselPageChangedReason reason) onPageChanged;
  final ChampionInfoModel championInfoModel;
  final int currentIndex;
  final void Function(int index) toggleOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Skins',
            style: TextStyle(fontSize: 32),
          ),
          const Divider(
            color: Colors.black38,
            thickness: 1.5,
          ),
          const SizedBox(
            height: 20,
          ),
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 1215 / 717,
              height: 400,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged: onPageChanged,
            ),
            carouselController: controller,
            items: championInfoModel.skins.map((SkinModel skin) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Opacity(
                      opacity: skin.acquired ? 1 : 0.8,
                      child: Image.asset(
                        'assets/skins/${championInfoModel.name}_${skin.personalId}.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(skin.name),
                  if (!skin.acquired && championInfoModel.acquired)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: FilledButton.tonal(
                        onPressed: () {
                          toggleOnPressed(championInfoModel.skins.indexOf(skin));
                        },
                        child: Text(
                          '${skin.price} RP',
                        ),
                      ),
                    )
                ],
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  controller.previousPage(duration: const Duration(milliseconds: 50), curve: Curves.linear);
                },
                child: const Text('prev'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: championInfoModel.skins.map((SkinModel skin) {
                  return GestureDetector(
                    onTap: () {
                      controller.animateToPage(
                        championInfoModel.skins.indexOf(skin),
                        duration: Duration(
                          milliseconds: min(
                                min(
                                  (currentIndex - championInfoModel.skins.indexOf(skin)).abs(),
                                  (-championInfoModel.skins.indexOf(skin) +
                                          currentIndex +
                                          championInfoModel.skins.length)
                                      .abs(),
                                ),
                                (championInfoModel.skins.indexOf(skin) - currentIndex + championInfoModel.skins.length)
                                    .abs(),
                              ) *
                              50,
                        ),
                        curve: Curves.linear,
                      );
                    },
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                            .withOpacity(currentIndex == championInfoModel.skins.indexOf(skin) ? 0.9 : 0.4),
                      ),
                    ),
                  );
                }).toList(),
              ),
              TextButton(
                onPressed: () {
                  controller.nextPage(duration: const Duration(milliseconds: 50), curve: Curves.linear);
                },
                child: const Text('next'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
