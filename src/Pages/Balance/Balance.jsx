import { Col, Container, Row } from "react-bootstrap";
import "./balance.css";
const Balance = () => {
  return (
    <section className="balance">
      <Container>
        <h1>رصيد الحساب</h1>
        <Row className="justify-content-center">
          <Col
            md={4}
            sm={10}
            className="d-flex flex-column justify-content-center align-items-center gap-3"
          >
            <h2>الرصيد الكلي</h2>
            <span>0.00 SP</span>
            <p>
              كامل الرصيد الموجود في حسابك الآن يتضمن الأرباح والرصيد المعلّق
              أيضاً
            </p>
          </Col>
          <Col
            md={4}
            sm={10}
            className="d-flex flex-column justify-content-center align-items-center gap-3"
          >
            <h2>رصيد معلّق</h2>
            <span>0.00 SP</span>
            <p>
              يتم تعليق الأرباح التي حققتها لمدة 14 يوم قبل أن تتمكن من
              استخدامها.
            </p>
          </Col>
          <Col
            md={4}
            sm={10}
            className="d-flex flex-column justify-content-center align-items-center gap-3"
          >
            <h2>أرباح يمكن سحبها</h2>
            <span>0.00 SP</span>
            <p>المبلغ الذي حققته من بيع الخدمات ويمكن سحبه</p>
          </Col>
        </Row>
      </Container>
    </section>
  );
};
export default Balance;
