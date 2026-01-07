import 'package:flutter/material.dart';
import '../models/routine_model.dart';
import '../utils/constants.dart';

class RoutineCard extends StatelessWidget {
  final RoutineModel routine;
  final VoidCallback? onTap;
  final bool showCheckbox;
  final bool isSelected;
  final ValueChanged<bool?>? onCheckboxChanged;

  const RoutineCard({
    super.key,
    required this.routine,
    this.onTap,
    this.showCheckbox = false,
    this.isSelected = false,
    this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Row(
            children: [
              if (showCheckbox)
                Checkbox(
                  value: isSelected,
                  onChanged: onCheckboxChanged,
                  activeColor: AppConstants.primaryColor,
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            routine.name,
                            style: AppConstants.subheadingStyle,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppConstants.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            routine.time,
                            style: const TextStyle(
                              color: AppConstants.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (routine.description.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        routine.description,
                        style: AppConstants.bodyStyle,
                      ),
                    ],
                    if (routine.activities.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      ...routine.activities.map((activity) => Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              activity,
                              style: AppConstants.bodyStyle.copyWith(
                                fontSize: 13,
                              ),
                            ),
                          )),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}