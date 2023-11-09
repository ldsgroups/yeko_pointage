import 'package:flutter/material.dart';

Container buildSearch({
  required BuildContext context,
  bool? hasFilter = false,
  void Function()? onFilter,
  void Function(String)? onChanged,
  required TextEditingController searchController,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: colorScheme.secondaryContainer,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        const Icon(Icons.search),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: searchController,
            onChanged: onChanged,
            decoration: const InputDecoration(
              hintText: 'Rechercher ...',
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Row(
          children: [
            // clear search
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: searchController.clear,
            ),

            // filter
            if (hasFilter!)
              IconButton(
                icon: const Icon(Icons.auto_awesome_outlined),
                onPressed: onFilter,
              ),
          ],
        ),
      ],
    ),
  );
}
