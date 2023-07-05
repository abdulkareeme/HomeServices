import { useState } from "react";
import { Container } from "react-bootstrap";
import { Toaster, toast } from "react-hot-toast";
import "./verification-email.css";
import { postToAPI } from "../../api/FetchFromAPI";
import VerificationCodeInput from "../../Components/VerificationCodeInput/VerificationCodeInput";
import { useEffect } from "react";

const VerificationEmail = () => {
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [forgetPassEmail, setForgetPassEmail] = useState(false);
  console.log(forgetPassEmail);
  useEffect(() => {
    setForgetPassEmail(localStorage.getItem("forgetPassEmail"));
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
    postToAPI("api/resend_email_code", { email: forgetPassEmail })
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
  return (
    <section className="verification-email mt-6 d-flex justify-content-center align-items-center">
      <Toaster />
      <Container className="w-100 d-flex flex-column gap-2">
        <h1 className="w-max mx-auto">اعادة تعيين كلمة المرور</h1>
        <p className="fs-5 w-max mx-auto">
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
};

export default VerificationEmail;
