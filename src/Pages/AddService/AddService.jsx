import { ErrorMessage, Formik } from "formik";
import { Fragment, memo, useEffect, useState } from "react";
import * as Yup from "yup";
import CategorySelect from "../../Components/CategorySelect";
import "./add-service.css";
import MultiAreaSelect from "../../Components/MultiAreaSelect";
import { Container } from "react-bootstrap";
import TypeSelect from "../../Components/TypeSelect";
import { postToAPI } from "../../api/FetchFromAPI";
import { useDispatch, useSelector } from "react-redux";
import { setUserToken, setUserTotalInfo } from "../../Store/homeServiceSlice";
import { Toaster, toast } from "react-hot-toast";
import { useNavigate } from "react-router-dom";
import { updateUserTotalInfo } from "../../utils/constants";
import LoaderButton from "../../Components/LoaderButton";
import Cookies from "js-cookie";
const addServicSchema = Yup.object().shape({
  title: Yup.string()
    .required("لم تدخل عنوان الخدمة بعد")
    .matches(
      /^[\u0621-\u064A\s]+$/,
      "أدخل عنوان باللغة العربية ولا يحوي رموز أو أرقام"
    ),
  description: Yup.string()
    .required("لم تدخل وصف الخدمة بعد")
    .matches(
      /^[\u0621-\u064A\s.,!?()-]+$/,
      "أدخل وصف باللغة العربية ولا يحوي رموز أو أرقام"
    )
    .min(10, "الوصف الذي أدخلته قصير جدا")
    .max(500, "الوصف الذي أدخلته كبير جدا"),
  average_price_per_hour: Yup.string().required("لم تدخل سعر الخدمة بعد"),
});
const AddService = () => {
  const { userToken, userTotalInfo } = useSelector(
    (state) => state.homeService
  );
  const dispatch = useDispatch();
  if (userToken === null) {
    const storedToken = Cookies.get("userToken");
    dispatch(setUserToken(JSON.parse(storedToken)));
  }
  if (userTotalInfo === null) {
    const storedUser = Cookies.get("userTotalInfo");
    dispatch(setUserTotalInfo(JSON.parse(storedUser)));
  }
  const history = useNavigate();
  const [isSubmitting, setIsSubmitting] = useState(0);
  const [areasServiceList, setAreasServiceList] = useState([]);
  const [categoryService, setCategoryService] = useState(null);
  const [page, setPage] = useState(0);
  const [formDataList, setFormDataList] = useState([
    {
      id: 1,
      title: "وصف المشكلة",
      field_type: "text",
      note: "",
    },
    {
      id: 2,
      title: "العنوان الحالي",
      field_type: "text",
      note: "",
    },
    {
      id: 3,
      title: "رقم للتواصل",
      field_type: "number",
      note: "",
    },
    {
      id: 4,
      title: "عدد الأيام المتوقعة لإنهاء العمل",
      field_type: "number",
      note: "",
    },
  ]);
  const initialValues = {
    title: "",
    description: "",
    average_price_per_hour: "",
  };
  // protect path from client
  useEffect(() => {
    if (userTotalInfo.mode !== "seller") history(-1);
  }, []);
  const updateFormDataList = (field, value, id) => {
    setFormDataList((prevList) => {
      return prevList.map((item) => {
        if (item.id === id) {
          if (field === "title") return { ...item, title: value };
          else return { ...item, note: value };
        }
        return item;
      });
    });
  };
  const handelDelete = (id) => {
    setFormDataList(formDataList.filter((item) => item.id !== id));
  };
  const submitHandler = async (values) => {
    toast("يتم الآن اضافة الخدمة", {
      duration: 3000,
      position: "top-center",
      ariaProps: {
        role: "status",
        "aria-live": "polite",
      },
    });
    values = {
      ...values,
      category: categoryService,
      service_area: areasServiceList,
      form: formDataList,
    };
    let bearer = `token ${userToken}`;
    try {
      setIsSubmitting(0);
      await postToAPI("services/create_service", values, {
        headers: {
          Authorization: bearer,
        },
      });
      setIsSubmitting(1);
      updateUserTotalInfo(dispatch, userTotalInfo, setUserTotalInfo);
      toast.success("تم اضافة الخدمة بنجاح", {
        duration: 3000,
        position: "top-center",
        ariaProps: {
          role: "status",
          "aria-live": "polite",
        },
      });
      history(`/user/${userTotalInfo.username}`);
    } catch (err) {
      console.log(err);
    }
    console.log(values);
  };
  return (
    <section className="add-service d-flex justify-content-center align-items-center">
      <Toaster />
      <Formik initialValues={initialValues} validationSchema={addServicSchema}>
        {({ values, handleChange, handleBlur, isValid, errors, touched }) => (
          <Container className="d-flex justify-content-center align-items-center">
            <form
              className={`add-service ${page === 1 ? "hidden" : ""}`}
              onSubmit={(e) => e.preventDefault()}
            >
              <h1>أضف خدمة جديدة</h1>
              <div className="title">
                <label>
                  عنوان الخدمة
                  <span>*</span>
                </label>
                <input
                  className={`${
                    touched.title && errors.title ? "error " : null
                  }`}
                  name="title"
                  type="text"
                  onChange={handleChange}
                  onBlur={handleBlur}
                  value={values.title}
                />
                <p>
                  <ErrorMessage name="title" />
                </p>
              </div>
              <div className="category">
                <label>
                  التصنيف
                  <span>*</span>
                </label>
                <CategorySelect setCategoryService={setCategoryService} />
                <p>
                  <ErrorMessage name="password" />
                </p>
              </div>
              <div className="areas">
                <label>
                  المدن التي تستطيع توفير الخدمة فيها
                  <span>*</span>
                </label>
                <MultiAreaSelect setAreasServiceList={setAreasServiceList} />
              </div>
              <div className="desc">
                <label>
                  وصف الخدمة
                  <span>*</span>
                </label>
                <textarea
                  className={`${
                    touched.description && errors.description ? "error " : null
                  }`}
                  name="description"
                  onChange={handleChange}
                  onBlur={handleBlur}
                  id=""
                  rows="9"
                >
                  {values.description}
                </textarea>
                <p>
                  <ErrorMessage name="description" />
                </p>
              </div>
              <div className="price">
                <label>
                  متوسط السعر بالساعة بالليرة السورية
                  <span>*</span>
                </label>
                <input
                  className={`${
                    touched.average_price_per_hour &&
                    errors.average_price_per_hour
                      ? "error "
                      : null
                  }`}
                  name="average_price_per_hour"
                  type="number"
                  onChange={handleChange}
                  onBlur={handleBlur}
                  value={values.average_price_per_hour}
                />
                <p>
                  <ErrorMessage name="average_price_per_hour" />
                </p>
              </div>
              <div
                className={
                  !isValid ||
                  (!touched.title &&
                    !touched.description &&
                    !touched.average_price_per_hour)
                    ? "next disable"
                    : "next"
                }
                onClick={() => {
                  !isValid ||
                  (!touched.title &&
                    !touched.description &&
                    !touched.average_price_per_hour)
                    ? setPage(0)
                    : setPage(1);
                }}
              >
                التالي
              </div>
            </form>
            <form
              onSubmit={(e) => e.preventDefault()}
              className={`add-form ${page === 0 ? "hidden" : ""}`}
            >
              <h1>أضف اسئلة للزبون</h1>
              <p>
                اضافة الاسئلة تساعدك في الحصول على معلومات أكثر دقة من الزبون{" "}
              </p>
              {formDataList.map((item, index) => {
                if (item.id < 5)
                  return (
                    <Fragment>
                      <div className="question">
                        <label> السؤال ونوع الإجابة</label>
                        <div className="d-flex gap-2">
                          <input type="text" readOnly value={item.title} />
                          <TypeSelect
                            type="read"
                            value={item.field_type}
                            setFormDataList={setFormDataList}
                            id={item.id}
                          />
                        </div>
                      </div>
                      {index < formDataList.length - 1 ? <hr /> : null}
                    </Fragment>
                  );
                else
                  return (
                    <Fragment>
                      <div className="question">
                        <div className="d-flex justify-content-between">
                          <label> السؤال ونوع الإجابة</label>
                          <ion-icon
                            name="close"
                            onClick={() => handelDelete(item.id)}
                          ></ion-icon>
                        </div>
                        <div className="d-flex gap-2">
                          <input
                            type="text"
                            onChange={(e) =>
                              updateFormDataList(
                                "title",
                                e.target.value,
                                item.id
                              )
                            }
                          />
                          <TypeSelect
                            type="write"
                            value={item.field_type}
                            setFormDataList={setFormDataList}
                            id={item.id}
                          />
                        </div>
                        <div className="mt-2">
                          <label htmlFor="">أضف ملاحظاتك</label>
                          <textarea
                            onChange={(e) =>
                              updateFormDataList(
                                "note",
                                e.target.value,
                                item.id
                              )
                            }
                            name=""
                            id=""
                            cols="30"
                            rows="3"
                          ></textarea>
                        </div>
                      </div>
                      {index < formDataList.length - 1 ? <hr /> : null}
                    </Fragment>
                  );
              })}
              {formDataList.length < 10 ? (
                <div
                  className="add"
                  type="submit"
                  onClick={() => {
                    setFormDataList([
                      ...formDataList,
                      {
                        id: formDataList.length + 1,
                        title: "",
                        field_type: "",
                        note: "",
                      },
                    ]);
                  }}
                >
                  أضف سؤال للزبون
                </div>
              ) : null}
              <div className="btn-group d-flex justify-content-between mt-4">
                <div className="prev" onClick={() => setPage(0)}>
                  الرجوع
                </div>
                <button
                  hidden={isSubmitting}
                  type="submit"
                  className="submit"
                  onClick={() => submitHandler(values)}
                >
                  أضف الخدمة
                </button>
                <LoaderButton isSubmitting={isSubmitting} color="my-btn" />
              </div>
            </form>
          </Container>
        )}
      </Formik>
    </section>
  );
};

export default memo(AddService);
