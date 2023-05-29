import { useEffect } from "react";
import { useSelector } from "react-redux";
import { useNavigate } from "react-router-dom";
import VerificationCodeInput from "../Components/VerificationCodeInput/VerificationCodeInput";

const ConfirmEmail = () => {
  const history = useNavigate();
  const { isRegistered } = useSelector((state) => state.homeService);
  useEffect(() => {
    !isRegistered &&
      setTimeout(() => {
        history("/");
      }, 3000);
  }, []);
  if (isRegistered) {
    return (
      <section className="confirm-email w-100 mt-6 d-flex flex-column justify-content-center align-items-center">
        <h1>يرجى تأكيد عنوان بريدك الالكتروني</h1>
        <h3>شكراً لتسجيلك في موقعنا</h3>
        <p className="fs-5">
          {" "}
          يرجى التحقق من صندوق البريد الوارد والعثور على بريدنا الإلكتروني الذي
          يحتوي على رمز التحقق
        </p>
        <VerificationCodeInput />
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
