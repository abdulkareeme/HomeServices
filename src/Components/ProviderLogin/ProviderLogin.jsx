import { ErrorMessage, Formik } from "formik";
import { memo, useState } from "react";
import * as Yup from "yup";
import { useNavigate } from "react-router-dom";
import "./provider-login.css";
import { postToAPI } from "../../api/FetchFromAPI";
import { Toaster, toast } from "react-hot-toast";
import LoaderButton from "../LoaderButton";
import Cookies from "js-cookie";
import LogoBlack from "../../Images/logo-black.png";

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

const ProviderLogin = () => {
  const history = useNavigate();
  const [isPasswordVisible, setPasswordVisible] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(0);
  const initialValues = { email: "", password: "" };
  const submitHandler = async (values) => {
    setIsSubmitting(1);
    try {
      const res = await postToAPI("api/login_provider", values);
      setIsSubmitting(0);
      const value = {
        is_admin: res?.is_admin,
        balance: res?.balance,
      };
      Cookies.set("providerUser", JSON.stringify(value), {
        expires: 30,
      });
      Cookies.set(
        "providerToken",
        res?.token[0],
        {
          expires: 30,
        },
        { secure: true }
      );
      history("/provider");
    } catch (err) {
      console.log(err);
      setIsSubmitting(0);
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
    }
  };
  return (
    <section className="d-flex justify-content-center align-items-center">
      <Toaster />
      <Formik initialValues={initialValues} validationSchema={SignInSchema}>
        {({ values, isValid, handleChange, handleBlur, errors, touched }) => (
          <form onSubmit={(e) => e.preventDefault()} className="provider-login">
            <div className="logo d-flex gap-2 align-items-start">
              <ion-icon name="star"></ion-icon>
              <img src={LogoBlack} alt="" />
            </div>
            <h2 className="w-max mx-auto">تسجيل دخول كمزود</h2>
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
              className={!isValid ? "submit disable" : "submit"}
              disabled={!isValid}
              type="submit"
              hidden={isSubmitting}
              onClick={() => submitHandler(values)}
            >
              دخول
            </button>
            <LoaderButton isSubmitting={isSubmitting} color="my-btn" />
          </form>
        )}
      </Formik>
    </section>
  );
};
export default memo(ProviderLogin);
