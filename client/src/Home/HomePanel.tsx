import React, { useState, useEffect } from "react";
import { Loader } from "semantic-ui-react";
import { FoodCategorySummary, useSummaries } from "../api";
import SearchBar from "../SearchBar";
import CategoriesSummary from "../CategoriesSummary";
import "./HomePanel.css";

const HomePanel = () => {
  const summariesFetch = useSummaries();

  return (
    <section className="home">
      <h2>
        Nie możesz spamiętać co ja w końcu lubię a czego nie lubię? <br />
        <br />
        Ta wyszukiwarka jest dla Ciebie!
      </h2>
      <SearchBar />
      <h1>Kategorie</h1>

      {summariesFetch.loading && <Loader />}
      {summariesFetch.data && (
        <CategoriesSummary categories={summariesFetch.data.summaries} />
      )}
    </section>
  );
};

export default HomePanel;
