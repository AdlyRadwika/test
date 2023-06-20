import 'package:flutter/material.dart';
import 'package:practical_test/data/model/university/university.dart';
import 'package:practical_test/screens/route.dart' as route;
import 'package:practical_test/providers/university/university.dart';
import 'package:practical_test/screens/widgets/university_item_widget.dart';
import 'package:practical_test/utils/provider_enum.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _pageSize = 10;

final _pagingController = PagingController<int, UniversityModel>(
  firstPageKey: 1,
);

@override
void initState() {
  _pagingController.addPageRequestListener((pageKey) {
    _fetchPage(pageKey);
  });

  super.initState();
}

Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await context.read<UniversityProvider>().fetchMoreUniversityList(pageKey: pageKey);
      final isLastPage = newItems!.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      debugPrint('error!');
      _pagingController.error = error;
    }
}

@override
void dispose() {
  _pagingController.dispose();

  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, route.searchScreen),
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: Consumer<UniversityProvider>(
          builder: (context, provider, _) {
            if(provider.state == ProviderState.loading) {
              return const Center(child: CircularProgressIndicator(),);
            } else if (provider.state == ProviderState.error) {
              return Center(child: Text(provider.message),);
            } else if (provider.state == ProviderState.loaded) {
              return PagedListView<int, UniversityModel>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<UniversityModel>(
                  itemBuilder: (context, item, index) {
                      return UniversityItem(data: item);
                    }
                  )
                );
            }
            else {
              return const Center(child: Text('Something wrong!'),);
            }
          }
        ),
      ),
    );
  }
}