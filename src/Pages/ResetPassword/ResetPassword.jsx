import VerificationEmail from "../VerificationEmail/VerificationEmail";
import NewPassword from "../NewPassword/NewPassword";
import { useSelector } from "react-redux";

const ResetPassword = () => {
  const { resetPasswordPage } = useSelector((state) => state.homeService);
  return resetPasswordPage === 0 ? <VerificationEmail /> : <NewPassword />;
};

export default ResetPassword;
