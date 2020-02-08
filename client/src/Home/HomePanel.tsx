import React from "react";
import { Loader } from "semantic-ui-react";
import { useSummaries } from "../api";
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
      <Loader active={summariesFetch.loading} inline="centered" />
      {summariesFetch.data && (
        <CategoriesSummary categories={summariesFetch.data.summaries} />
      )}
    </section>
  );
};

export default HomePanel;
