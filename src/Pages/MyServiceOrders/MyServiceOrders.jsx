import { Container, Modal, Table } from "react-bootstrap";
import "./my-service-orders.css";
import { myOrderHeader } from "../../utils/constants";
import { useEffect, useState } from "react";
import { deleteFromAPI, fetchFromAPI, postToAPI } from "../../api/FetchFromAPI";
import { useDispatch, useSelector } from "react-redux";
import { setUserToken, setUserTotalInfo } from "../../Store/homeServiceSlice";

const MyServiceOrders = () => {
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
  const [myorderData, setMyOrderData] = useState(null);
  const [show, setShow] = useState(false);
  const [formData, setFormData] = useState(null);

  const handleClose = () => setShow(false);
  const handleShow = (id) => {
    //fetch form data and finaly setShow
    setShow(true);
  };
  const getMyOrderData = async () => {
    try {
      const data = await fetchFromAPI("services/my_orders", {
        headers: {
          Authorization: `token ${userToken}`,
        },
      });
      setMyOrderData(data);
      console.log(data);
    } catch (err) {
      console.log(err);
    }
  };
  const statusObj = {
    Pending: "جاري الطلب",
    "Rejected ": "مرفوض",
    Underway: "جاري التنفيذ",
    "Expire ": "تم الانتهاء بحاجة الى تقييم",
  };
  useEffect(() => {
    getMyOrderData();
  }, []);
  const handleUndo = async (id) => {
    try {
      await deleteFromAPI(`services/cancel_order/${id}`, {
        headers: {
          Authorization: `token ${userToken}`,
        },
      });
    } catch (err) {
      console.log(err);
    }
  };
  return (
    <section className="my-service-orders">
      <Modal show={show} onHide={handleClose}>
        <Modal.Header closeButton>
          <Modal.Title>Modal heading</Modal.Title>
        </Modal.Header>
        <Modal.Body></Modal.Body>
      </Modal>
      <Container>
        <h1>الطلبات المرسلة</h1>
      </Container>
      <Table bordered striped responsive hover size="xl">
        {/* head row */}
        <thead>
          <tr>
            {myOrderHeader.map((item, index) => (
              <th key={index}>{item}</th>
            ))}
          </tr>
        </thead>
        <tbody>
          {/* each tr is row and is obj */}
          {myorderData?.map((item, index) => (
            <tr key={index}>
              <td>{item.id}</td>
              <td>{item.create_date}</td>
              <td>{item.home_service.title}</td>
              <td>{item.home_service.category.name}</td>
              <td>{item.home_service.average_price_per_hour}</td>
              <td>{item.home_service.seller}</td>
              <td>
                <a
                  onClick={() => handleShow(item.id)}
                  className="form-link"
                  href=""
                >
                  اضغط هنا
                </a>
              </td>
              <td>{statusObj[item.status]}</td>
              {item.status === "Pending" ? (
                <td onClick={() => handleUndo(item.id)}>
                  <ion-icon ion-icon name="arrow-undo"></ion-icon>
                </td>
              ) : null}
            </tr>
          ))}
        </tbody>
      </Table>
    </section>
  );
};
export default MyServiceOrders;
