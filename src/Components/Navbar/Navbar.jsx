import Male from "../../Images/Male.jpg";
import Female from "../../Images/Female.jpg";
import { Accordion, Container, Nav, Navbar, Offcanvas } from "react-bootstrap";
import { Link } from "react-router-dom";
import {
  accountLinks,
  categories,
  normalUserLinks,
  offcanvasAccordion,
} from "../../utils/constants";
import "./navbar.css";
import { useState } from "react";
import SearchBar from "../SeachBar/SearchBar";
import { useSelector } from "react-redux";

const NavBar = () => {
  const [show, setShow] = useState(false);
  const handleToggle = () => setShow(!show);
  const { userTotalInfo } = useSelector((state) => state.homeService);
  return (
    <Navbar fixed="top" expand="md" className="fixed left-0 top-0 w-screen">
      <Container className="d-flex justify-content-between">
        <Navbar.Brand className="d-flex gap-3" to="/">
          <ion-icon
            onClick={handleToggle}
            className="menu-icon"
            name="menu"
          ></ion-icon>
          <h1 className="m-0 fs-4 text-white">منزلي</h1>
        </Navbar.Brand>
        <ul className="m-0 d-flex gap-3 align-items-center pe-3">
          {userTotalInfo ? (
            <img src={userTotalInfo.gender === "Male" ? Male : Female} alt="" />
          ) : (
            accountLinks.map((navItem, index) => (
              <Nav.Item key={index}>
                <Link
                  className="text-decoration-none text-black"
                  to={navItem.link}
                >
                  <button className="my-btn d-flex gap-2 align-items-center">
                    {navItem.icon}
                    <span className="fs-6">{navItem.label}</span>
                  </button>
                </Link>
              </Nav.Item>
            ))
          )}
        </ul>
      </Container>
      <Offcanvas placement="end" show={show}>
        <Offcanvas.Body>
          <SearchBar type="outlined" />
          <hr />
          <ul className="mt-2 px-4 d-flex flex-column gap-3">
            {userTotalInfo
              ? normalUserLinks.map((canvasItem, index) => (
                  <Link
                    className="text-decoration-none text-black d-flex gap-2 align-items-center"
                    key={index}
                  >
                    {canvasItem.icon}
                    <span>{canvasItem.label}</span>
                  </Link>
                ))
              : accountLinks.map((canvasItem, index) => (
                  <Link
                    className="text-decoration-none text-black d-flex gap-2 align-items-center"
                    key={index}
                  >
                    {canvasItem.icon}
                    <span>{canvasItem.label}</span>
                  </Link>
                ))}
            <Accordion>
              {offcanvasAccordion.map((canvasItem, index) => (
                <Accordion.Item key={index} eventKey="0">
                  <Accordion.Header>
                    <div className="d-flex align-items-center gap-2">
                      {canvasItem.icon}
                      {canvasItem.label}
                    </div>
                  </Accordion.Header>
                  <Accordion.Body>
                    {categories.map((cate, index) => (
                      <Link
                        className="mb-2 text-decoration-none text-black d-flex gap-2 align-items-center"
                        key={index}
                      >
                        <span>{cate.label}</span>
                      </Link>
                    ))}
                  </Accordion.Body>
                </Accordion.Item>
              ))}
            </Accordion>
          </ul>
        </Offcanvas.Body>
      </Offcanvas>
    </Navbar>
  );
};

export default NavBar;
