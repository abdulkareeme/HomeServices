import home from "../../Images/home-1.jpg";
import { Col, Container, Row } from "react-bootstrap";
import "./services-list.css";
import { useSelector } from "react-redux";

const ServicesList = ({ type }) => {
  const { userTotalInfo } = useSelector((state) => state.homeService);
  if (userTotalInfo.services_number > 0) {
    return (
      <Row className={type === "page" ? "services page" : "services"}>
        <Col lg={type === "page" ? 3 : 5} md={5} xs={10}>
          <img src={home} alt="" />
          <h1>سأقوم بإنشاء موقع ويب سريع الاستجابة باستخدام react js</h1>
          <span>تطوير</span>
        </Col>
        <Col lg={type === "page" ? 3 : 5} md={5} xs={10}>
          <img src={home} alt="" />
          <h1>سأقوم بإنشاء موقع ويب سريع الاستجابة باستخدام react js</h1>
          <span>تطوير</span>
        </Col>
        <Col lg={type === "page" ? 3 : 5} md={5} xs={10}>
          <img src={home} alt="" />
          <h1>سأقوم بإنشاء موقع ويب سريع الاستجابة باستخدام react js</h1>
          <span>تطوير</span>
        </Col>
        <Col lg={type === "page" ? 3 : 5} md={5} xs={10}>
          <img src={home} alt="" />
          <h1>سأقوم بإنشاء موقع ويب سريع الاستجابة باستخدام react js</h1>
          <span>تطوير</span>
        </Col>
        <Col lg={type === "page" ? 3 : 5} md={5} xs={10}>
          <img src={home} alt="" />
          <h1>سأقوم بإنشاء موقع ويب سريع الاستجابة باستخدام react js</h1>
          <span>تطوير</span>
        </Col>
      </Row>
    );
  } else {
    if (type === "page") {
      return <Row className="services page fs-4">لم يقم بإضافة خدمات بعد</Row>;
    } else return "لم يقم بإضافة خدمات بعد";
  }
};

export default ServicesList;
