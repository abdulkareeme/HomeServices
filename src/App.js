import { BrowserRouter, Route, Routes } from "react-router-dom";
import Home from "./Pages/Home";
import NavBar from "./Components/Navbar/Navbar";
import Login from "./Components/Login/Login";
import Register from "./Components/Register/Register";
import ConfirmEmail from "./Pages/ConfirmEmail";
import SellerServices from "./Pages/SellerServices/SellerServices";
import UserProfile from "./Pages/UserProfile/UserProfile";
import UpdateProfile from "./Pages/UpdateProfile/UpdateProfile";
import Balance from "./Pages/Balance/Balance";
import { Toaster } from "react-hot-toast";
import AddService from "./Pages/AddService/AddService";
import ServiceDetails from "./Pages/ServiceDetails/ServiceDetails";
import UpdateService from "./Pages/UpdateService/UpdateService";
import MyServiceOrders from "./Pages/MyServiceOrders/MyServiceOrders";
import FillServiceForm from "./Pages/FillServiceForm/FillServiceForm";
import ServiceListPage from "./Pages/ServiceListPage/ServiceListPage";
import "react-tooltip/dist/react-tooltip.css";
import MyRecieveOrders from "./Pages/MyRecieveOrders/MyRecieveOrders";
function App() {
  return (
    <BrowserRouter>
      <Toaster />
      <NavBar />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />
        <Route path="/confirm_email" element={<ConfirmEmail />} />
        <Route path="/user/:username" element={<UserProfile />} />
        <Route path="/user/:username/services" element={<SellerServices />} />
        <Route path="/user/:username/balance" element={<Balance />} />
        <Route path="/service/new" element={<AddService />} />
        <Route path="/service/:id/update" element={<UpdateService />} />
        <Route
          path="/user/:username/services/:id"
          element={<ServiceDetails />}
        />
        <Route
          path="/user/:username/update_profile"
          element={<UpdateProfile />}
        />
        <Route path="/service/:id/update" element={<UpdateService />} />
        <Route path="/service/:id/fill_form" element={<FillServiceForm />} />
        <Route path="/my_order" element={<MyServiceOrders />} />
        <Route path="/my_recieve_order" element={<MyRecieveOrders />} />
        <Route path="/services/:name" element={<ServiceListPage />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
