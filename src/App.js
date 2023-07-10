import { BrowserRouter, Route, Routes } from "react-router-dom";
import { Suspense, lazy } from "react";
import NavBar from "./Components/Navbar/Navbar";
import Login from "./Components/Login/Login";
import Register from "./Components/Register/Register";
import Loader from "./Components/Loader/Loader";
import "react-tooltip/dist/react-tooltip.css";
import { Toaster } from "react-hot-toast";
import FilterResults from "./Pages/FilterResults/FilterResults";
import SearchResults from "./Pages/SearchResults/SearchResults";
import SellerRates from "./Pages/SellerRates/SellerRates";
import ForgetPassword from "./Pages/ForgetPassword/ForgetPassword";
import VerificationEmail from "./Pages/VerificationEmail/VerificationEmail";
import NewPassword from "./Pages/NewPassword/NewPassword";
const Home = lazy(() => import("./Pages/Home"));
const ConfirmEmail = lazy(() => import("./Pages/ConfirmEmail"));
const SellerServices = lazy(() =>
  import("./Pages/SellerServices/SellerServices")
);
const UserProfile = lazy(() => import("./Pages/UserProfile/UserProfile"));
const UpdateProfile = lazy(() => import("./Pages/UpdateProfile/UpdateProfile"));
const AddService = lazy(() => import("./Pages/AddService/AddService"));
const ServiceDetails = lazy(() =>
  import("./Pages/ServiceDetails/ServiceDetails")
);
const UpdateService = lazy(() => import("./Pages/UpdateService/UpdateService"));
const MyServiceOrders = lazy(() =>
  import("./Pages/MyServiceOrders/MyServiceOrders")
);
const FillServiceForm = lazy(() =>
  import("./Pages/FillServiceForm/FillServiceForm")
);
const ServiceListPage = lazy(() =>
  import("./Pages/ServiceListPage/ServiceListPage")
);
const MyRecieveOrders = lazy(() =>
  import("./Pages/MyRecieveOrders/MyRecieveOrders")
);
const Balance = lazy(() => import("./Pages/Balance/Balance"));
function App() {
  return (
    <Suspense fallback={<Loader />}>
      <BrowserRouter>
        <Toaster />
        <NavBar />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/loader" element={<Loader />} />
          <Route path="/login" element={<Login />} />
          <Route path="/forget_password" element={<ForgetPassword />} />
          <Route
            path="/forget_password/confirm"
            element={<VerificationEmail />}
          />
          <Route path="/forget_password/reset" element={<NewPassword />} />
          <Route path="/register" element={<Register />} />
          <Route path="/confirm_email" element={<ConfirmEmail />} />
          <Route path="/user/:username" element={<UserProfile />} />
          <Route path="/user/:username/services" element={<SellerServices />} />
          <Route path="/user/:username/rates" element={<SellerRates />} />
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
          <Route path="/services/:name" element={<FilterResults />} />
          <Route path="/search/:name" element={<SearchResults />} />
        </Routes>
      </BrowserRouter>
    </Suspense>
  );
}

export default App;
