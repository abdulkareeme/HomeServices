import { useState } from "react";
import "./user-avatar.css";
import { ListGroup } from "react-bootstrap";
import { useDispatch, useSelector } from "react-redux";
import {
  setBalance,
  setUserToken,
  setUserTotalInfo,
} from "../../Store/homeServiceSlice";
import { Link, useNavigate } from "react-router-dom";
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
  // handle click out of the element to hide it
  window.onclick = function (event) {
    var userMenu = document.getElementById("user-menu");
    event.target !== userMenu && setShowList(false);
  };

  return (
    <div className="user">
      <div className="image-holder">
        {userTotalInfo?.photo ? (
          <img
            id="user-menu"
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
          <ListGroup.Item key={index} action>
            <Link to={item.link}>
              {item.icon}
              <span className="w-max">{item.label}</span>
            </Link>
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
