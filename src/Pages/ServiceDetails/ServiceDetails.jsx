import { Col, Container, Row } from "react-bootstrap";
import { useDispatch, useSelector } from "react-redux";
import { handleRateStars } from "../../utils/constants";
import { fetchFromAPI } from "../../api/FetchFromAPI";
import { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";
import "./service-details.css";
import { setSelectedServiceToUpdate } from "../../Store/homeServiceSlice";
const ServiceDetails = () => {
  const { userTotalInfo, userToken } = useSelector(
    (state) => state.homeService
  );
  const [serviceTotalInfo, setServiceTotalInfo] = useState(null);
  const [serviceDetails, setServiceDetails] = useState(null);
  const [serviceForm, setServiceForm] = useState(null);
  const { username, id } = useParams();
  const dispatch = useDispatch();
  const history = useNavigate();
  const getServiceDetails = async () => {
    try {
      const data = await fetchFromAPI(`services/home_service/detail/${id}`);
      setServiceDetails(data);
      console.log("details:", data);
    } catch (err) {
      console.log(err);
    }
  };
  const getServiceForm = async () => {
    try {
      const data = await fetchFromAPI(
        `services/update_form_home_service/${id}`,
        {
          headers: {
            Authorization: `token ${userToken}`,
          },
        }
      );
      setServiceForm(data);
      console.log("form:", data);
    } catch (err) {
      console.log(err);
    }
  };
  const handelClickUpdate = () => {
    // setServiceTotalInfo({
    //   ...serviceTotalInfo,
    //   serviceDetails,
    //   form: serviceForm,
    // });
    // console.log(serviceTotalInfo);

    dispatch(
      setSelectedServiceToUpdate({ ...serviceDetails, form: serviceForm })
    );
    history(`/service/${id}/update`);
  };
  useEffect(() => {
    getServiceDetails();
    getServiceForm();
  }, []);
  return (
    <section className="service-details">
      <Container>
        <div className="d-flex justify-content-between align-items-center">
          <div>
            <h4>{serviceDetails?.category.name}</h4>
            <h1 className="mb-4">{serviceDetails?.title}</h1>
          </div>
          {username === userTotalInfo.username ? (
            <button onClick={() => handelClickUpdate()}>تعديل الخدمة</button>
          ) : (
            <button onClick={() => history(`/service/${id}/fill_form`)}>
              شراء الخدمة
            </button>
          )}
        </div>
        <Row>
          <Col lg={7} md={12}>
            <img
              className="service-image mb-5"
              src={serviceDetails?.category.photo}
              alt=""
            />
            <p>{serviceDetails?.description}</p>
          </Col>
          <Col lg={4} md={12}>
            <h5>بطاقة الخدمة</h5>
            <hr />
            <ul>
              <Row>
                <Col>التقييمات</Col>
                <Col className="stars">
                  {handleRateStars(serviceDetails?.average_ratings)}
                  <span>{`( ${serviceDetails?.number_of_served_clients} )`}</span>
                  <span></span>
                </Col>
              </Row>
              {/* <Row>
                <Col>متوسط سرعة الرد</Col>
                <Col>
                  {serviceDetails?.average_fast_answer
                    ? serviceDetails?.average_fast_answer
                    : "لم يحسب بعد"}
                </Col>
              </Row> */}
              <Row className="align-items-center">
                <Col>عدد العملاء</Col>
                <Col>{serviceDetails?.number_of_served_clients}</Col>
              </Row>
              <Row className="align-items-center">
                <Col>متوسط سعر الخدمة بالساعة</Col>
                <Col>{serviceDetails?.average_price_per_hour} ل.س</Col>
              </Row>
              <Row className="align-items-center">
                <Col>الخدمة متاحة في</Col>
                <Col className="areas d-flex gap-2">
                  {serviceDetails?.service_area.map((area) => (
                    <span>{area.name}</span>
                  ))}
                </Col>
              </Row>
            </ul>
            <hr />
            <Row>
              <h5 className="mb-3">صاحب الخدمة</h5>
              <div className="user-card d-flex align-items-center gap-2">
                <img src={serviceDetails?.seller.user.photo} alt="" />
                <span>
                  {serviceDetails?.seller.user.first_name}{" "}
                  {serviceDetails?.seller.user.last_name}
                </span>
              </div>
            </Row>
          </Col>
          {/* customer comments and rate */}
          {/* <Col lg={7} md={12}>
                <h2>خدماتي</h2>
                <hr />
                <ServicesList type="comp" />
              </Col> */}
        </Row>
      </Container>
    </section>
  );
};

export default ServiceDetails;
