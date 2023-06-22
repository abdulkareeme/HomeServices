import { useEffect, useState } from "react";
import { fetchFromAPI } from "../../api/FetchFromAPI";
import { useDispatch, useSelector } from "react-redux";
import { shortInfo } from "../../utils/constants";
import { Col, Container, Row } from "react-bootstrap";
import ServiceCard from "../../Components/ServiceCard/ServiceCard";
import { setSelectedCategory } from "../../Store/homeServiceSlice";
import "./service-list-page.css";
const ServiceListPage = () => {
  const { selectedCategory } = useSelector((state) => state.homeService);
  const dispatch = useDispatch();
  if (!selectedCategory) {
    const storedCategory = localStorage.getItem("selectedCategory");
    dispatch(setSelectedCategory(storedCategory));
  }
  const [servicesList, setServiceList] = useState(null);
  const getServicesByCategories = async () => {
    try {
      const res = await fetchFromAPI(
        `services/list_home_services?category=${selectedCategory}`
      );
      setServiceList(res);
      console.log(res);
    } catch (err) {
      console.log(err);
    }
  };
  useEffect(() => {
    getServicesByCategories();
  }, []);
  return (
    <section className="service-list-page">
      <Container>
        <div className="d-flex justify-content-between align-items-center gap-2 flex-wrap mb-5">
          <div>
            <h1>{selectedCategory}</h1>
            <p>{shortInfo[selectedCategory]}</p>
          </div>
          <input type="text" placeholder="ابحث عن" />
        </div>
        <Row className="service-items justify-content-center d-flex gap-2">
          {servicesList?.map((item) => (
            <Col lg={4} md={5} xs={10} key={item.id}>
              <ServiceCard serviceData={item} />
            </Col>
          ))}
        </Row>
      </Container>
    </section>
  );
};

export default ServiceListPage;
