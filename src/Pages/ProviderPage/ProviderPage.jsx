import { Container, Navbar } from "react-bootstrap";
import { Link } from "react-router-dom";
import Logo from "../../Images/logo.png";
import "./provider-page.css";
import Cookies from "js-cookie";
import { useEffect, useState } from "react";
const ProviderPage = () => {
  const [providerUser, setProviderUser] = useState(null);
  const [providerToken, setProviderToken] = useState(null);
  useEffect(() => {
    const storedproviderUser = Cookies.get("ProviderUser");
    const storedproviderToken = Cookies.get("ProviderToken");
    storedproviderUser && setProviderUser(JSON.stringify(storedproviderUser));
    storedproviderToken && setProviderToken(storedproviderToken);
  }, []);
  return (
    <div className="provider">
      <Navbar fixed="top" expand="md" className="fixed left-0 top-0 w-screen">
        <Container className="d-flex justify-content-between">
          <Navbar.Brand
            className="d-flex gap-2 align-items-start"
            to="/provider"
          >
            <ion-icon name="star"></ion-icon>
            <Link to="/provider" className="logo text-black">
              <img src={Logo} alt="Logo" />
            </Link>
          </Navbar.Brand>
        </Container>
      </Navbar>
      <Container>
        <div className="balance d-flex justify-content-center flex-column gap-1">
          <div className="d-flex align-items-center gap-3 mx-auto">
            <h1 className="w-max">رصيدك المتاح</h1>
            <ion-icon name="cash-outline"></ion-icon>
          </div>
          <span className="infinity w-max mx-auto">∞</span>
        </div>
      </Container>
    </div>
  );
};

export default ProviderPage;
