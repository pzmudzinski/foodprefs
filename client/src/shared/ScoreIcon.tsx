import React from "react";
import { ReactComponent as UpIcon } from "./thumb_up.svg";
import { ReactComponent as DownIcon } from "./thumb_down.svg";

type Props = {
  score: number;
};

const ScoreIcon = ({ score }: Props) => {
  return (
    <span>
      {score <= 50 ? (
        <DownIcon style={{ fill: "var(--color-dark)" }} />
      ) : (
        <UpIcon style={{ fill: "var(--theme-dark)" }} />
      )}
    </span>
  );
};

export default ScoreIcon;
