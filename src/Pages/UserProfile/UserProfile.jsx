import { Col, Container, Row } from "react-bootstrap";
import { useSelector } from "react-redux";
import "./user-profile.css";
import UserProfileLayout from "../../Components/UserProfileLayout";
import ServicesList from "../../Components/ServicesList/ServicesList";
const UserProfile = () => {
  const { userTotalInfo } = useSelector((state) => state.homeService);
  return (
    <UserProfileLayout>
      {userTotalInfo.mode === "seller" ? (
        <div className="user-profile">
          <Container>
            <Row>
              <Col lg={7} md={12}>
                <h2>نبذة عني</h2>
                <hr />
                <p>
                  {userTotalInfo?.bio?.length > 0
                    ? userTotalInfo.bio
                    : "لم يكتب نبذة شخصية"}
                </p>
              </Col>
              <Col lg={4} md={12}>
                <h2>إحصائيات</h2>
                <hr />
                <ul>
                  <Row>
                    <Col>التقييمات</Col>
                    {userTotalInfo.clients_number > 0 ? (
                      <Col className="stars">
                        <ion-icon name="star"></ion-icon>
                        <ion-icon name="star"></ion-icon>
                        <ion-icon name="star"></ion-icon>
                        <ion-icon name="star"></ion-icon>
                        <ion-icon name="star"></ion-icon>
                        <span>{`( ${userTotalInfo.clients_number} )`}</span>
                      </Col>
                    ) : (
                      <Col className="stars">
                        <ion-icon name="star-outline"></ion-icon>
                        <ion-icon name="star-outline"></ion-icon>
                        <ion-icon name="star-outline"></ion-icon>
                        <ion-icon name="star-outline"></ion-icon>
                        <ion-icon name="star-outline"></ion-icon>
                      </Col>
                    )}
                  </Row>
                  <Row>
                    <Col>الخدمات المنشورة</Col>
                    <Col>{userTotalInfo.services_number}</Col>
                  </Row>
                  <Row>
                    <Col>متوسط سرعة الرد</Col>
                    <Col>6 ساعات</Col>
                  </Row>
                </ul>
              </Col>
              <Col lg={7} md={12}>
                <h2>خدماتي</h2>
                <hr />
                <ServicesList type="comp" />
              </Col>
            </Row>
          </Container>
        </div>
      ) : null}
    </UserProfileLayout>
  );
};

export default UserProfile;
