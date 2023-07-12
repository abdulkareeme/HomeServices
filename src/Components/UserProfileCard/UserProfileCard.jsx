import { Container, Row } from "react-bootstrap";
import { useDispatch, useSelector } from "react-redux";
import "./user-profile-card.css";
import moment from "moment/moment";
import { Link, useParams } from "react-router-dom";
import {
  setIsSelected,
  setSelectedUser,
  setUserTotalInfo,
} from "../../Store/homeServiceSlice";
import { useEffect } from "react";
import { fetchFromAPI } from "../../api/FetchFromAPI";
import LoaderContent from "../LoaderContent/LoaderContent";
import Cookies from "js-cookie";
const UserProfileCard = () => {
  const { userTotalInfo, isSelected, selectedUser } = useSelector(
    (state) => state.homeService
  );
  const dispatch = useDispatch();
  const { username } = useParams();
  if (userTotalInfo === null) {
    const storedUser = Cookies.get("userTotalInfo");
    dispatch(setUserTotalInfo(JSON.parse(storedUser)));
  }
  const getUserPageInfo = async () => {
    if (userTotalInfo?.username !== username) {
      try {
        const data = await fetchFromAPI(`api/user/${username}`);
        dispatch(setSelectedUser(data));
      } catch (err) {
        console.log(err);
      }
    } else {
      dispatch(setSelectedUser(userTotalInfo));
    }
  };
  useEffect(() => {
    getUserPageInfo();
    // Cookies.add
  }, [username]);
  const sellerProfileLinks = [
    {
      id: 1,
      label: "ألملف الشخصي",
      icon: <ion-icon name="person"></ion-icon>,
      link: `/user/${selectedUser?.username}`,
    },
    {
      id: 2,
      label: "الخدمات",
      icon: <ion-icon name="home"></ion-icon>,
      link: `/user/${selectedUser?.username}/services`,
    },
    {
      id: 3,
      label: "التقييمات",
      icon: <ion-icon name="star"></ion-icon>,
      link: `/user/${selectedUser?.username}/rates`,
    },
  ];
  return (
    <div className="user-profile-card">
      <Container>
        {!selectedUser ? (
          <LoaderContent />
        ) : (
          <Row>
            <div className="image-holder">
              {selectedUser?.photo ? (
                <img src={selectedUser?.photo} alt="profile" />
              ) : (
                <div className="image-skelton"></div>
              )}
            </div>
            <h2>
              <span>
                {selectedUser?.first_name} {selectedUser?.last_name}
              </span>
              {selectedUser?.username === userTotalInfo?.username ? (
                <span className="green-circle"></span>
              ) : null}
            </h2>
            <div className="mode">
              <ion-icon name="person"></ion-icon>
              {selectedUser?.mode === "seller" ? "بائع" : "مستخدم"}
            </div>
            <div>
              <span>
                <ion-icon name="location"></ion-icon>
                متواجد في
              </span>
              {selectedUser?.area_name}
            </div>
            <div>
              <span>
                <ion-icon name="calendar"></ion-icon>
                تاريخ التسجيل
              </span>
              {moment(selectedUser?.date_joined).format("DD/MM/YYYY")}
            </div>
            {selectedUser?.username === userTotalInfo?.username ? (
              <Link to={`/user/${userTotalInfo?.username}/update_profile`}>
                <ion-icon name="create"></ion-icon>
                <span>تعديل الملف الشخصي</span>
              </Link>
            ) : null}
            {selectedUser?.mode === "seller" ? (
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
        )}
      </Container>
    </div>
  );
};

export default UserProfileCard;
