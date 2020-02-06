import React from "react";
import styles from "./SidePanel.module.css";
import { ReactComponent as Logo } from "./chinese-food.svg";

const SidePanel = () => {
  return (
    <aside className={styles.sidePanel}>
      <Logo className={styles.sideLogo} />
    </aside>
  );
};

export default SidePanel;
