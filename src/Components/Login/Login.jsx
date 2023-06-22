import { ErrorMessage, Formik } from "formik";
import { memo, useEffect, useState } from "react";
import * as Yup from "yup";
import { Link, useNavigate } from "react-router-dom";
import "./login.css";
import { postToAPI } from "../../api/FetchFromAPI";
import { ClipLoader } from "react-spinners";
import { Toaster, toast } from "react-hot-toast";
import { useDispatch, useSelector } from "react-redux";
import {
  setUserInputValue,
  setUserToken,
  setUserTotalInfo,
} from "../../Store/homeServiceSlice";
const SignInSchema = Yup.object().shape({
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
});

const Login = () => {
  const history = useNavigate();
  const dispatch = useDispatch();
  // const { userTotalInfo, userToken } = useSelector(
  //   (state) => state.homeService
  // );
  const [isPasswordVisible, setPasswordVisible] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(0);
  const initialValues = { email: "", password: "" };
  const submitHandler = (values) => {
    setIsSubmitting(1);
    postToAPI("api/login/", values)
      .then((res) => {
        console.log(res);
        setIsSubmitting(0);
        // console.log(res);
        dispatch(setUserTotalInfo(res?.user_info));
        dispatch(setUserToken(res?.token[0]));
        localStorage.setItem("userTotalInfo", JSON.stringify(res?.user_info));
        localStorage.setItem("userToken", JSON.stringify(res?.token[0]));
        history("/");
      })
      .catch((err) => {
        console.log(err);
        setIsSubmitting(0);
        dispatch(
          setUserInputValue({ email: values.email, password: values.password })
        );
        if (err.response.data.email?.length > 0) {
          if (err.response.data.email[0] === "Email must be confirmed") {
            toast.error("يرجى تأكيد البريد الالكتروني", {
              duration: 3000,
              position: "top-center",
              ariaProps: {
                role: "status",
                "aria-live": "polite",
              },
            });
            setTimeout(() => {
              history("/confirm_email");
            }, 4000);
          } else if (err.response.data.email[0] === "Email does not exist") {
            toast.error("الحساب غير موجود يرجى التسجيل على الموقع", {
              duration: 3000,
              position: "top-center",
              ariaProps: {
                role: "status",
                "aria-live": "polite",
              },
            });
          }
        } else if (err.response.data.non_field_errors?.length > 0) {
          toast.error("كلمة المرور غير صحيحة", {
            duration: 3000,
            position: "top-center",
            ariaProps: {
              role: "status",
              "aria-live": "polite",
            },
          });
        }
      });
  };
  return (
    <section className="d-flex justify-content-center align-items-center">
      <Toaster />
      <Formik initialValues={initialValues} validationSchema={SignInSchema}>
        {({ values, handleChange, setSubmitting, errors, touched }) => (
          <form onSubmit={(e) => e.preventDefault()} className="login">
            <h1>منزلي</h1>
            <h3>تسجيل دخول</h3>
            <div className="email">
              <label>
                البريد الالكتروني
                <span>*</span>
              </label>
              <input
                className={`${touched.email && errors.email ? "error " : null}`}
                id="email"
                name="email"
                type="email"
                placeholder="أدخل البريد الالكتروني الخاص بك"
                onChange={handleChange}
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
                  value={values.password}
                />
                <button
                  className="eye"
                  type="button"
                  onClick={() => setPasswordVisible(!isPasswordVisible)}
                >
                  {isPasswordVisible ? (
                    <ion-icon name="eye-outline"></ion-icon>
                  ) : (
                    <ion-icon name="eye-off-outline"></ion-icon>
                  )}
                </button>
              </div>
              <p>
                <ErrorMessage name="password" />
              </p>
            </div>
            <button
              className="submit"
              type="submit"
              hidden={isSubmitting}
              onClick={() => submitHandler(values)}
            >
              دخول
            </button>
            <button
              className="submit"
              disabled={isSubmitting}
              hidden={!isSubmitting}
            >
              <ClipLoader
                color="white"
                size={30}
                aria-label="Loading Spinner"
                data-testid="loader"
              />
            </button>
            <span>
              لا تملك حساب ؟
              <Link className="text-decoration-none" to="/register">
                سجل الآن
              </Link>
            </span>
          </form>
        )}
      </Formik>
    </section>
  );
};
export default memo(Login);
