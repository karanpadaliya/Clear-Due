import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_toggle_switch/bloc/custom_toggle_switch_bloc.dart';
import 'package:myco_flutter/widgets/custom_toggle_switch/bloc/custom_toggle_switch_event.dart';
import 'package:myco_flutter/widgets/custom_toggle_switch/bloc/custom_toggle_switch_state.dart';

class CustomToggleSwitch extends StatelessWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final bool showLabelBelowOnOnState;

  const CustomToggleSwitch({
    required this.initialValue,
    required this.onChanged,
    this.showLabelBelowOnOnState = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => CustomToggleSwitchBloc(initialValue),
    child: BlocBuilder<CustomToggleSwitchBloc, CustomToggleSwitchState>(
      builder: (context, state) {
        final isOn = state.isOn;
        final bloc = context.read<CustomToggleSwitchBloc>();
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                bloc.add(ToggleSwitchToggled());
                onChanged(!isOn);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 0.18 * Responsive.getWidth(context),
                height: 0.035 * Responsive.getHeight(context),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: isOn
                      ? AppTheme.getColor(context).primary
                      : AppTheme.getColor(context).onPrimary,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.getColor(context).primary),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: isOn
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10 * Responsive.getResponsive(context),
                        ),
                        child: CustomText(
                          isOn ? 'ON' : 'OFF',
                          color: isOn
                              ? AppTheme.getColor(context).onPrimary
                              : AppTheme.getColor(context).primary,
                          fontSize: 12 * Responsive.getResponsiveText(context),
                        ),
                      ),
                    ),
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 200),
                      alignment: isOn
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        width: 0.04 * Responsive.getWidth(context),
                        height: 0.020 * Responsive.getHeight(context),
                        decoration: BoxDecoration(
                          color: isOn
                              ? AppTheme.getColor(context).onPrimary
                              : AppTheme.getColor(context).primary,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppTheme.getColor(context).primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (showLabelBelowOnOnState)
              Visibility(
                visible: isOn,
                maintainAnimation: true,
                maintainState: true,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 3 * Responsive.getResponsive(context),
                  ),
                  child: CustomText(
                    'app_default',
                    color: AppTheme.getColor(context).primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 14 * Responsive.getResponsiveText(context),
                  ),
                ),
              ),
          ],
        );
      },
    ),
  );
}
