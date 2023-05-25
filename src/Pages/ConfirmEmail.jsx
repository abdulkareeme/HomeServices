import { useEffect } from "react";
import { useSelector } from "react-redux";
import { useNavigate } from "react-router-dom";

const ConfirmEmail = () => {
  const history = useNavigate();
  const { isRegistered } = useSelector((state) => state.homeService);
  useEffect(() => {
    isRegistered
      ? setTimeout(() => {
          history("/login");
        }, 4000)
      : setTimeout(() => {
          history("/");
        }, 4000);
  }, []);
  if (isRegistered) {
    return (
      <section className="confirm-email w-100 mt-6 d-flex flex-column justify-content-center align-items-center">
        <h1>يرجى تأكيد عنوان بريدك الالكتروني</h1>
        <h3>شكراً لتسجيلك في موقعنا</h3>
        <p className="fs-5">
          {" "}
          يرجى الدخول إلى بريدك الإلكتروني والبحث عن رسالة تحتوي على رابط
          التأكيد
        </p>
      </section>
    );
  } else {
    return (
      <section className="confirm-email w-100 mt-6 d-flex flex-column justify-content-center align-items-center">
        <h1>اعادة التوجيه الى الصفحة الرئيسية</h1>
      </section>
    );
  }
};

export default ConfirmEmail;
