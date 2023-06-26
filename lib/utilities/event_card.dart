import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';

class EventCard extends StatelessWidget {

  const EventCard({super.key, required this.eventName, required this.eventDetail, required this.eventDate, required this.photoName});
  final String? eventName;
  final String? eventDetail;
  final String? eventDate;
  final String photoName;
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: GestureDetector(
        onTap: () {
        },
        child: Column(children: [
          Stack(
            children: [
              Column(
                children: [
                  Ink.image(
                    image: NetworkImage(photoName),
                    height: 180,
                    fit: BoxFit.scaleDown,
                  ),
                  SizedBox(height: deviceHeight / 100),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10)
                        .copyWith(bottom: 8),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('NAME: ${eventName}',
                            style: kCardTitleStyle),
                        Text('DETAILS: ${eventDetail}',
                            style: kCardTitleStyle),
                        Text('DATE: ${eventDate}',
                            style: kCardTitleStyle),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
