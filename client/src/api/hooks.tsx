import useFetch from "use-http";
import { FoodCategory, FoodCategorySummary, FoodProduct } from "./models";
const baseUrl = "http://localhost:4000/api";

const getUrl = (path: string) => `${baseUrl}${path}`;

export const useCategory = (id: string) => {
  const req = useFetch<FoodCategory>(getUrl(`/categories/${id}`), []);

  return req;
};

export const useSummaries = () => {
  const req = useFetch<{ summaries: FoodCategorySummary[] }>(
    getUrl(`/categories/summaries`),
    []
  );

  return req;
};

export const useProduct = (id: string) => {
  const req = useFetch<FoodProduct>(getUrl(`/products/${id}`), []);

  return req;
};

export const useProductsByCategory = (id: string) => {
  const req = useFetch<FoodProduct[]>(getUrl(`/categories/${id}/products`), []);
  return req;
};

export const getPrompts = (query: string): Promise<FoodProduct[]> =>
  fetch(getUrl(`/products?query=${query}`)).then(res => {
    if (!res.ok) {
      throw new Error(res.statusText);
    }

    return res.json();
  });

export const usePrompts = (query: string) => {
  const req = useFetch<FoodProduct[]>(getUrl(`/products?query=${query}`), [
    query
  ]);

  return req;
};
