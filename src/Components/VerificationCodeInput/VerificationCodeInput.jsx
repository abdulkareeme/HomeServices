import { useEffect, useRef } from "react";
import "./verification-code-input.css";
import { postToAPI } from "../../api/FetchFromAPI";
import { useDispatch, useSelector } from "react-redux";
import { toast } from "react-hot-toast";
import { setUserTotalInfo } from "../../Store/homeServiceSlice";
import { useNavigate } from "react-router-dom";
const VerificationCodeInput = () => {
  const { userInputValue } = useSelector((state) => state.homeService);
  const dispatch = useDispatch();
  const history = useNavigate();
  const inputRefs = [
    useRef(null),
    useRef(null),
    useRef(null),
    useRef(null),
    useRef(null),
    useRef(null),
  ];
  const checkFields = () => {
    for (let i = 0; i < inputRefs.length; i++) {
      if (inputRefs[i].current.value === "") return false;
    }
    return true;
  };

  const handleKeyDown = (e, index) => {
    if (e.key === "ArrowRight") {
      // Move focus to the previous input field when ArrowLeft is pressed
      if (index > 0) {
        inputRefs[index - 1].current.focus();
      }
    } else if (e.key === "ArrowLeft") {
      // Move focus to the next input field when ArrowRight is pressed
      if (index < inputRefs.length - 1) {
        inputRefs[index + 1].current.focus();
      }
    } else if (e.key === "Backspace") {
      inputRefs[index].current.value = "";
    }
  };
  const handleCodeChange = (e, index) => {
    const value = e.target.value;
    if (!/^[0-9]*$/.test(value)) inputRefs[index].current.value = "";
    else {
      if (value.length === 1) {
        if (index > 0) {
          // Move focus to the previous input field when a character is entered
          inputRefs[index - 1].current.focus();
        }
      }
    }
  };

  const getCode = () => {
    let code = [];
    for (let i = 0; i < inputRefs.length; i++) {
      code.unshift(inputRefs[i].current.value);
    }
    return code.join("");
  };
  let inputFields = [];
  for (let i = 0; i < 6; i++) {
    inputFields.push(
      <input
        key={i}
        type="text"
        maxLength="1"
        onChange={(e) => handleCodeChange(e, i)}
        onKeyDown={(e) => handleKeyDown(e, i)}
        ref={inputRefs[i]}
      />
    );
  }
  const handleSubmit = (e) => {
    e.preventDefault();
    if (checkFields()) {
      console.log(getCode());
      const confirmData = {
        confirmation_code: getCode(),
        email: userInputValue.email,
      };
      postToAPI("api/confirm_email", confirmData)
        .then((res) => {
          postToAPI("api/login/", userInputValue).then((res) => {
            dispatch(setUserTotalInfo(res));
            console.log(res);
            history("/");
          });
          toast.success(
            "رمز التحقق صحيح الرجاء الانتظار بينما يتم تحويلك الى الصفحة الرئيسية",
            {
              duration: 5000,
              position: "top-center",
              ariaProps: {
                role: "status",
                "aria-live": "polite",
              },
            }
          );
        })
        .catch((err) => {
          console.log(err);
          if (err.response.data.detail === "Wrong code please try again") {
            toast.error("رمز التحقق غير صحيح", {
              duration: 3000,
              position: "top-center",
              ariaProps: {
                role: "status",
                "aria-live": "polite",
              },
            });
          } else if (err.response.data.detail === "Email already verified") {
            toast.error("هذا البريد مفعل مسبقا", {
              duration: 3000,
              position: "top-center",
              ariaProps: {
                role: "status",
                "aria-live": "polite",
              },
            });
          } else if (err.response.data.detail.includes("Try again")) {
            toast.error("حاول مجددا بعد 24 ساعة", {
              duration: 3000,
              position: "top-center",
              ariaProps: {
                role: "status",
                "aria-live": "polite",
              },
            });
          }
        });
    } else {
      alert("Wrong fill!");
    }
  };
  useEffect(() => {
    inputRefs[inputRefs.length - 1].current.focus();
  }, []);
  return (
    <form className="verification-code-form" onSubmit={handleSubmit}>
      <div className="verification-code-input">{inputFields}</div>
      <button type="submit">ارسال</button>
    </form>
  );
};

export default VerificationCodeInput;
