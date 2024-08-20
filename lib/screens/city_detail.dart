import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_stable/utilities/app_colors.dart';
import 'package:weather_stable/utilities/gradient.dart';
import 'package:weather_stable/utilities/weather_provider.dart';
import 'package:weather_stable/widgets/list_items.dart';
import 'package:weather_stable/widgets/status.dart';

class CityDetail extends StatefulWidget {
  const CityDetail({
    super.key,
    required this.requestUrl,
    required this.cityName,
    required this.celsius,
  });
  final String requestUrl;
  final String cityName;
  final String celsius;

  @override
  State<CityDetail> createState() => _CityDetailState();
}

class _CityDetailState extends State<CityDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String baseUrl = widget.requestUrl.startsWith('//')
        ? "https:${widget.requestUrl}"
        : widget.requestUrl;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: gradient(),
        child: FutureBuilder<void>(
          future:
              Provider.of<WeatherProvider>(context, listen: false).fetchWeather(
            baseUrl,
            '.cities',
            '.city-block',
            countryWeather: true,
            detailed: true,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.red[400]),
                ),
              );
            } else {
              final detail = Provider.of<WeatherProvider>(context).detailed;
              return SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Image.asset(
                            'assets/images/zoom.png',
                            width: 30,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.cityName,
                                style: const TextStyle(
                                  fontSize: 37,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.main,
                                ),
                              ),
                              Text(
                                detail[0].dates?[0].text,
                                style: const TextStyle(
                                  color: AppColors.lightGray,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          "assets/images/main.png",
                          width: MediaQuery.sizeOf(context).width / 2,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 3,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                widget.celsius,
                                style: const TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.main,
                                ),
                              ),
                              const Text(
                                "Rainy",
                                style: TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.main,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ListItems(
                      onClick: () {},
                      src: "assets/images/umbrella.png",
                      width: 50,
                      text: "RainFall",
                      celsius: detail[0].rainFall.toString(),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListItems(
                      onClick: () {},
                      src: "assets/images/wind.png",
                      width: 50,
                      text: "Wind",
                      celsius: "${detail[0].wind}km/h",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListItems(
                      onClick: () {},
                      src: "assets/images/humidity.png",
                      width: 50,
                      text: "Humidity",
                      celsius: detail[0].humidity.toString(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    PreferredSize(
                      preferredSize: const Size.fromHeight(50),
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: Colors.transparent,
                        labelColor: Colors.black,
                        unselectedLabelColor: const Color(0xFFD6996B),
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        unselectedLabelStyle: const TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                        tabs: const [
                          Tab(text: 'Today'),
                          Tab(text: 'Tomorrow'),
                          Tab(text: 'Next 7 Days'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Status(
                            width: 24,
                            active: false,
                            celsius: '15',
                            time: "10:00",
                          ),
                          Status(
                            width: 24,
                            active: false,
                            celsius: '15',
                            time: "11:00",
                          ),
                          Status(
                            width: 24,
                            active: true,
                            celsius: '19',
                          ),
                          Status(
                            width: 24,
                            active: false,
                            celsius: '15',
                            time: "12:00",
                          ),
                          Status(
                            width: 24,
                            active: false,
                            celsius: '15',
                            time: "12:00",
                          ),
                          Status(
                            width: 24,
                            active: false,
                            celsius: '15',
                            time: "12:00",
                          ),
                        ],
                      ),
                    )
                  ],
                )),
              );
            }
          },
        ),
      ),
    );
  }
}
