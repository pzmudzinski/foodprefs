import React from "react";
import { Link } from "@reach/router";
import { List, Segment } from "semantic-ui-react";
import Autosuggest, {
  RenderSuggestionsContainerParams
} from "react-autosuggest";
import SearchInput from "./SearchInput";
import { getPrompts, FoodProduct } from "../api";
import ScoreIcon from "../shared/ScoreIcon";
import styles from "./SearchBar.module.css";
const Highlighter = require("react-highlight-words");

const minimumQueryLength = 3;

export interface Suggestion {
  id: number;
  name: string;
  score: number;
}

const renderSuggestion = (
  suggestion: Suggestion,
  { query }: { query: string }
) => {
  return (
    <Segment style={{ marginBottom: "0.5em" }}>
      <Link
        style={{
          display: "flex",
          justifyContent: "space-between"
        }}
        to={`/products/${suggestion.id}`}
      >
        <Highlighter
          searchWords={[query]}
          autoEscape
          textToHighlight={suggestion.name}
        />

        <ScoreIcon score={suggestion.score} />
      </Link>
    </Segment>
  );
};

const renderSuggestionContainer = (
  params: RenderSuggestionsContainerParams
) => {
  const containerProps = params.containerProps;
  return (
    <div {...containerProps}>
      {params.query.length >= minimumQueryLength && <h1>Wyniki</h1>}
      {params.children}
    </div>
  );
};

const getSuggestionValue = (suggestion: Suggestion) => suggestion.name;

const SearchBar = () => {
  const [suggestions, changeSuggestions] = React.useState<FoodProduct[]>([]);
  const [value, onChange] = React.useState("");

  const inputProps = {
    placeholder: "Wpisz nazwę jedzenia",
    onChange: (
      event: React.ChangeEvent<HTMLInputElement>,
      { newValue }: { newValue: string }
    ) => {
      onChange(newValue);
    },
    value
  };

  return (
    <Autosuggest
      suggestions={suggestions}
      inputProps={inputProps}
      onSuggestionsFetchRequested={({ value }: { value: string }) => {
        if (value.trim().length < minimumQueryLength) {
          changeSuggestions([]);
          return;
        }
        getPrompts(value).then(changeSuggestions);
      }}
      onSuggestionsClearRequested={() => {
        console.log("clear");
        //changeSuggestions([]);
      }}
      getSuggestionValue={getSuggestionValue}
      renderSuggestion={renderSuggestion}
      renderSuggestionsContainer={renderSuggestionContainer}
      renderInputComponent={SearchInput}
      alwaysRenderSuggestions
    />
  );
};

export default SearchBar;
