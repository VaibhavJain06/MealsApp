import 'package:flutter_rev/provider/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegeterian,
  vegan,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegeterian: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isACTIVE) {
    state = {
      ...state,
      filter: isACTIVE,
    };
  }
}

final filterprovider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
    (ref) => FilterNotifier());

final filterMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activefilter = ref.watch(filterprovider);
  return meals.where((meal) {
    if (activefilter[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activefilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activefilter[Filter.vegeterian]! && !meal.isVegetarian) {
      return false;
    }
    if (activefilter[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
