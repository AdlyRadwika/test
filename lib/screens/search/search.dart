import 'package:flutter/material.dart';
import 'package:practical_test/providers/university/university.dart';
import 'package:practical_test/screens/widgets/university_item_widget.dart';
import 'package:practical_test/utils/provider_enum.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
final _searchController = TextEditingController();

@override
  void initState() {
    
    super.initState();
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
              return ListView.builder(
                itemCount: provider.universitySearch.length,
                itemBuilder: (context, index) {
                  final data = provider.universitySearch[index];
                  return UniversityItem(data: data);
                },
              );
            }
            else {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'The university you are trying to look for is not found, try search by the correct name.',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
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