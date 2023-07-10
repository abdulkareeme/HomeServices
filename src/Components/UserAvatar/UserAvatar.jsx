import { useState } from "react";
import "./user-avatar.css";
import { ListGroup } from "react-bootstrap";
import { useDispatch, useSelector } from "react-redux";
import { setUserToken, setUserTotalInfo } from "../../Store/homeServiceSlice";
import { useNavigate } from "react-router-dom";
import { postToAPI } from "../../api/FetchFromAPI";
import { toast } from "react-hot-toast";
const UserAvatar = () => {
  const [showList, setShowList] = useState(false);
  const dispatch = useDispatch();
  const history = useNavigate();
  const { userTotalInfo, userToken } = useSelector(
    (state) => state.homeService
  );
  if (userTotalInfo === null) {
    const storedUser = localStorage.getItem("userTotalInfo");
    dispatch(setUserTotalInfo(JSON.parse(storedUser)));
  }
  if (userToken === null) {
    const storedToken = localStorage.getItem("userToken");
    dispatch(setUserToken(JSON.parse(storedToken)));
  }
  const avatarList = [
    {
      label: userTotalInfo?.username,
      icon: <ion-icon name="person"></ion-icon>,
      link: `/user/${userTotalInfo?.username}`,
    },
    {
      label: "الرصيد",
      icon: <ion-icon name="cash-outline"></ion-icon>,
      link: `/user/${userTotalInfo?.username}/balance`,
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
      localStorage.setItem("userTotalInfo", null);
      localStorage.setItem("userToken", null);
      dispatch(setUserTotalInfo(null));
      dispatch(setUserToken(null));
    });
  };

  return (
    <div className="user">
      <img
        onClick={() => setShowList(!showList)}
        src={userTotalInfo?.photo}
        alt="profile"
      />
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
