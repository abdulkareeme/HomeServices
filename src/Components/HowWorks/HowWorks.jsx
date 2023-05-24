import { Col, Container, Row } from "react-bootstrap";
import { howItWorksBoxes } from "../../utils/constants";
import "./howworks.css";
const HowWorks = () => {
  return (
    <section>
      <Container>
        <h1 className="w-max mx-auto">كيف يعمل موقع منزلي ؟</h1>
        <Row className="pt-6" xs={1} md={3}>
          {howItWorksBoxes.map((box, index) => (
            <Col
              xs={12}
              md={6}
              lg={4}
              className="box p-2 d-flex align-items-center gap-4"
              key={index}
            >
              <div className="image-holder">
                <img src={box.icon} alt="" />
              </div>
              <div className="box-body">
                <h5>{box.head}</h5>
                <p>{box.text}</p>
              </div>
            </Col>
          ))}
        </Row>
      </Container>
    </section>
  );
};

export default HowWorks;
