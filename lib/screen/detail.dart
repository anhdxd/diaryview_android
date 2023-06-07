import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final String? item;
  var detail;

  Detail({super.key, this.item, this.detail});

  @override
  Widget build(BuildContext context) {
    const double height = 5;
    int timeUsedInSeconds = int.parse(detail["TimeUsed"]);
    int minutes = (timeUsedInSeconds / 60).floor();
    String timeUsedFormatted = '$minutes phút';
    return Scaffold(
      appBar: AppBar(
        title: Text(item ?? 'Content'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 66, 191, 216),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.web_rounded, size: 256, color: Colors.blue),
              Text(
                'Web/app: $item',
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: height),
              Text(
                'Ngày bắt đầu: ${detail["DayUse"]}',
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: height),
              Text(
                'Thời gian bắt đầu: ${detail["TimeStart"]}',
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: height),
              Text(
                'Thời gian sử dụng: $timeUsedFormatted',
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
