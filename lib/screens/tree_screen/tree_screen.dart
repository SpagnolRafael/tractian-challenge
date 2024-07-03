import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/data/dto/company_asset_dto.dart';
import 'package:tractian_challenge/screens/tree_screen/tree_bloc.dart';
import 'package:tractian_challenge/screens/tree_screen/tree_event.dart';
import 'package:tractian_challenge/screens/tree_screen/tree_state.dart';
import 'package:tractian_challenge/screens/tree_screen/widgets/tree_widget.dart';
import 'package:tractian_challenge/shareds/custom_empty_widget.dart';
import 'package:tractian_challenge/shareds/custom_error_widget.dart';
import 'package:tractian_challenge/shareds/custom_filter_button.dart';
import 'package:tractian_challenge/shareds/custom_scaffold.dart';
import 'package:tractian_challenge/shareds/custom_textformfield.dart';
import 'package:tractian_challenge/utils/app_colors.dart';
import 'package:tractian_challenge/utils/app_icons.dart';
import 'package:tractian_challenge/utils/debouncer.dart';

class TreeScreen extends StatefulWidget {
  final String id;
  const TreeScreen({super.key, required this.id});

  @override
  State<TreeScreen> createState() => _TreeScreenState();
}

class _TreeScreenState extends State<TreeScreen> {
  final Debouncer _debouncer = Debouncer(milliseconds: 400);
  List<CompanyAssetDto> _assets = [];
  final bloc = GetIt.I.get<TreeBloc>();
  void Function()? _onTryAgain;
  String? _selectedFilter;
  String? _query;

  @override
  void initState() {
    super.initState();
    bloc.add(LoadAssetEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TreeBloc, TreeState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is TreeErrorState) _onTryAgain = state.onTryAgain;
        if (state is TreeSuccessState) _assets = state.assets;
      },
      builder: (context, state) {
        return CustomScaffold(
          title: 'Assets',
          onBackTap: () => Navigator.of(context).pop(),
          body: Builder(builder: (context) {
            if (state is TreeLoadingState || state is TreeInitialState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is TreeErrorState) {
              return CustomErrorWidget(
                  onTryAgain: _onTryAgain, description: 'tree');
            }
            return Column(
              children: [
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextFormField(
                    hintText: 'Buscar Ativo ou Local',
                    onChanged: (value) {
                      _query = value;
                      _debouncer.run(() async {
                        bloc.add(FilterChangeEvent(
                            query: _query, type: _selectedFilter));
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      CustomFilterButton(
                          onTap: () {
                            _selectedFilter == 'energy'
                                ? _selectedFilter = null
                                : _selectedFilter = 'energy';
                            bloc.add(FilterChangeEvent(
                                query: _query, type: _selectedFilter));
                          },
                          selected: _selectedFilter == 'energy',
                          icon: Icon(Icons.bolt_sharp,
                              color: _selectedFilter == 'energy'
                                  ? AppColors.white
                                  : AppColors.grey300),
                          text: 'Sensor de Energia'),
                      const SizedBox(width: 10),
                      CustomFilterButton(
                          onTap: () {
                            _selectedFilter == 'vibration'
                                ? _selectedFilter = null
                                : _selectedFilter = 'vibration';
                            bloc.add(FilterChangeEvent(
                                query: _query, type: _selectedFilter));
                          },
                          selected: _selectedFilter == 'vibration',
                          icon: SvgPicture.asset(
                            height: 15,
                            width: 15,
                            AppIcons.iconWarningRounded,
                            colorFilter: ColorFilter.mode(
                                _selectedFilter == 'vibration'
                                    ? AppColors.white
                                    : AppColors.grey300,
                                BlendMode.srcIn),
                          ),
                          text: 'Crítico'),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const Divider(height: 0, color: AppColors.grey100),
                const SizedBox(height: 5),
                if (_assets.isNotEmpty) ...[
                  Expanded(
                    child: Theme(
                      data: ThemeData()
                          .copyWith(dividerColor: Colors.transparent),
                      child: TreeWidget(
                        shrinkWrap: false,
                        parents:
                            _assets.where((e) => e.parentId == null).toList(),
                        others:
                            _assets.where((e) => e.parentId != null).toList(),
                      ),
                    ),
                  )
                ] else
                  const Expanded(child: CustomEmptyWidget()),
              ],
            );
          }),
        );
      },
    );
  }
}
