import { BrowserRouter, Route, Routes } from "react-router-dom";
import Home from "./Pages/Home";
import NavBar from "./Components/Navbar/Navbar";
import Login from "./Components/Login/Login";
import Register from "./Components/Register/Register";
import ConfirmEmail from "./Pages/ConfirmEmail";
import SellerServices from "./Pages/SellerServices/SellerServices";
import UserProfile from "./Pages/UserProfile/UserProfile";

function App() {
  return (
    <BrowserRouter>
      <NavBar />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />
        <Route path="/confirm_email" element={<ConfirmEmail />} />
        <Route path="/user/:username" element={<UserProfile />} />
        <Route path="/user/:username/services" element={<SellerServices />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
