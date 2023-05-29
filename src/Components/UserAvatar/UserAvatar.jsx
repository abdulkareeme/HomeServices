import Male from "../../Images/Male.jpg";
import Female from "../../Images/Female.jpg";
import { useState } from "react";
import "./user-avatar.css";
import { ListGroup } from "react-bootstrap";
import { useSelector } from "react-redux";
import { avatarList } from "../../utils/constants";
const UserAvatar = () => {
  const [showList, setShowList] = useState(false);
  const { userTotalInfo } = useSelector((state) => state.homeService);

  return (
    <div className="user">
      <img
        onClick={() => setShowList(!showList)}
        src={userTotalInfo.gender === "Male" ? Male : Female}
        alt=""
      />
      <ListGroup hidden={!showList}>
        <ListGroup.Item action href={`/user/${userTotalInfo.username}`}>
          <ion-icon name="person"></ion-icon>
          <span className="w-max">{userTotalInfo.username}</span>
        </ListGroup.Item>
        {avatarList.map((item, index) => (
          <ListGroup.Item key={index} action href={item.link}>
            {item.icon}
            <span className="w-max">{item.label}</span>
          </ListGroup.Item>
        ))}
      </ListGroup>
    </div>
  );
};

export default UserAvatar;
