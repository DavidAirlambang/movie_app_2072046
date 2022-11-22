import 'package:flutter/material.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 5, 16, 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Now Playing Movies",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFf4C10F)),
              ),
              Icon(
                Icons.chevron_right,
                color: Color(0xFFf4C10F),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          height: 160,
          width: double.infinity,
          child: ListView(
            padding: const EdgeInsets.only(top: 5, right: 8),
            scrollDirection: Axis.horizontal,
            children: [
              containerSementara(),
              containerSementara(),
              containerSementara(),
              containerSementara()
            ],
          ),
        )
      ]),
    );
  }
}

Widget containerSementara() {
  return InkWell(
    onTap: () {},
    child: Container(
      margin: const EdgeInsets.only(right: 10),
      width: 110,
      decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(5))),
    ),
  );
}
