export interface FoodProduct {
  id: number;
  kcal: number;
  name: string;
  score: number;
  notes?: string;
}

export interface FoodCategory {
  id: number;
  name: string;
  notes?: string;
}

export interface FoodCategorySummary {
  category: FoodCategory;
  products: FoodProduct[];
}
