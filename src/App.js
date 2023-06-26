import { BrowserRouter, Route, Routes } from "react-router-dom";
import { Suspense, lazy } from "react";
import NavBar from "./Components/Navbar/Navbar";
import Login from "./Components/Login/Login";
import Register from "./Components/Register/Register";
import Loader from "./Components/Loader/Loader";
// import Home from "./Pages/Home";
// import ConfirmEmail from "./Pages/ConfirmEmail";
// import SellerServices from "./Pages/SellerServices/SellerServices";
// import UserProfile from "./Pages/UserProfile/UserProfile";
// import UpdateProfile from "./Pages/UpdateProfile/UpdateProfile";
// import Balance from "./Pages/Balance/Balance";
// import AddService from "./Pages/AddService/AddService";
// import ServiceDetails from "./Pages/ServiceDetails/ServiceDetails";
// import UpdateService from "./Pages/UpdateService/UpdateService";
// import MyServiceOrders from "./Pages/MyServiceOrders/MyServiceOrders";
// import FillServiceForm from "./Pages/FillServiceForm/FillServiceForm";
// import ServiceListPage from "./Pages/ServiceListPage/ServiceListPage";
// import MyRecieveOrders from "./Pages/MyRecieveOrders/MyRecieveOrders";
import "react-tooltip/dist/react-tooltip.css";
import { Toaster } from "react-hot-toast";
import FilterResults from "./Pages/FilterResults/FilterResults";
import SearchResults from "./Pages/SearchResults/SearchResults";
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
          <Route path="/services/:name" element={<FilterResults />} />
          <Route path="/search/:name" element={<SearchResults />} />
        </Routes>
      </BrowserRouter>
    </Suspense>
  );
}

export default App;
