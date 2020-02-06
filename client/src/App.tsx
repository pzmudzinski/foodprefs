import React from "react";
import { Router, RouteComponentProps } from "@reach/router";
import HomePanel from "./Home";
import Header from "./Header/Header";
import CategoryView from "./CategoryView";
import ProductView from "./ProductView";
import SidePanel from "./SidePanel";
import "./App.css";

type Props<T extends Partial<Record<string, string>>> = RouteComponentProps<
  T
> & {
  component: (props: RouteComponentProps<T>) => React.ReactNode;
};

function Route<Params = {}>({ component, ...props }: Props<Params>) {
  return <>{component(props as RouteComponentProps<Params>)}</>;
}

const App = () => {
  return (
    <div className="App">
      <Header />
      <main className="mainContainer">
        <Router style={{ zIndex: 10, padding: "2em" }}>
          <Route path="/" component={HomePanel} />
          <Route<{ id: string }>
            path="/categories/:id"
            component={({ id }) => <CategoryView categoryId={id!} />}
          />
          <Route<{ id: string }>
            path="/products/:id"
            component={({ id }) => <ProductView productId={id!} />}
          />
        </Router>

        <SidePanel />
      </main>
    </div>
  );
};

export default App;
