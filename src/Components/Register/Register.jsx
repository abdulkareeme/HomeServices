import { ErrorMessage, Formik } from "formik";
import { Fragment, useState } from "react";
import * as Yup from "yup";
import { Link, useNavigate } from "react-router-dom";
import "./register.css";
import { Form } from "react-bootstrap";
import DatePicker from "react-date-picker";
import { format } from "date-fns";
import { fetchFromAPI, postToAPI } from "../../api/FetchFromAPI";
const SignInSchema = Yup.object().shape({
  first_name: Yup.string()
    .required("لم تدخل اسمك بعد")
    .min(3, "الاسم الذي أدخلته قصير جداً. 3 أحرف هو الحد الأدنى")
    .max(15, "الاسم الذي أدخلته كبير جداً. 15 أحرف هو الحد الأقصى"),
  last_name: Yup.string()
    .required("لم تدخل اسم العائلة بعد")
    .min(3, "اسم العائلة الذي أدخلته قصير جداً. 3 أحرف هو الحد الأدنى")
    .max(15, "اسم العائلة الذي أدخلته كبير جداً. 15 أحرف هو الحد الأقصى"),
  email: Yup.string()
    .email("أدخل بريد الكتروني صالح")
    .required("لم تدخل بريدك الالكتروني بعد"),
  password: Yup.string()
    .required("لم تدخل كلمة مرور بعد")
    .min(8, "كلمة السر التي أدخلتها قصيرة جداً. 8 أحرف هو الحد الأدنى")
    .matches(
      /^[A-Za-z\d@$!%*#?&]{8,60}$/,
      " كلمة السر يجب أن تحتوي على 8 إلى 60 محرف بالانكليزية"
    ),
  password2: Yup.string()
    .oneOf([Yup.ref("password"), null], "كلمة السر غير مطابقة")
    .required("لم تدخل تأكيد كلمة السر"),
});

const Register = () => {
  // const history = useNavigate();
  const [page, setPage] = useState(0);
  const [dateValue, setDateValue] = useState(new Date());
  const [mode, setMode] = useState(null);
  const [gender, setGender] = useState(null);
  const [listOfAreas, setListOfAreas] = useState(null);
  const [isPasswordVisible, setPasswordVisible] = useState(false);
  const [isPasswordVisible2, setPasswordVisible2] = useState(false);
  const initialValues = {
    username: "omarhlal",
    first_name: "عمر",
    last_name: "هلال",
    email: "omarhlal@gmail.com",
    password: "mo8877%%",
    password2: "mo8877%%",
    area: 1,
  };
  const submitHandler = (values) => {
    const userInfo = {
      ...values,
      birth_date: format(dateValue, "yyyy-MM-dd"),
      gender: gender,
      mode: mode,
    };
    postToAPI("api/register/", userInfo)
      .then((res) => {
        console.log(res);
      })
      .catch((err) => console.log(err));
    console.log(userInfo);
  };
  fetchFromAPI("api/register/").then((res) => setListOfAreas(res));
  return (
    <section className="d-flex justify-content-center align-items-center">
      <Formik
        initialValues={initialValues}
        validationSchema={SignInSchema}
        onSubmit={submitHandler}
      >
        {({
          values,
          handleChange,
          isSubmitting,
          handleBlur,
          errors,
          touched,
        }) => (
          <Fragment>
            <form className={`register-1 ${page === 1 ? "hidden" : ""}`}>
              <h1>منزلي</h1>
              <h3>سجل الآن</h3>
              <div className="d-flex gap-5">
                <div className="first-name">
                  <label>
                    الاسم
                    <span>*</span>
                  </label>
                  <input
                    className={`${
                      touched.first_name && errors.first_name ? "error " : null
                    }`}
                    id="first_name"
                    name="first_name"
                    type="text"
                    placeholder="أدخل اسمك باللغةالعربية"
                    onChange={handleChange}
                    onBlur={handleBlur}
                    value={values.first_name}
                  />
                  <p>
                    <ErrorMessage name="first_name" />
                  </p>
                </div>
                <div className="last-name">
                  <label>
                    اسم العائلة
                    <span>*</span>
                  </label>
                  <input
                    className={`${
                      touched.last_name && errors.last_name ? "error " : null
                    }`}
                    id="last_name"
                    name="last_name"
                    type="text"
                    placeholder="أدخل اسم العائلة باللغةالعربية"
                    onChange={handleChange}
                    onBlur={handleBlur}
                    value={values.last_name}
                  />
                  <p>
                    <ErrorMessage name="last_name" />
                  </p>
                </div>
              </div>
              <div className="email">
                <label>
                  البريد الالكتروني
                  <span>*</span>
                </label>
                <input
                  className={`${
                    touched.email && errors.email ? "error " : null
                  }`}
                  id="email"
                  name="email"
                  type="email"
                  placeholder="أدخل البريد الالكتروني الخاص بك"
                  onChange={handleChange}
                  onBlur={handleBlur}
                  value={values.email}
                />
                <p>
                  <ErrorMessage name="email" />
                </p>
              </div>
              <div className="password">
                <label>
                  كلمة المرور
                  <span>*</span>
                </label>

                {/* Password with toggle show/hidden */}
                <div className="position-relative mb-1">
                  <input
                    className={`${
                      touched.password && errors.password ? "error" : null
                    }`}
                    id="password"
                    name="password"
                    type={isPasswordVisible ? "text" : "password"}
                    placeholder="أدخل كلمة المرور الخاصة بك"
                    onChange={handleChange}
                    onBlur={handleBlur}
                    value={values.password}
                  />
                  <button
                    className="eye"
                    type="button"
                    onClick={() => setPasswordVisible(!isPasswordVisible)}
                  >
                    {isPasswordVisible ? (
                      <ion-icon name="eye"></ion-icon>
                    ) : (
                      <ion-icon name="eye-off"></ion-icon>
                    )}
                  </button>
                </div>
                <p>
                  <ErrorMessage name="password" />
                </p>
              </div>
              <div className="password2">
                <label>
                  أكد كلمة المرور
                  <span>*</span>
                </label>

                {/* Password with toggle show/hidden */}
                <div className="position-relative mb-1">
                  <input
                    className={`${
                      touched.password2 && errors.password2 ? "error" : null
                    }`}
                    id="password2"
                    name="password2"
                    type={isPasswordVisible2 ? "text" : "password"}
                    placeholder="أدخل كلمة المرور الخاصة بك"
                    onChange={handleChange}
                    onBlur={handleBlur}
                    value={values.password2}
                  />
                  <button
                    className="eye"
                    type="button"
                    onClick={() => setPasswordVisible2(!isPasswordVisible2)}
                  >
                    {isPasswordVisible2 ? (
                      <ion-icon name="eye"></ion-icon>
                    ) : (
                      <ion-icon name="eye-off"></ion-icon>
                    )}
                  </button>
                </div>
                <p>
                  <ErrorMessage name="password2" />
                </p>
              </div>
              <div className="next" onClick={() => setPage(1)}>
                التالي
              </div>
            </form>
            <form
              onSubmit={(e) => e.preventDefault()}
              className={`register-2 ${page === 0 ? "hidden" : ""}`}
            >
              <h1 className="w-max mx-auto">منزلي</h1>
              <h3 className="w-max mx-auto">سجل الآن</h3>
              <div className="birthdate">
                <label>
                  عيد ميلادك
                  <span>*</span>
                </label>
                <div>
                  <DatePicker
                    format="d/M/yyyy"
                    onChange={setDateValue}
                    value={dateValue}
                  />
                </div>
              </div>
              <div className="area">
                <label>
                  مدينتك
                  <span>*</span>
                </label>
              </div>
              <div className="gender">
                <label>
                  جنسك
                  <span>*</span>
                </label>
                <div key="inline-radio-1" id="inline-radio-1">
                  <Form.Check
                    inline
                    label="ذكر"
                    name="group1"
                    type="radio"
                    onChange={() => setGender("Male")}
                    id="inline-radio-1"
                  />
                  <Form.Check
                    inline
                    label="انثى"
                    name="group1"
                    type="radio"
                    onChange={() => setGender("Female")}
                    id="inline-radio-2"
                  />
                </div>
              </div>
              <div className="mode">
                <label>
                  بائع أم مستخدم <span>*</span>
                </label>
                <div key="inline-radio-2" id="inline-radio-2">
                  <Form.Check
                    inline
                    label="بائع"
                    name="group2"
                    type="radio"
                    onChange={() => setMode("seller")}
                    id="inline-radio-3"
                  />
                  <Form.Check
                    inline
                    label="مستخدم"
                    name="group2"
                    type="radio"
                    onChange={() => setMode("client")}
                    id="inline-radio-4"
                  />
                </div>
              </div>
              <div className="d-flex justify-content-between">
                <div className="prev" onClick={() => setPage(0)}>
                  رجوع
                </div>
                <button
                  className="submit"
                  type="submit"
                  // disabled={isSubmitting}
                  onClick={() => submitHandler(values)}
                >
                  انضم الى منزلي
                </button>
              </div>
            </form>
          </Fragment>
        )}
      </Formik>
    </section>
  );
};
export default Register;
