import React from "react";
import Autosuggest from "react-autosuggest";
import styles from "./SearchBar.module.css";
import { ReactComponent as SearchIcon } from "./search.svg";
import { Suggestion } from "./SearchBar";

const SearchInput = (props: Autosuggest.InputProps<Suggestion>) => {
  return (
    <div className={styles.inputContainer}>
      <input
        {...props}
        onChange={event =>
          props.onChange(event, {
            newValue: event.target.value,
            method: "type"
          })
        }
        className={styles.searchInput}
      />
      <SearchIcon className={styles.searchIcon} />
    </div>
  );
};

export default SearchInput;
