import 'package:flutter/material.dart';
import 'package:practical_test/data/model/university/university.dart';
import 'package:practical_test/providers/university/university.dart';
import 'package:practical_test/screens/widgets/university_item_widget.dart';
import 'package:practical_test/utils/provider_enum.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const _pageSize = 10;

final _pagingController = PagingController<int, UniversityModel>(
  firstPageKey: 1,
);

final _searchController = TextEditingController();

@override
void initState() {
  _pagingController.addPageRequestListener((pageKey) {
    _fetchPage(pageKey);
  });

  super.initState();
}

@override
void dispose() {
  _pagingController.dispose();

  super.dispose();
}

Future<void> _fetchPage(int pageKey) async {
    try {
      print('fetchjing search');
      final List<UniversityModel> newItems = await context.read<SearchUniversityProvider>().searchUniversityList(
        query: _searchController.text,
        pageKey: pageKey
      );
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
      print('last page');
        _pagingController.appendLastPage(newItems);
      } else {
      print('append');
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      debugPrint('error!');
      _pagingController.error = error;
    }
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: SearchFieldWidget(searchController: _searchController),
        ),
        body: Consumer<SearchUniversityProvider>(
          builder: (context, provider, _) {
            if(provider.searchState == ProviderState.loading) {
              return const Center(child: CircularProgressIndicator(),);
            } else if (provider.searchState == ProviderState.error) {
              return Center(child: Text(provider.message),);
            } else if (provider.searchState == ProviderState.loaded) {
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

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchUniversityProvider>(
      builder: (context, state, _) {
        return TextField(
          controller: searchController,
          autofocus: true,
          onChanged: (value) {
            context.read<SearchUniversityProvider>().searchUniversityList(query: value, pageKey: 0); 
          },
          maxLines: 1,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            suffixIcon: IconButton(
              onPressed: searchController.clear,
              icon: const Icon(
                Icons.clear,
                color: Colors.white,
              ),
              tooltip: 'Clear',
            ),
          ),
          style: const TextStyle(
            color: Colors.white,
          ),
        );
      },
    );
  }
}