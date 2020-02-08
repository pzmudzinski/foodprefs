import React from "react";
import { Link } from "@reach/router";
import { Icon, Loader, Segment } from "semantic-ui-react";
import { useProduct } from "../api";
import ProductScore from "../shared/ScoreIcon";

type Props = {
  productId: string;
};

const ProductTitle = ({ name }: { name: string }) => {
  return (
    <h1>
      <Link to="/">
        <Icon name="chevron left" />
      </Link>
      {name}
    </h1>
  );
};

const Notes = ({ notes }: { notes?: string }) => {
  return (
    <Segment>
      <h1>Uwagi</h1>
      <p>{notes ? notes : "brak"}</p>
    </Segment>
  );
};

const Kcal = ({ kcal }: { kcal: number }) => {
  return (
    <Segment>
      <h1>Kcal</h1>
      <p>{kcal}</p>
    </Segment>
  );
};

const Score = ({ score }: { score: number }) => {
  return (
    <Segment>
      <h1>Wynik</h1>
      <ProductScore score={score} />
    </Segment>
  );
};

const ProductView = (props: Props) => {
  const productFetch = useProduct(props.productId);

  return (
    <>
      {productFetch.loading && <Loader />}
      {productFetch.data && <ProductTitle name={productFetch.data.name} />}
      {productFetch.data && <Score score={productFetch.data.score} />}
      {productFetch.data && <Kcal kcal={productFetch.data.kcal} />}
      {productFetch.data && <Notes notes={productFetch.data.notes} />}
    </>
  );
};

export default ProductView;
