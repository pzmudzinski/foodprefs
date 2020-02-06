import React from "react";
import { Link } from "@reach/router";
import { Loader, Icon, Table } from "semantic-ui-react";
import { useCategory, FoodProduct, useProductsByCategory } from "../api";
import FoodProductTableCell from "../shared/FoodProductTableCell";

type Props = {
  categoryId: string;
};

const renderProduct = (product: FoodProduct) => {
  return <FoodProductTableCell product={product} key={product.name} />;
};

const ProductsTable = ({
  title,
  products
}: {
  title: string;
  products: FoodProduct[];
}) => {
  return (
    <Table celled>
      <Table.Header>
        <Table.Row>
          <Table.HeaderCell colSpan="2">{title}</Table.HeaderCell>
        </Table.Row>
      </Table.Header>
      <Table.Body>{products.map(renderProduct)}</Table.Body>
    </Table>
  );
};

const CategoryTitle = ({ name }: { name: string }) => {
  return (
    <h1>
      <Link to="/">
        <Icon name="chevron left" />
      </Link>
      {name}
    </h1>
  );
};

const CategoryView = (props: Props) => {
  const categoryFetch = useCategory(props.categoryId);
  const productsFetch = useProductsByCategory(props.categoryId);

  return (
    <article>
      {categoryFetch.loading && <Loader />}
      {categoryFetch.data && <CategoryTitle name={categoryFetch.data.name} />}
      {productsFetch.data && (
        <ProductsTable title="Produkty" products={productsFetch.data} />
      )}
    </article>
  );
};

export default CategoryView;
