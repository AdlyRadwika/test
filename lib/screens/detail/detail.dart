import 'package:flutter/material.dart';
import 'package:practical_test/data/model/university/university.dart';
import 'package:practical_test/providers/university/university.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {

  const DetailScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen',),
      ),
      body: Consumer<UniversityProvider>(
        builder: (context, provider, _) {
          final UniversityModel data = provider.detail;
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Name: ${data.name ?? "..."}',
                  style: theme.textTheme.bodyMedium,
                ),
                Text('Country: ${data.country ?? "..."}',
                  style: theme.textTheme.bodyMedium,
                ),
                Text('Alpha Two Code: ${data.alphaTwoCode ?? "..."}',
                  style: theme.textTheme.bodyMedium,
                ),
                Text('State/Province: ${data.alphaTwoCode ?? "..."}',
                  style: theme.textTheme.bodyMedium,
                ),
                Text('Domains: ${data.domains?.first ?? "..."}',
                  style: theme.textTheme.bodyMedium,
                ),
                Text('Web Pages: ${data.webPages?.first ?? "..."}',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}