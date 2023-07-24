import { Col, Container, Row } from "react-bootstrap";
import landing from "../../Images/home-1.jpg";
import "./landing.css";
import SearchBar from "../SeachBar/SearchBar";
const Landing = () => {
  return (
    <div
      className="image-container"
      style={{ backgroundImage: `url(${landing})` }}
    >
      <div className="overlay">
        <Container>
          <Row>
            <Col className="justify-content-center">
              <h1 className="fs-1 w-fit mx-auto mb-4">
                موقع عربي لعرض الخدمات المنزلية
              </h1>
              <p className="fs-5 w-fit mx-auto mb-6">
                سهولة الوصول لمزودي الخدمات المناسبين
              </p>
              <SearchBar type="filled" goto="page" />
            </Col>
          </Row>
        </Container>
      </div>
    </div>
  );
};

export default Landing;
