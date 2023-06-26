import { Button, Col, Container, Modal, Row, Table } from "react-bootstrap";
import { myOrderHeader, myReciveOrderHeader } from "../../utils/constants";
import { Fragment, memo, useEffect, useLayoutEffect, useState } from "react";
import { fetchFromAPI, putToAPI } from "../../api/FetchFromAPI";
import { useDispatch, useSelector } from "react-redux";
import "./my-recieve-orders.css";
import { setUserToken, setUserTotalInfo } from "../../Store/homeServiceSlice";
import swal from "sweetalert";
import { Toaster, toast } from "react-hot-toast";
// import Male from "../../Images/Male.jpg";
const MyRecieveOrders = () => {
  const { userTotalInfo, userToken } = useSelector(
    (state) => state.homeService
  );
  const [show, setShow] = useState(false);
  const [selectedform, setSelectedForm] = useState(null);
  const [selectedOrderId, setSelectedOrderId] = useState(null);

  const handleClose = () => setShow(false);

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
  const [pendingRecieveData, setPendingRecieveData] = useState([]);
  const [underwayRecieveData, setunderwayRecieveData] = useState([]);
  const formDetails = selectedform?.map((item, index) => (
    <div key={index} className="question">
      <label htmlFor="">{item.field.title}</label>
      <input value={item.content} readOnly type={item.field.field_type} />
      {item.field.note.length > 0 ? <p>{item.field.note}</p> : null}
    </div>
  ));
  const getMyRecieveOrderData = async () => {
    try {
      const data = await fetchFromAPI("services/received_orders", {
        headers: {
          Authorization: `token ${userToken}`,
        },
      });
      console.log(data);
      setMyRecieveOrderData(data);
      setPendingRecieveData(data.filter((item) => item.status === "Pending"));
      setunderwayRecieveData(data.filter((item) => item.status === "Underway"));
    } catch (err) {
      console.log(err);
    }
  };
  const handelShowAlert = () => {
    swal({
      title: "هل تريد رفض الطلب؟",
      text: "سيؤدي رفض الطلب إلى إلغاءه. هل أنت متأكد من رغبتك في الاستمرار في عملية الرفض؟",
      icon: "warning",
      buttons: ["إلغاء", "تأكيد"],
      dangerMode: true,
    }).then((willDelete) => {
      if (willDelete) {
        handleAlertConfirm();
      }
    });
  };
  const handleAlertConfirm = async () => {
    swal("تم الرفض بنجاح", {
      icon: "success",
    });
    handleReject(selectedOrderId);
  };
  const handleReject = async (id) => {
    setMyRecieveOrderData(myRecieveorderData.filter((item) => item.id !== id));
    setPendingRecieveData(pendingRecieveData.filter((item) => item.id !== id));
    try {
      await putToAPI(`services/reject_order/${id}`, null, {
        headers: {
          Authorization: `token ${userToken}`,
        },
      });
    } catch (err) {
      console.log(err);
    }
  };
  const handleAccept = async (order) => {
    toast("الرجاء الانتظار بينما يتم قبول الطلب", {
      duration: 3000,
      position: "top-center",
      ariaProps: {
        role: "status",
        "aria-live": "polite",
      },
    });
    try {
      const res = await putToAPI(`services/accept_order/${order.id}`, null, {
        headers: {
          Authorization: `token ${userToken}`,
        },
      });
      setPendingRecieveData(
        pendingRecieveData.filter((item) => item.id !== order.id)
      );
      order.form = res;
      setunderwayRecieveData([...underwayRecieveData, order]);
    } catch (err) {
      if (err.response.data?.detail === "You don't have enough money") {
        toast.error("ليس لديك رصيد كافي لقيول الطلب", {
          duration: 3000,
          position: "top-center",
          ariaProps: {
            role: "status",
            "aria-live": "polite",
          },
        });
      }
      console.log(err);
    }
  };

  // to fire function after state update
  useLayoutEffect(() => {
    if (selectedOrderId) {
      handelShowAlert();
    }
  }, [selectedOrderId]);
  useEffect(() => {
    getMyRecieveOrderData();
  }, []);
  return (
    <section className="my-recieve-orders">
      <Toaster />
      <Modal show={show} onHide={handleClose}>
        <Modal.Header closeButton>
          <Modal.Title className="mb-5">الفورم المرفق</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <form action="">{formDetails}</form>
        </Modal.Body>
      </Modal>
      <Container>
        {!myRecieveorderData ? <div className="loader">يتم التحميل</div> : null}
        {myRecieveorderData?.length === 0 ? (
          <div className="loader"> لا يوجد طلبات واردة</div>
        ) : null}
        {myRecieveorderData?.length > 0 ? (
          <Fragment>
            <h1>الطلبات الواردة</h1>
            {pendingRecieveData?.length > 0 ? (
              <Row className="pending d-flex justify-content-center gap-2">
                {pendingRecieveData?.map((order) => (
                  <Col lg={4} md={5} xs={10} key={order.id}>
                    <div className="card my-3 bg-white shadow-sm border-0 rounded">
                      <div className="card-body d-flex flex-column justify-content-between align-items-center gap-2">
                        <div className="image-holder">
                          <img src={order.photo} alt="" />
                        </div>
                        <div className="d-flex text-center flex-column gap-2">
                          <h5 className="m-0">{order.client}</h5>
                          <div>{order.home_service.title}</div>
                          <div className="text-muted">
                            {order.home_service.category.name}
                          </div>
                        </div>
                        <div className="d-flex justify-content-end align-items-center gap-3 mt-3">
                          <ion-icon
                            className="accept"
                            onClick={() => handleAccept(order)}
                            name="checkmark"
                          ></ion-icon>
                          <ion-icon
                            className="reject"
                            onClick={() => {
                              setSelectedOrderId(order.id);
                            }}
                            name="close"
                          ></ion-icon>
                        </div>
                      </div>
                      <div className="date text-muted w-max">
                        {order.create_date}
                      </div>
                    </div>
                  </Col>
                ))}
              </Row>
            ) : (
              <div className="loader">لا يوجد طلبات بحاجة لموافقة أو رفض</div>
            )}
            <h1 className="mt-5">طلبات قيد التنفيذ</h1>
            {underwayRecieveData?.length > 0 ? (
              <Row className="underway d-flex justify-content-center gap-2">
                {underwayRecieveData?.map((order) => (
                  <Col lg={4} md={5} xs={10} key={order.id}>
                    <div className="card my-3 bg-white shadow-sm border-0 rounded">
                      <div className="card-body d-flex flex-column justify-content-between align-items-center gap-2">
                        <div className="image-holder mt-4">
                          <img src={order.photo} alt="" />
                        </div>
                        <div className="d-flex text-center flex-column gap-2">
                          <h5 className="m-0">{order.client}</h5>
                          <div>{order.home_service.title}</div>
                          <div className="text-muted">
                            {order.home_service.category.name}
                          </div>
                        </div>
                        <div className="d-flex flex-column gap-2 justify-content-center align-items-center">
                          <button
                            onClick={() => {
                              setSelectedForm(order.form);
                              setShow(true);
                            }}
                            className="my-btn"
                          >
                            الفورم المرفق
                          </button>
                          <button className="done d-flex align-items-center gap-2">
                            تم انجاز الخدمة
                            <ion-icon
                              className="accept"
                              name="checkmark"
                            ></ion-icon>
                          </button>
                        </div>
                      </div>
                      <div className="date text-muted w-max">
                        {order.create_date}
                      </div>
                    </div>
                  </Col>
                ))}
              </Row>
            ) : (
              <div className="loader">لا يوجد طلبات قيد التنفيذ</div>
            )}
          </Fragment>
        ) : null}
      </Container>
    </section>
  );
};
export default memo(MyRecieveOrders);
