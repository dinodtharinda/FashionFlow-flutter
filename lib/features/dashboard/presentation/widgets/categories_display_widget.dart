import 'package:fashion_flow/core/common/cubits/display_categories/display_categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CategoryListWidget extends StatefulWidget {
  const CategoryListWidget({
    super.key,
  });

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.only(top: 15, bottom: 10),
        color: Theme.of(context).primaryColorDark.withOpacity(0.05),
        child: BlocBuilder<DisplayCatogoriesCubit, DisplayCategoriesState>(
          builder: (context, state) {
            if (state is DisplayCategoriesLoading || state is DisplayCategoriesFailure) {
              return buildCategoryShimmer();
            } else if (state is DisplayCategoriesSuccess) {
              return SizedBox(
                height: 110,
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: state.categories.length,
                    scrollDirection: Axis.horizontal,
                    primary: false,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          width: 85,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 42, 76, 68),
                                radius: 29,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                category.name,
                                style: const TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

Widget buildCategoryShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Number of placeholder items
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: 85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 29,
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Container(
                    width: 66,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}