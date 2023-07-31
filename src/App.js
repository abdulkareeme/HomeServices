import { Route, Routes, useLocation } from "react-router-dom";
import { Suspense, lazy } from "react";
import NavBar from "./Components/Navbar/Navbar";
import Loader from "./Components/Loader/Loader";
import ProtectedPath from "./Components/ProtectedPath";
import "react-tooltip/dist/react-tooltip.css";
import { Toaster } from "react-hot-toast";
import Cookies from "js-cookie";
import Footer from "./Components/Footer/Footer";
import ProviderLogin from "./Components/ProviderLogin/ProviderLogin";
import Earnings from "./Pages/Earnings/Earnings";
import ProviderNavbar from "./Components/ProviderNavbar/ProviderNavbar";
//Website Pages
const Home = lazy(() => import("./Pages/Home"));
const ProviderPage = lazy(() => import("./Pages/ProviderPage/ProviderPage"));
const Login = lazy(() => import("./Components/Login/Login"));
const Register = lazy(() => import("./Components/Register/Register"));
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
const MyRecieveOrders = lazy(() =>
  import("./Pages/MyRecieveOrders/MyRecieveOrders")
);
const FilterResults = lazy(() => import("./Pages/FilterResults/FilterResults"));
const SearchResults = lazy(() => import("./Pages/SearchResults/SearchResults"));
const SellerRates = lazy(() => import("./Pages/SellerRates/SellerRates"));
const ForgetPassword = lazy(() =>
  import("./Pages/ForgetPassword/ForgetPassword")
);
const VerificationEmail = lazy(() =>
  import("./Pages/VerificationEmail/VerificationEmail")
);
const NewPassword = lazy(() => import("./Pages/NewPassword/NewPassword"));
function App() {
  const token = Cookies.get("userToken");
  const {pathname} =useLocation();
  return (
    <Suspense fallback={<Loader />}>
        <Toaster />
        {pathname!=="/provider" && pathname!=="/website_earnings"?<NavBar />:<ProviderNavbar/>}
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/provider" element={<ProviderPage />} />
          <Route path="/website_earnings" element={<Earnings />} />


          <Route path="/login" element={<Login />} />
          <Route path="/provider_login" element={<ProviderLogin />} />

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
          <Route
            path="/service/new"
            element={<ProtectedPath comp={<AddService />} cond={token} />}
          />
          <Route
            path="/service/:id/update"
            element={<ProtectedPath comp={<UpdateService />} cond={token} />}
          />
          <Route
            path="/user/:username/services/:id"
            element={<ServiceDetails />}
          />
          <Route
            path="/user/:username/update_profile"
            element={<ProtectedPath comp={<UpdateProfile />} cond={token} />}
          />
          <Route
            path="/service/:id/fill_form"
            element={<ProtectedPath comp={<FillServiceForm />} cond={token} />}
          />
          <Route
            path="/my_order"
            element={<ProtectedPath comp={<MyServiceOrders />} cond={token} />}
          />
          <Route
            path="/my_recieve_order"
            element={<ProtectedPath comp={<MyRecieveOrders />} cond={token} />}
          />
          <Route path="/services/:name" element={<FilterResults />} />
          <Route path="/search/:name" element={<SearchResults />} />
        </Routes>
        <Footer/>
    </Suspense>
  );
}

export default App;
