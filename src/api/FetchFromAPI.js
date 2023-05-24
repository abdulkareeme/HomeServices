import axios from "axios";
import { BASE_API_URL } from "../utils/constants";

export const fetchFromAPI = async (url) => {
  const { data } = await axios.get(`${BASE_API_URL}/${url}`);
  return data;
};

export const postToAPI = async (url, value) => {
  const { data } = await axios.post(`${BASE_API_URL}/${url}`, value);
  return data;
};
