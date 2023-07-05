import { useEffect, useState } from "react";
import { useSelector } from "react-redux";
import { useNavigate } from "react-router-dom";
import VerificationCodeInput from "../Components/VerificationCodeInput/VerificationCodeInput";
import { Container } from "react-bootstrap";
import { postToAPI } from "../api/FetchFromAPI";
import { Toaster, toast } from "react-hot-toast";

const ConfirmEmail = () => {
  const history = useNavigate();
  const { isRegistered, userInputValue } = useSelector(
    (state) => state.homeService
  );
  const [isSubmitting, setIsSubmitting] = useState(false);
  useEffect(() => {
    !isRegistered &&
      setTimeout(() => {
        history("/");
      }, 3000);
  }, []);
  const resendCode = () => {
    setIsSubmitting(true);
    toast("يتم اعادة ارسال رمز التخقق بنجاح", {
      duration: 3000,
      position: "top-center",
      ariaProps: {
        role: "status",
        "aria-live": "polite",
      },
    });
    postToAPI("api/resend_email_code", { email: userInputValue.email })
      .then((res) => {
        console.log(res);
        setIsSubmitting(false);
        toast.success("تم اعادة ارسال رمز التخقق بنجاح", {
          duration: 3000,
          position: "top-center",
          ariaProps: {
            role: "status",
            "aria-live": "polite",
          },
        });
      })
      .catch((err) => {
        console.log(err);
        setIsSubmitting(false);
      });
  };
  if (isRegistered) {
    return (
      <section className="confirm-email mt-6 d-flex justify-content-center align-items-center">
        <Toaster />
        <Container className="w-100 d-flex flex-column gap-2">
          <h1>يرجى تأكيد عنوان بريدك الالكتروني</h1>
          <h3>شكراً لتسجيلك في موقعنا</h3>
          <p className="fs-5">
            {" "}
            يرجى التحقق من صندوق البريد الوارد والعثور على بريدك الإلكتروني الذي
            يحتوي على رمز التحقق
          </p>
          <VerificationCodeInput />
          <div className="resend-code d-flex gap-1">
            <p>لم يصلك رمز التحقق بعد؟</p>
            <span onClick={() => (!isSubmitting ? resendCode() : null)}>
              اعادة الارسال
            </span>
          </div>
        </Container>
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
