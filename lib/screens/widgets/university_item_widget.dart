
import 'package:flutter/material.dart';
import 'package:practical_test/data/model/university/university.dart';
import 'package:practical_test/providers/university/university.dart';
import 'package:practical_test/screens/route.dart' as route;
import 'package:provider/provider.dart';

class UniversityItem extends StatelessWidget {
  const UniversityItem({
    super.key, required this.data,
  });

  final UniversityModel data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.read<UniversityProvider>().getUniversityDetail(data: data);
        Navigator.pushNamed(context, route.detailScreen);
      },
      leading: const CircleAvatar(
        child: Icon(Icons.school),
      ),
      title: Text(data.name ?? "...",
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(data.country.toString().replaceAll('Country.', ''),
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}