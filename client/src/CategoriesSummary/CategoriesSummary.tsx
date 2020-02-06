import React from "react";
import { FoodCategorySummary } from "../api";
import FoodCategoryView from "./CategorySummary";
import styles from "./CategoriesSummary.module.css";

type Props = { categories: FoodCategorySummary[] };

const renderCategory = (summary: FoodCategorySummary) => {
  return <FoodCategoryView key={summary.category.name} summary={summary} />;
};

const CategoriesSummary = ({ categories }: Props) => {
  return (
    <article className={styles.summaries}>
      {categories.map(renderCategory)}
    </article>
  );
};

export default CategoriesSummary;
