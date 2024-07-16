import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_model_cubit.dart';
import 'package:news_app/pages/news_detail_page.dart';
import 'package:news_app/services/auth/auth_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? title;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsModelCubit>(context).getNews('health');
  }

  void getTopicNews(String topics) {
    BlocProvider.of<NewsModelCubit>(context).getNews(topics);
  }

  void signOut() async {
    final authServices = AuthServices();
    await authServices.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsModelCubit, NewsModelState>(
      builder: (context, state) {
        if (state is NewsModelInitial) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is NewsModelLoaded) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.logout),
                onPressed: signOut,
              ),
              centerTitle: true,
              title: Text('Top Headlines for ${title ?? 'Health'}'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        tabBar(
                          tabtext: 'Health',
                          onPressed: () {
                            setState(() {
                              title = 'Health';
                            });
                            getTopicNews('health');
                          },
                        ),
                        tabBar(
                          tabtext: 'Business',
                          onPressed: () {
                            setState(() {
                              title = 'Business';
                            });
                            getTopicNews('business');
                          },
                        ),
                        tabBar(
                          tabtext: 'Entertainment',
                          onPressed: () {
                            setState(() {
                              title = 'Entertainment';
                            });
                            getTopicNews('entertainment');
                          },
                        ),
                        tabBar(
                          tabtext: 'General',
                          onPressed: () {
                            setState(() {
                              title = 'General';
                            });
                            getTopicNews('general');
                          },
                        ),
                        tabBar(
                          tabtext: 'Science',
                          onPressed: () {
                            setState(() {
                              title = 'Science';
                            });
                            getTopicNews('science');
                          },
                        ),
                        tabBar(
                          tabtext: 'Sports',
                          onPressed: () {
                            setState(() {
                              title = 'Sports';
                            });
                            getTopicNews('sports');
                          },
                        ),
                        tabBar(
                          tabtext: 'Technology',
                          onPressed: () {
                            setState(() {
                              title = 'Technology';
                            });
                            getTopicNews('technology');
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.newsModel.articles.length,
                      itemBuilder: (context, index) {
                        var article = state.newsModel.articles[index];
                        return Column(
                          children: [
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NewsDetailPage(news: article),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: CachedNetworkImage(
                                  imageUrl: article.urlToImage ?? '',
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/news.png',
                                    width: 160,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                state.newsModel.articles[index].title ??
                                    'No Data Found',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is NewsModelError) {
          return Scaffold(
            body: Center(child: Text(state.newsError)),
          );
        }
        return Center(
            child: Text(
          state.toString(),
        ));
      },
    );
  }
}

class tabBar extends StatelessWidget {
  final String tabtext;
  final VoidCallback onPressed;

  const tabBar({
    super.key,
    required this.tabtext,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8, bottom: 5),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(tabtext),
      ),
    );
  }
}
