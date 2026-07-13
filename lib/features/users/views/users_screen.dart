import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_viewmodel.dart';
import '../widgets/user_card.dart';
import '../widgets/user_shimmer.dart';
import '../widgets/state_widgets.dart';
import '../../../core/theme/app_theme.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<UserViewModel>().fetchUsers(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Directory'),
        actions: [
          IconButton(
            onPressed: () => context.read<UserViewModel>().fetchUsers(),
            icon: const Icon(Icons.refresh_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Consumer<UserViewModel>(
        builder: (context, viewModel, child) {
          switch (viewModel.state) {
            case ViewState.loading:
              return const UserShimmer();
            case ViewState.error:
              return ErrorStateWidget(
                message: viewModel.errorMessage,
                onRetry: () => viewModel.fetchUsers(),
              );
            case ViewState.loaded:
              if (viewModel.users.isEmpty) {
                return const EmptyStateWidget();
              }
              return RefreshIndicator(
                onRefresh: () => viewModel.fetchUsers(),
                color: AppTheme.primary,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  itemCount: viewModel.users.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return UserCard(user: viewModel.users[index]);
                  },
                ),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
