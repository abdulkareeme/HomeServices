import { useState } from "react";
import { Spinner } from "react-bootstrap";
import { postToAPI } from "../../api/FetchFromAPI";
import { Toaster, toast } from "react-hot-toast";
import { useNavigate } from "react-router-dom";
import * as Yup from "yup";
import "./forget-password.css";
import { ErrorMessage, Formik } from "formik";

const EmailSchema = Yup.object().shape({
  email: Yup.string()
    .email("أدخل بريد الكتروني صالح")
    .required("لم تدخل بريدك الالكتروني بعد"),
});
const ForgetPassword = () => {
  const [isSubmitting, setIsSubmitting] = useState(0);
  const history = useNavigate();
  const initialValues = { email: "" };
  const submitHandler = async (values) => {
    console.log(values.email);
    try {
      toast("الرجاء الانتظار", {
        duration: 3000,
        position: "top-center",
        ariaProps: {
          role: "status",
          "aria-live": "polite",
        },
      });
      setIsSubmitting(1);
      await postToAPI(
        "api/send_forget_password_code",
        { email: values.email },
        null
      );
      setIsSubmitting(0);
      localStorage.setItem("forgetPassEmail", values.email);
      toast("تم الطلب بنجاح وسيتم تحويلك الى التحقق من الرمز", {
        duration: 2000,
        position: "top-center",
        ariaProps: {
          role: "status",
          "aria-live": "polite",
        },
      });
      setTimeout(() => {
        history("/forget_password/confirm");
      }, 2000);
    } catch (err) {
      setIsSubmitting(0);
      console.log(err);
      if (err.response?.data?.email[0] === "This field is required") {
        toast.error("الرجاء ادخال بريدك الالكتروني", {
          duration: 3000,
          position: "top-center",
          ariaProps: {
            role: "status",
            "aria-live": "polite",
          },
        });
      } else if (
        err.response?.data?.email[0] === "Please input a valid email"
      ) {
        toast.error("الرجاء ادخال بريد الكتروني صالح", {
          duration: 3000,
          position: "top-center",
          ariaProps: {
            role: "status",
            "aria-live": "polite",
          },
        });
      } else if (err.response?.data?.detail === "Email does not exist") {
        toast.error("الرجاء ادخال بريدك الالكتروني", {
          duration: 3000,
          position: "top-center",
          ariaProps: {
            role: "status",
            "aria-live": "polite",
          },
        });
      } else if (err.response.status === 500) {
        toast.error("حصل خطأ غير متوقع الرجاء اعادة المحاولة", {
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
      <Formik initialValues={initialValues} validationSchema={EmailSchema}>
        {({ values, handleChange, handleBlur, errors, touched }) => (
          <form onSubmit={(e) => e.preventDefault()} className="forget">
            <h2>نسيت كلمة المرور؟</h2>
            <h5>يرجى إدخال عنوان البريد الإلكتروني المرتبط بحسابك أدناه:</h5>
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
                required
                placeholder="أدخل البريد الالكتروني الخاص بك"
                value={values.email}
                onBlur={handleBlur}
                onChange={handleChange}
              />
              <p>
                <ErrorMessage name="email" />
              </p>
            </div>
            <button
              className="my-btn"
              type="submit"
              //   disable={touched.email && errors.email}
              hidden={isSubmitting}
              onClick={() => submitHandler(values)}
            >
              ارسال
            </button>
            <button
              className="my-btn"
              disabled={isSubmitting}
              hidden={!isSubmitting}
            >
              <Spinner
                as="span"
                animation="border"
                role="status"
                aria-hidden="true"
              />
            </button>
          </form>
        )}
      </Formik>
    </section>
  );
};

export default ForgetPassword;
