import { Col, Container, Modal, Row } from "react-bootstrap";
import { Fragment, memo, useEffect, useLayoutEffect, useState } from "react";
import { fetchFromAPI, putToAPI } from "../../api/FetchFromAPI";
import { useDispatch, useSelector } from "react-redux";
import "./my-recieve-orders.css";
import { setUserToken, setUserTotalInfo } from "../../Store/homeServiceSlice";
import swal from "sweetalert";
import { Toaster, toast } from "react-hot-toast";
import LoaderContent from "../../Components/LoaderContent/LoaderContent";
import Male from "../../Images/Male.jpg";

const MyRecieveOrders = () => {
  const { userTotalInfo, userToken } = useSelector(
    (state) => state.homeService
  );
  const [show, setShow] = useState(false);
  const [selectedform, setSelectedForm] = useState(null);
  const [selectedOrder, setSelectedOrder] = useState(null);

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
  const [underReviewRecieveData, setunderReviewRecieveData] = useState([]);
  const [underwayRecieveData, setunderwayRecieveData] = useState([]);
  const [expireRecieveData, setexpireRecieveData] = useState([]);
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
      setunderReviewRecieveData(
        data.filter((item) => item.status === "Under review")
      );
      setexpireRecieveData(data.filter((item) => item.status === "Expire"));
    } catch (err) {
      console.log(err);
    }
  };
  const handleShowAlert = () => {
    if (selectedOrder.type.includes("reject")) {
      swal({
        title: "هل تريد رفض الطلب؟",
        text: "سيؤدي رفض الطلب إلى إلغاءه. هل أنت متأكد من رغبتك في الاستمرار في عملية الرفض؟",
        icon: "warning",
        buttons: ["إلغاء", "تأكيد"],
        dangerMode: true,
      }).then((willDelete) => {
        if (willDelete) {
          swal("تم الرفض بنجاح", {
            icon: "success",
          });
          selectedOrder.type === "reject"
            ? handleReject(selectedOrder.order.id)
            : handleRejectAfterReview(selectedOrder.order.id);
        }
      });
    } else if (selectedOrder.type.includes("accept")) {
      swal({
        title: "هل تريد قبول الطلب؟",
        text: "سيؤدي قبول الطلب إلى انتقاله الى الحالة التالية. هل أنت متأكد من رغبتك في الاستمرار في عملية القبول ؟",
        icon: "warning",
        buttons: ["إلغاء", "تأكيد"],
        dangerMode: true,
      }).then((willDelete) => {
        if (willDelete) {
          selectedOrder.type === "accept"
            ? handleAccept(selectedOrder.order)
            : handleAcceptAfterReview(selectedOrder.order);
        }
      });
    } else if (selectedOrder.type.includes("finish")) {
      swal({
        title: "هل تريد انجاز الطلب؟",
        text: "سيؤدي ذلك إلى الزام مشتري الخدمة بالتقييم. هل أنت متأكد من رغبتك في الاستمرار في عملية انجاز الطلب ؟",
        icon: "warning",
        buttons: ["إلغاء", "تأكيد"],
        dangerMode: true,
      }).then((willDelete) => {
        if (willDelete) {
          handleFinish(selectedOrder.order);
        }
      });
    }
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
  const handleRejectAfterReview = async (id) => {
    setMyRecieveOrderData(myRecieveorderData.filter((item) => item.id !== id));
    setunderReviewRecieveData(
      underReviewRecieveData.filter((item) => item.id !== id)
    );
    try {
      await putToAPI(`services/reject_after_review/${id}`, null, {
        headers: {
          Authorization: `token ${userToken}`,
        },
      });
    } catch (err) {
      console.log(err);
    }
  };
  const handleAccept = async (order) => {
    swal({
      title: "الرجاء الانتظار بينما يتم قبول الطلب",
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
      setunderReviewRecieveData([...underReviewRecieveData, order]);
      swal("تم القبول بنجاح", {
        icon: "success",
      });
      swal({
        title: "سيتم قبول الطلب تلقائيا بعد 15 دقيقة",
        text: "تأكد من قراءة الفورم المرفق قبل قبول أو رفض الطلب",
        icon: "warning",
        dangerMode: true,
      });
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
  const handleAcceptAfterReview = async (order) => {
    swal({
      title: "الرجاء الانتظار بينما يتم قبول الطلب",
    });
    try {
      const res = await putToAPI(
        `services/accept_after_review/${order.id}`,
        null,
        {
          headers: {
            Authorization: `token ${userToken}`,
          },
        }
      );
      swal("تم القبول بنجاح", {
        icon: "success",
      });
      setunderReviewRecieveData(
        underReviewRecieveData.filter((item) => item.id !== order.id)
      );
      // order.form = res;
      setunderwayRecieveData([...underwayRecieveData, order]);
    } catch (err) {
      console.log(err);
    }
  };
  const handleFinish = async (order) => {
    swal({
      title: "الرجاء الانتظار بينما يتم عملية انجاز الطلب",
    });
    try {
      await putToAPI(`services/finish_order/${order.id}`, null, {
        headers: {
          Authorization: `token ${userToken}`,
        },
      });
      setunderwayRecieveData(
        underwayRecieveData.filter((item) => item.id !== order.id)
      );
      setexpireRecieveData([...expireRecieveData, order]);
      swal("تم انجاز الطلب بنجاح", {
        icon: "success",
      });
    } catch (err) {
      console.log(err);
    }
  };
  // to fire function after state update
  useLayoutEffect(() => {
    if (selectedOrder) {
      handleShowAlert();
    }
  }, [selectedOrder]);
  useEffect(() => {
    setSelectedOrder(null);
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
        {!myRecieveorderData ? <LoaderContent /> : null}
        {myRecieveorderData?.length === 0 ? (
          <div className="message"> لا يوجد طلبات واردة</div>
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
                        <div className="image-holder mt-4">
                          <img src={order.photo ? order.photo : Male} alt="" />
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
                            onClick={() => {
                              setSelectedOrder({
                                order: order,
                                type: "accept",
                              });
                            }}
                            // onClick={() => handleAccept(order)}
                            name="checkmark"
                          ></ion-icon>
                          <ion-icon
                            className="reject"
                            onClick={() => {
                              setSelectedOrder({
                                order: order,
                                type: "reject",
                              });
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
              <div className="message">لا يوجد طلبات بحاجة لموافقة أو رفض</div>
            )}
            <h1 className="mt-5">طلبات قيد المراجعة</h1>
            {underReviewRecieveData?.length > 0 ? (
              <Row className="under-review d-flex justify-content-center gap-2">
                {underReviewRecieveData?.map((order) => (
                  <Col lg={4} md={5} xs={10} key={order.id}>
                    <div className="card my-3 bg-white shadow-sm border-0 rounded">
                      <div className="card-body d-flex flex-column justify-content-between align-items-center gap-2">
                        <div className="image-holder mt-4 mt-4">
                          <img src={order.photo ? order.photo : Male} alt="" />
                        </div>
                        <div className="d-flex text-center flex-column gap-2">
                          <h5 className="m-0">{order.client}</h5>
                          <div>{order.home_service.title}</div>
                          <div className="text-muted">
                            {order.home_service.category.name}
                          </div>
                        </div>
                        <div className="d-flex justify-content-center align-items-center">
                          <span
                            onClick={() => {
                              setSelectedForm(order.form);
                              setShow(true);
                            }}
                            className="form-link"
                          >
                            الفورم المرفق
                          </span>
                        </div>
                        <div className="d-flex justify-content-end align-items-center gap-3 mt-3">
                          <ion-icon
                            className="accept"
                            onClick={() => {
                              setSelectedOrder({
                                order: order,
                                type: "acceptAfterReview",
                              });
                            }}
                            name="checkmark"
                          ></ion-icon>
                          <ion-icon
                            className="reject"
                            onClick={() => {
                              setSelectedOrder({
                                order: order,
                                type: "rejectAfterReview",
                              });
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
              <div className="message">لا يوجد طلبات قيد المراجعة</div>
            )}
            <h1 className="mt-5">طلبات قيد التنفيذ</h1>
            {underwayRecieveData?.length > 0 ? (
              <Row className="underway d-flex justify-content-center gap-2">
                {underwayRecieveData?.map((order) => (
                  <Col lg={4} md={5} xs={10} key={order.id}>
                    <div className="card my-3 bg-white shadow-sm border-0 rounded">
                      <div className="card-body d-flex flex-column justify-content-between align-items-center gap-2">
                        <div className="image-holder mt-4 mt-4">
                          <img src={order.photo ? order.photo : Male} alt="" />
                        </div>
                        <div className="d-flex text-center flex-column gap-2">
                          <h5 className="m-0">{order.client}</h5>
                          <div>{order.home_service.title}</div>
                          <div className="text-muted">
                            {order.home_service.category.name}
                          </div>
                        </div>
                        <div className="d-flex flex-column gap-2 justify-content-center align-items-center">
                          <div className="d-flex justify-content-center align-items-center">
                            <span
                              onClick={() => {
                                setSelectedForm(order.form);
                                setShow(true);
                              }}
                              className="form-link"
                            >
                              الفورم المرفق
                            </span>
                          </div>
                          <button
                            onClick={() => {
                              setSelectedOrder({
                                order: order,
                                type: "finish",
                              });
                            }}
                            className="done d-flex align-items-center gap-2"
                          >
                            تم انجاز الطلب
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
              <div className="message">لا يوجد طلبات قيد التنفيذ</div>
            )}
            <h1 className="mt-5">طلبات تم الانتهاء منها</h1>
            {expireRecieveData?.length > 0 ? (
              <Row className="expire d-flex justify-content-center gap-2">
                {expireRecieveData?.map((order) => (
                  <Col lg={4} md={5} xs={10} key={order.id}>
                    <div className="card my-3 bg-white shadow-sm border-0 rounded">
                      <div className="card-body d-flex flex-column justify-content-between align-items-center gap-2">
                        <div className="image-holder mt-4 mt-4">
                          <img src={order.photo ? order.photo : Male} alt="" />
                        </div>
                        <div className="d-flex text-center flex-column gap-2">
                          <h5 className="m-0">{order.client}</h5>
                          <div>{order.home_service.title}</div>
                          <div className="text-muted">
                            {order.home_service.category.name}
                          </div>
                        </div>
                        <div className="d-flex flex-column gap-2 justify-content-center align-items-center">
                          <div className="d-flex justify-content-center align-items-center">
                            <span
                              onClick={() => {
                                setSelectedForm(order.form);
                                setShow(true);
                              }}
                              className="form-link"
                            >
                              الفورم المرفق
                            </span>
                          </div>
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
              <div className="message">لا يوجد طلبات تم الانتهاء منها</div>
            )}
          </Fragment>
        ) : null}
      </Container>
    </section>
  );
};
export default memo(MyRecieveOrders);
