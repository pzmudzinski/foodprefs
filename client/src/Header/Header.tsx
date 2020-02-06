import React from "react";
import "./Header.css";
import githubLogo from "./githubLogo.png";

const Header = () => {
  return (
    <header className="header">
      <h1>Czego nie je Piotrek?</h1>
      <a
        target="_blank"
        rel="noopener noreferrer"
        href="https://github.com/pzmudzinski/foodprefs"
      >
        <img src={githubLogo} alt="github" />
      </a>
    </header>
  );
};

export default Header;
