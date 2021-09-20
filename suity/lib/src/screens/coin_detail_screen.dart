import 'dart:math';

import 'package:suity/src/models/models.dart';
import 'package:suity/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:suity/src/models/fetchCoins_models/fetch_coins_models.dart';
import 'package:intl/intl.dart';

class CoinDetailScreen extends StatefulWidget {
  final DataModel coin;
  const CoinDetailScreen({
    Key? key,
    required this.coin,
  }) : super(key: key);

  @override
  State<CoinDetailScreen> createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends State<CoinDetailScreen> {
  List<bool> _isSelected = [true, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int next(int min, int max) => random.nextInt(max - min);
    var coinIconUrl =
        "https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/";
    var coinPrice = widget.coin.quoteModel.usdModel;
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .parse(coinPrice.lastUpdated);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    var data = [
      ChartData(next(110, 140), 1),
      ChartData(next(9, 41), 2),
      ChartData(next(140, 200), 3),
      ChartData(coinPrice.percentChange_24h, 4),
      ChartData(coinPrice.percentChange_1h, 5),
      ChartData(next(110, 140), 6),
      ChartData(next(9, 41), 7),
      ChartData(next(140, 200), 8),
      ChartData(coinPrice.percentChange_24h, 9),
      ChartData(coinPrice.percentChange_1h, 10),
      ChartData(next(110, 140), 12),
      ChartData(next(9, 41), 13),
      ChartData(coinPrice.percentChange_1h, 14),
      ChartData(next(9, 41), 15),
      ChartData(next(140, 200), 16),
      ChartData(coinPrice.percentChange_24h, 17),
      ChartData(coinPrice.percentChange_1h, 18),
      ChartData(next(110, 140), 19),
      ChartData(next(9, 41), 20),
      ChartData(next(140, 200), 21),
      ChartData(coinPrice.percentChange_24h, 22),
      ChartData(next(110, 140), 23),
    ];

    return Scaffold(
      backgroundColor: Color.fromRGBO(11, 12, 54, 1),
      body: CustomScrollView(
        slivers: [
          CoinDetailAppBar(coin: widget.coin, coinIconUrl: coinIconUrl),
          /*CoinRandomedChartWidget(
              coinPrice: coinPrice,
              outputDate: outputDate,
              data: data),*/
          // CoinRandomedChartWidget ne fonctionne pas dans son état actuel
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverAppBarDelegate(
              minHeight: 360.0,
              maxHeight: 360.0,
              child: Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Column(
                  children: [
                    Text(
                      '\$' + coinPrice.price.toStringAsFixed(2),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      outputDate,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    CoinChartWidget(
                        coinPrice: coinPrice, color: Colors.green, data: data),
                    ToggleButtons(
                      borderRadius: BorderRadius.circular(8.0),
                      borderColor: Colors.indigoAccent,
                      color: Colors.white,
                      fillColor: Colors.green,
                      selectedColor: Colors.white,
                      selectedBorderColor: Colors.indigoAccent,
                      children: [
                        ToggleButtonWidget(name: "Today"),
                        ToggleButtonWidget(name: "1W"),
                        ToggleButtonWidget(name: "1M"),
                        ToggleButtonWidget(name: "3M"),
                        ToggleButtonWidget(name: "6M"),
                      ],
                      isSelected: _isSelected,
                      onPressed: (int newIndex) {
                        setState(() {
                          for (int i = 0; i < _isSelected.length; i++) {
                            if (i == newIndex) {
                              _isSelected[i] = true;
                            } else {
                              _isSelected[i] = false;
                            }
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 8.0)
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    height: 400.0,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Circulating Supply: ",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              widget.coin.circulatingSupply.toString(),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Max Supply: ",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              widget.coin.maxSupply.toString(),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Market pairs: ",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              widget.coin.numMarketPairs.toString(),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Market Cap: ",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              widget.coin.quoteModel.usdModel.marketCap
                                  .toStringAsFixed(2),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
