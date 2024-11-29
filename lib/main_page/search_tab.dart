import 'package:findflow_mobile/services/users_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchTab extends ConsumerStatefulWidget {
  const SearchTab({super.key});

  @override
  ConsumerState<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends ConsumerState<SearchTab> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final beaconService = ref.watch(usersServiceProvider.notifier);
    final users = ref.watch(usersServiceProvider);

    return SafeArea(
      child: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: "Search for boardgames",
              prefixIcon: Icon(Icons.search),
            ),
            onEditingComplete: () =>
                beaconService.fetchUserLow(searchController.text),
          ),
          Expanded(
            child: switch (users) {
              UsersInitial() => const Center(
                  child: Text("No users found"),
                ),
              UsersLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              UsersError(message: var message) => Text(message),
              UsersLoaded(users: var users) => ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final game = users[index];

                    return ListTile(
                      title: Text(game.name),
                      // subtitle: Text(game.),
                      // onTap: () => Navigator.of(context)
                      //     .push(openBoardDetails(game.objectId)),
                    );
                  },
                ),
            },
          )
        ],
      ),
    );
  }
}
