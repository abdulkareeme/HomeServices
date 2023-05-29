import Male from "../../Images/Male.jpg";
import Female from "../../Images/Female.jpg";
import { Container, Row } from "react-bootstrap";
import { useDispatch, useSelector } from "react-redux";
import "./user-profile-card.css";
import moment from "moment/moment";
import { Link } from "react-router-dom";
import { setIsSelected } from "../../Store/homeServiceSlice";
const UserProfileCard = () => {
  const { userTotalInfo, isSelected } = useSelector(
    (state) => state.homeService
  );
  const dispatch = useDispatch();
  const sellerProfileLinks = [
    {
      id: 1,
      label: "ألملف الشخصي",
      icon: <ion-icon name="person"></ion-icon>,
      link: `/user/${userTotalInfo.username}`,
    },
    {
      id: 2,
      label: "الخدمات",
      icon: <ion-icon name="home"></ion-icon>,
      link: `/user/${userTotalInfo.username}/services`,
    },
    {
      id: 3,
      label: "التقييمات",
      icon: <ion-icon name="star"></ion-icon>,
      link: `/user/${userTotalInfo.username}/rates`,
    },
  ];
  return (
    <div className="user-profile-card">
      <Container>
        <Row>
          <img src={userTotalInfo.gender === "Male" ? Male : Female} alt="" />
          <h2>
            <span>
              {userTotalInfo.first_name} {userTotalInfo.last_name}
            </span>
            <span className="green-circle"></span>
          </h2>
          <div className="mode">
            <ion-icon name="person"></ion-icon>
            {userTotalInfo.mode === "seller" ? "بائع" : "مستخدم"}
          </div>
          <div>
            <span>
              <ion-icon name="location"></ion-icon>
              متواجد في
            </span>
            {userTotalInfo.area}
          </div>
          <div>
            <span>
              <ion-icon name="calendar"></ion-icon>
              تاريخ التسجيل
            </span>
            {moment(userTotalInfo.date_joined).format("DD/MM/YYYY")}
          </div>
          <Link>
            <ion-icon name="create"></ion-icon>
            <span>تعديل الملف الشخصي</span>
          </Link>
          {userTotalInfo.mode === "seller" ? (
            <ul>
              {sellerProfileLinks.map((item) => (
                <Link
                  to={item.link}
                  className={isSelected === item.id ? "active" : ""}
                  key={item.id}
                  onClick={() => dispatch(setIsSelected(item.id))}
                >
                  {item.icon}
                  <span>{item.label}</span>
                </Link>
              ))}
            </ul>
          ) : null}
        </Row>
      </Container>
    </div>
  );
};

export default UserProfileCard;
