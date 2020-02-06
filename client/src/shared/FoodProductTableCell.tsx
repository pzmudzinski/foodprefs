import React from "react";
import { Table } from "semantic-ui-react";
import { Link } from "@reach/router";
import { FoodProduct } from "../api";
import ScoreIcon from "./ScoreIcon";

type Props = {
  product: FoodProduct;
};

const FoodProductTableCell = ({ product }: Props) => {
  return (
    <Table.Row negative={product.score <= 50} positive={product.score >= 50}>
      <Table.Cell>
        <Link to={`/products/${product.id}`}>{product.name}</Link>
      </Table.Cell>
      <Table.Cell textAlign="right" collapsing>
        <ScoreIcon score={product.score} />
      </Table.Cell>
    </Table.Row>
  );
};

export default FoodProductTableCell;
