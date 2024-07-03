import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/data/dto/company_dto.dart';
import 'package:tractian_challenge/screens/home_screen/home_bloc.dart';
import 'package:tractian_challenge/screens/home_screen/home_event.dart';
import 'package:tractian_challenge/screens/home_screen/home_state.dart';
import 'package:tractian_challenge/screens/home_screen/widgets/company_card.dart';
import 'package:tractian_challenge/shareds/custom_empty_widget.dart';
import 'package:tractian_challenge/shareds/custom_error_widget.dart';
import 'package:tractian_challenge/shareds/custom_scaffold.dart';
import 'package:tractian_challenge/shareds/custom_snackbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CompanyDto> _companies = [];
  final bloc = GetIt.I.get<HomeBloc>();
  void Function()? _onTryAgain;

  @override
  void initState() {
    super.initState();
    bloc.add(LoadCompaniesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is HomeSuccessState) _companies = state.companies;
        if (state is HomeErrorState) {
          _onTryAgain = state.onTryAgain;
          CustomSnackbar.show(
              context: context,
              type: SnackType.error,
              content: const Text('An error occurred trying to load units'));
        }
      },
      builder: (context, state) {
        if (state is HomeLoadingState || state is HomeInitialState) {
          return const Center(child: CircularProgressIndicator());
        }
        return CustomScaffold(
          body: Column(
            children: [
              if (state is HomeEmptyState)
                const Center(child: CustomEmptyWidget()),
              if (state is HomeErrorState)
                Center(
                    child: CustomErrorWidget(
                        onTryAgain: _onTryAgain, description: 'units')),
              if (_companies.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    physics: const ClampingScrollPhysics(),
                    itemCount: _companies.length,
                    itemBuilder: (context, index) =>
                        CompanyCard(company: _companies[index]),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
