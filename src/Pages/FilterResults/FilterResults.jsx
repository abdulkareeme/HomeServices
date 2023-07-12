import { useEffect, useState } from "react";
import { fetchFromAPI } from "../../api/FetchFromAPI";
import { useDispatch, useSelector } from "react-redux";
import { shortInfo } from "../../utils/constants";
import { Col, Container, Row } from "react-bootstrap";
import ServiceCard from "../../Components/ServiceCard/ServiceCard";
import {
  setClearResults,
  setSelectedCategory,
} from "../../Store/homeServiceSlice";
import "./filter-results.css";
import SearchBar from "../../Components/SeachBar/SearchBar";
import LoaderContent from "../../Components/LoaderContent/LoaderContent";
import Cookies from "js-cookie";
const FilterResults = () => {
  const { selectedCategory, clearResults } = useSelector(
    (state) => state.homeService
  );
  const searchWord = Cookies.get("searchWord");
  const dispatch = useDispatch();
  if (!selectedCategory) {
    const storedCategory = Cookies.get("selectedCategory");
    dispatch(setSelectedCategory(storedCategory));
  }
  const [servicesList, setServiceList] = useState(null);
  const [isLoading, setIsLoading] = useState(true);

  const getServicesByCategories = async () => {
    try {
      setIsLoading(true);
      const res = await fetchFromAPI(
        `services/list_home_services?category=${selectedCategory}`
      );
      setIsLoading(false);
      setServiceList(res);
      console.log(res);
    } catch (err) {
      setIsLoading(false);
      console.log(err);
    }
  };
  const getServicesByCategoriesAndSearch = async () => {
    try {
      setIsLoading(true);
      const res = await fetchFromAPI(
        `services/list_home_services?category=${selectedCategory}&title=${searchWord}`
      );
      setIsLoading(false);
      setServiceList(res);
      dispatch(setClearResults(false));
      console.log(res);
    } catch (err) {
      console.log(err);
      setIsLoading(false);
    }
  };
  useEffect(() => {
    setServiceList(null);
    getServicesByCategories();
  }, [selectedCategory]);
  useEffect(() => {
    if (clearResults) {
      setServiceList(null);
      getServicesByCategoriesAndSearch();
    }
  }, [clearResults]);
  return (
    <section className="filter-results">
      <Container>
        <div className="d-flex justify-content-between align-items-center gap-2 flex-wrap mb-5">
          <div>
            <h1>{selectedCategory}</h1>
            <p>{shortInfo[selectedCategory]}</p>
          </div>
          <SearchBar type="filled" goto="inside" />
        </div>
        {isLoading ? <LoaderContent /> : null}
        <Row className="service-items justify-content-center d-flex gap-2">
          {servicesList?.map((item) => (
            <Col lg={4} md={5} xs={10} key={item.id}>
              <ServiceCard serviceData={item} id={item.id} />
            </Col>
          ))}
        </Row>
        {servicesList?.length === 0 && !isLoading ? (
          <Row className="justify-content-center align-items-center">
            <h2 className="w-max">لا يوجد نتائج مطابقة جرب كلمة أخرى</h2>
          </Row>
        ) : null}
      </Container>
    </section>
  );
};

export default FilterResults;
