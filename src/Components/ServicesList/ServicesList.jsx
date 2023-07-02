// import home from "../../Images/home-1.jpg";
import { Col, Container, Row } from "react-bootstrap";
import "./services-list.css";
import { useDispatch, useSelector } from "react-redux";
import { useEffect, useState } from "react";
import { fetchFromAPI } from "../../api/FetchFromAPI";
import { useNavigate } from "react-router-dom";
import { setSelectedUser } from "../../Store/homeServiceSlice";

const ServicesList = ({ type }) => {
  const { selectedUser } = useSelector((state) => state.homeService);
  const [serviceList, setServiceList] = useState(null);
  const history = useNavigate();
  const dispatch = useDispatch();
  if (selectedUser === null) {
    const storedselectedUser = JSON.parse(
      localStorage.getItem("selectedUser")
    );
    dispatch(setSelectedUser(storedselectedUser));
  }
  const getServiceList = async () => {
    try {
      const serviceData = await fetchFromAPI(
        `services/list_home_services?username=${selectedUser.username}`
      );
      setServiceList(serviceData);
    } catch (err) {
      console.log(err);
    }
  };
  useEffect(() => {
    getServiceList();
  }, [selectedUser]);
  if (selectedUser.services_number > 0) {
    if (type === "page") {
      return (
        <section className="services page">
          <Container>
            <Row>
              {serviceList &&
                serviceList.map((item) => (
                  <Col
                    key={item.id}
                    lg={type === "page" ? 3 : 5}
                    md={5}
                    xs={10}
                  >
                    <img
                      onClick={() =>
                        history(
                          `/user/${selectedUser.username}/services/${item.id}`
                        )
                      }
                      src={item.category.photo}
                      alt=""
                    />
                    <h1
                      onClick={() =>
                        history(
                          `/user/${selectedUser.username}/services/${item.id}`
                        )
                      }
                    >
                      {item.title}
                    </h1>
                    <span>{item.category.name}</span>
                    <span> {item.average_price_per_hour} ل.س</span>
                  </Col>
                ))}
              {!serviceList && <div>يتم التحميل</div>}
            </Row>
          </Container>
        </section>
      );
    } else {
      return (
        <Row className="services">
          {serviceList &&
            serviceList.map((item) => (
              <Col key={item.id} lg={type === "page" ? 3 : 5} md={5} xs={10}>
                <img
                  onClick={() =>
                    history(
                      `/user/${selectedUser.username}/services/${item.id}`
                    )
                  }
                  src={item.category.photo}
                  alt=""
                />
                <h1
                  onClick={() =>
                    history(
                      `/user/${selectedUser.username}/services/${item.id}`
                    )
                  }
                >
                  {item.title}
                </h1>
                <span>{item.category.name}</span>
                <span> {item.average_price_per_hour} ل.س</span>
              </Col>
            ))}
          {!serviceList && <div>يتم التحميل</div>}
        </Row>
      );
    }
  } else {
    if (type === "page") {
      return (
        <Row className="services page fs-4 px-5 py-4">
          لم يقم بإضافة خدمات بعد
        </Row>
      );
    } else return "لم يقم بإضافة خدمات بعد";
  }
};
export default ServicesList;
