import 'package:flutter/material.dart';

import 'constants.dart';

class EventCard extends StatefulWidget {
  const EventCard({super.key});


  @override
  State<EventCard> createState() => _EventCard();
}

class _EventCard extends State<EventCard> with TickerProviderStateMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                    image: const AssetImage('Assets/stockImage.jpeg'),
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: deviceHeight / 100),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10)
                        .copyWith(bottom: 8),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('THIS IS AN EVENT CARD',
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
