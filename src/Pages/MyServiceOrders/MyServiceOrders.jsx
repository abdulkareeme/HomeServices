import { Col, Container, Modal, Row } from "react-bootstrap";
import "./my-service-orders.css";
import { Fragment, useEffect, useLayoutEffect, useState } from "react";
import { deleteFromAPI, fetchFromAPI, postToAPI } from "../../api/FetchFromAPI";
import { useDispatch, useSelector } from "react-redux";
import { setUserToken, setUserTotalInfo } from "../../Store/homeServiceSlice";
import swal from "sweetalert";
import LoaderContent from "../../Components/LoaderContent/LoaderContent";
import { BASE_API_URL, getStatus } from "../../utils/constants";
import RatingStars from "../../Components/RatingStars/RatingStars";
import { toast } from "react-hot-toast";
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
  const [showRateModal, setShowRateModal] = useState(false);
  const [selectedform, setSelectedForm] = useState(null);
  const [selectedRate, setSelectedRate] = useState(null);
  const [selectedOrderId, setSelectedOrderId] = useState(null);
  const [qualityStars, setQualityStars] = useState(null);
  const [deadlineStars, setDeadlineStars] = useState(null);
  const [ethicalStars, setEthicalStars] = useState(null);
  const [rateComment, setRateComment] = useState(null);
  const formDetails = selectedform?.map((item, index) => (
    <div key={index} className="question">
      <label htmlFor="">{item.field.title}</label>
      <input value={item.content} readOnly type={item.field.field_type} />
      {item.field.note.length > 0 ? <p>{item.field.note}</p> : null}
    </div>
  ));

  const handleClose = () => setShow(false);
  const handleCloseRateModal = () => setShowRateModal(false);
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
  const makeRate = async (id) => {
    const payload = {
      quality_of_service: qualityStars,
      commitment_to_deadline: deadlineStars,
      work_ethics: ethicalStars,
      client_comment: rateComment,
    };
    try {
      toast("يتم الآن اضافة التقييم", {
        duration: 3000,
        position: "top-center",
        ariaProps: {
          role: "status",
          "aria-live": "polite",
        },
      });
      await postToAPI(`services/make_rating/${id}`, payload, {
        headers: {
          Authorization: `token ${userToken}`,
        },
      });
      toast.success("تم اضافة التقييم بنجاح", {
        duration: 3000,
        position: "top-center",
        ariaProps: {
          role: "status",
          "aria-live": "polite",
        },
      });
    } catch (err) {
      if (err.responce.data?.detail === "You have already rated this service") {
        toast.wrong("لقد قمت مسبقا باضافة تقييم", {
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
  useEffect(() => {
    getMyOrderData();
  }, []);
  // to fire function after state update
  useLayoutEffect(() => {
    if (selectedOrderId) {
      handelShowAlert();
    }
  }, [selectedOrderId]);
  const handelShowAlert = async () => {
    setSelectedOrderId(null);
    console.log(selectedOrderId);
    swal({
      title: "الغاء الطلب",
      text: "هل أنت متأكد من رغبتك في الغاء الطلب؟",
      icon: "warning",
      buttons: ["إلغاء", "تأكيد"],
      dangerMode: true,
    }).then((willDelete) => {
      if (willDelete) {
        handleUndo();
      }
    });
  };
  const handleUndo = async () => {
    console.log(selectedOrderId);
    swal({
      title: "يتم الآن الغاء الخدمة",
    });
    try {
      await deleteFromAPI(`services/cancel_order/${selectedOrderId}`, {
        headers: {
          Authorization: `token ${userToken}`,
        },
      });
      setMyOrderData(myorderData.filter((item) => item.id !== selectedOrderId));
      swal("تم الإلغاء بنجاح", {
        icon: "success",
      });
    } catch (err) {
      console.log(err);
    }
  };
  return (
    <section className="my-service-orders">
      <Modal show={show} onHide={handleClose}>
        <Modal.Header closeButton>
          <Modal.Title>الفورم المرفق</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <form action="">{formDetails}</form>
        </Modal.Body>
      </Modal>
      <Modal show={showRateModal} onHide={handleCloseRateModal}>
        <Modal.Header closeButton>
          <Modal.Title>أضف تقييم للخدمة</Modal.Title>
        </Modal.Header>
        <Modal.Body className="rate">
          <Row className="d-flex justify-content-between">
            <h6 className="w-max">جودة الخدمة</h6>
            <RatingStars setValue={setQualityStars} />
          </Row>
          <Row className="d-flex justify-content-between my-3">
            <h6 className="w-max">التسليم بالموعد</h6>
            <RatingStars setValue={setDeadlineStars} />
          </Row>
          <Row className="d-flex justify-content-between">
            <h6 className="w-max">أخلاقيات العمل</h6>
            <RatingStars setValue={setEthicalStars} />
          </Row>
          <Row className="mt-3 d-flex align-items-center gap-2 px-2">
            <input
              placeholder="أضف تعليق على الخدمة"
              type="text"
              onChange={(e) => setRateComment(e.target.value)}
            />
            <button
              onClick={() => makeRate(selectedRate)}
              className="my-btn add-rate"
            >
              اضافة
            </button>
          </Row>
        </Modal.Body>
      </Modal>
      <Container>
        {!myorderData ? <LoaderContent /> : null}
        {myorderData?.length === 0 ? (
          <div className="message"> لا يوجد طلبات مرسلة</div>
        ) : null}
        {myorderData?.length > 0 ? (
          <Fragment>
            <h1>الطلبات المرسلة</h1>
            <Row className="d-flex justify-content-center gap-2">
              {myorderData?.map((order) => (
                <Col lg={3} md={4} xs={10} key={order.id}>
                  <div className="card my-3 bg-white shadow-sm border-0 rounded">
                    <div className="card-body d-flex flex-column justify-content-between align-items-center gap-2">
                      <div className="image-holder mt-4">
                        <img src={BASE_API_URL + order?.photo} alt="" />
                      </div>
                      <div className="d-flex text-center flex-column gap-2">
                        <h5 className="m-0">{order.home_service.seller}</h5>
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
                      {getStatus(
                        order.id,
                        order.status,
                        order.is_rateable,
                        setSelectedRate,
                        setShowRateModal
                      )}
                      <div className="d-flex flex-column align-items-end gap-4">
                        <div className="date text-muted w-max">
                          {order?.create_date}
                        </div>
                        {order.status === "Pending" ? (
                          <button
                            onClick={() => {
                              setSelectedOrderId(order.id);
                            }}
                            className="my-btn d-flex gap-2 align-items-center"
                          >
                            تراجع
                            <ion-icon ion-icon name="arrow-undo"></ion-icon>
                          </button>
                        ) : null}
                      </div>
                    </div>
                  </div>
                </Col>
              ))}
            </Row>
          </Fragment>
        ) : null}
      </Container>
    </section>
  );
};
export default MyServiceOrders;
