import React from "react";
import { Link } from "@reach/router";
import { Icon, Table } from "semantic-ui-react";

import { FoodProduct, FoodCategorySummary } from "../api";
import FoodProductTableCell from "../shared/FoodProductTableCell";

type Props = {
  summary: FoodCategorySummary;
};

const renderProduct = (product: FoodProduct) => {
  return <FoodProductTableCell product={product} key={product.name} />;
};

const CategorySummaryView = ({ summary }: Props) => {
  return (
    <Table celled>
      <Table.Header>
        <Table.Row>
          <Table.HeaderCell colSpan="2">
            <Link to={`/categories/${summary.category.id}`}>
              {summary.category.name}
              <Icon name="chevron right" />
            </Link>
          </Table.HeaderCell>
        </Table.Row>
      </Table.Header>
      <Table.Body>{summary.products.map(renderProduct)}</Table.Body>
    </Table>
  );
};

export default CategorySummaryView;
