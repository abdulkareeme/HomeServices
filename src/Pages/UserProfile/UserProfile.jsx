import { Col, Container, Row } from "react-bootstrap";
import { useDispatch, useSelector } from "react-redux";
import "./user-profile.css";
import UserProfileLayout from "../../Components/UserProfileLayout";
import ServicesList from "../../Components/ServicesList/ServicesList";
import { setUserTotalInfo } from "../../Store/homeServiceSlice";
import { handleRateStars } from "../../utils/constants";
const UserProfile = () => {
  const { userTotalInfo } = useSelector((state) => state.homeService);
  const dispatch = useDispatch();
  if (userTotalInfo === null) {
    const storedUser = localStorage.getItem("userTotalInfo");
    dispatch(setUserTotalInfo(JSON.parse(storedUser)));
    console.log(userTotalInfo);
  }
  return (
    <UserProfileLayout>
      {userTotalInfo?.mode === "seller" ? (
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
                    <Col className="stars">
                      {handleRateStars(
                        userTotalInfo?.average_rating,
                        userTotalInfo?.clients_number
                      )}
                    </Col>
                  </Row>
                  <Row>
                    <Col>الخدمات المنشورة</Col>
                    <Col>{userTotalInfo.services_number}</Col>
                  </Row>
                  <Row>
                    <Col>متوسط سرعة الرد</Col>
                    <Col>
                      {userTotalInfo?.average_fast_answer
                        ? userTotalInfo?.average_fast_answer
                        : "لم يحسب بعد"}
                    </Col>
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
