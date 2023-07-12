import { useState } from "react";
import "./user-avatar.css";
import { ListGroup } from "react-bootstrap";
import { useDispatch, useSelector } from "react-redux";
import {
  setBalance,
  setUserToken,
  setUserTotalInfo,
} from "../../Store/homeServiceSlice";
import { useNavigate } from "react-router-dom";
import { postToAPI } from "../../api/FetchFromAPI";
import { toast } from "react-hot-toast";
import Cookies from "js-cookie";
const UserAvatar = () => {
  const [showList, setShowList] = useState(false);
  const dispatch = useDispatch();
  const history = useNavigate();
  const { userTotalInfo, userToken, balance } = useSelector(
    (state) => state.homeService
  );
  if (userTotalInfo === null) {
    const storedUser = Cookies.get("userTotalInfo");
    dispatch(setUserTotalInfo(JSON.parse(storedUser)));
  }
  if (userToken === null) {
    const storedToken = Cookies.get("userToken");
    dispatch(setUserToken(JSON.parse(storedToken)));
  }
  balance === null && dispatch(setBalance(Cookies.get("balance")));
  const avatarList = [
    {
      label: userTotalInfo?.username,
      icon: <ion-icon name="person"></ion-icon>,
      link: `/user/${userTotalInfo?.username}`,
    },
    {
      label: "تعديل الحساب",
      icon: <ion-icon name="create-outline"></ion-icon>,
      link: `/user/${userTotalInfo?.username}/update_profile`,
    },
  ];
  const handleLogout = () => {
    toast("يتم الآن تسجيل الخروج", {
      duration: 3000,
      position: "top-center",
      ariaProps: {
        role: "status",
        "aria-live": "polite",
      },
    });
    let bearer = `token ${userToken}`;
    postToAPI("api/logout/", null, {
      headers: {
        Authorization: bearer,
      },
    }).then(() => {
      history("/");
      Cookies.remove("userTotalInfo");
      Cookies.remove("userToken");
      Cookies.remove("balance");
      dispatch(setUserTotalInfo(null));
      dispatch(setUserToken(null));
    });
  };

  return (
    <div className="user">
      <div className="image-holder">
        {userTotalInfo?.photo ? (
          <img
            onClick={() => setShowList(!showList)}
            src={userTotalInfo?.photo}
            alt="profile"
          />
        ) : (
          <div className="image-skelton"></div>
        )}
      </div>
      <ListGroup hidden={!showList}>
        {avatarList.map((item, index) => (
          <ListGroup.Item
            onClick={() => setShowList(false)}
            key={index}
            action
            href={item.link}
          >
            {item.icon}
            <span className="w-max">{item.label}</span>
          </ListGroup.Item>
        ))}
        {userTotalInfo.mode === "seller" ? (
          <ListGroup.Item action>
            <ion-icon name="cash-outline"></ion-icon>
            <div className="d-flex gap-1 align-items-center">
              <span>{balance}</span>
              <span>نقطة</span>
            </div>
          </ListGroup.Item>
        ) : null}
        <ListGroup.Item
          action
          onClick={() => {
            setShowList(false);
            handleLogout();
          }}
        >
          <ion-icon name="log-out-outline"></ion-icon>
          <span className="w-max">تسجيل الخروج</span>
        </ListGroup.Item>
      </ListGroup>
    </div>
  );
};

export default UserAvatar;
