import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:transit_tracer/core/constants/assets_path.dart';
import 'package:transit_tracer/core/widgets/base_container.dart';

@RoutePage()
class TransportResultsScreen extends StatelessWidget {
  const TransportResultsScreen({
    super.key,
    required this.frome,
    required this.to,
    required this.date,
  });

  final String frome;
  final String to;
  final String date;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              '$frome → $to',
              maxFontSize: 22,
              maxLines: 1,
              minFontSize: 16,
            ),
            Text(date, style: theme.textTheme.bodyMedium),
            SizedBox(height: 8),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    //TODO
                  },
                  icon: const Icon(Icons.filter_alt),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog();
                      },
                    );
                  },
                  icon: const Icon(Icons.sort),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
                  child: BaseContainer(
                    theme: theme,
                    child: Row(
                      children: [
                        Image.asset(
                          AssetsPath.transitTracerLogo,
                          width: 80,
                          height: 80,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Text('Frome → To'),
                              Text('Date · Car'),
                              Text('Load capacity: 1500kg'),
                              Text('Driver : Name'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Prise:'),

                                  ElevatedButton(
                                    style: ButtonStyle(),
                                    onPressed: () {
                                      //TODO
                                    },
                                    child: Text('More'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
