import React from "react";
import "./Header.css";
import githubLogo from "./githubLogo.png";

const Header = () => {
  return (
    <header className="header">
      <h1>Czego nie je Piotrek?</h1>
      <img src={githubLogo} alt="github" />
    </header>
  );
};

export default Header;
