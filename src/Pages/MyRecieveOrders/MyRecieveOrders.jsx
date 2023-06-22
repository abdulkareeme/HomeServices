import { Container, Table } from "react-bootstrap";
import { myOrderHeader, myReciveOrderHeader } from "../../utils/constants";
import { useEffect, useState } from "react";
import { fetchFromAPI, putToAPI } from "../../api/FetchFromAPI";
import { useDispatch, useSelector } from "react-redux";
import "./my-recieve-orders.css";
import { setUserToken, setUserTotalInfo } from "../../Store/homeServiceSlice";
const MyRecieveOrders = () => {
  const { userTotalInfo, userToken } = useSelector(
    (state) => state.homeService
  );

  const dispatch = useDispatch();
  if (userToken === null) {
    const storedToken = localStorage.getItem("userToken");
    dispatch(setUserToken(JSON.parse(storedToken)));
  }
  if (userTotalInfo === null) {
    const storedUser = localStorage.getItem("userTotalInfo");
    dispatch(setUserTotalInfo(JSON.parse(storedUser)));
  }
  const [myRecieveorderData, setMyRecieveOrderData] = useState(null);
  const getMyRecieveOrderData = async () => {
    try {
      const data = await fetchFromAPI("services/received_orders", {
        headers: {
          Authorization: `token ${userToken}`,
        },
      });
      setMyRecieveOrderData(data);
    } catch (err) {
      console.log(err);
    }
  };
  useEffect(() => {
    getMyRecieveOrderData();
  }, []);
  const handleReject = async (id) => {
    try {
      const data = await putToAPI(`services/reject_order/${id}`, {
        headers: {
          Authorization: `token ${userToken}`,
        },
      });
      setMyRecieveOrderData(data);
    } catch (err) {
      console.log(err);
    }
  };
  return (
    <section className="my-recieve-orders">
      <Container>
        <h1>الطلبات الواردة</h1>
      </Container>
      <Table bordered striped responsive hover size="lg">
        {/* head row */}
        <thead>
          <tr>
            {myReciveOrderHeader.map((item, index) => (
              <th key={index}>{item}</th>
            ))}
          </tr>
        </thead>
        <tbody>
          {/* each tr is row and is obj */}
          {myRecieveorderData?.map((item, index) => (
            <tr key={index}>
              <td>{item.id}</td>
              <td>{item.create_date}</td>
              <td>{item.home_service.title}</td>
              <td>{item.home_service.category.name}</td>
              <td>{item.home_service.average_price_per_hour}</td>
              <td>{item.client}</td>
              <td>
                <a className="form-link" href="">
                  اضغط هنا
                </a>
              </td>
              <td>
                <ion-icon name="checkmark"></ion-icon>
              </td>
              <td>
                <ion-icon
                  onClick={() => handleReject(item.id)}
                  name="close"
                ></ion-icon>
              </td>
            </tr>
          ))}
        </tbody>
      </Table>
    </section>
  );
};
export default MyRecieveOrders;
