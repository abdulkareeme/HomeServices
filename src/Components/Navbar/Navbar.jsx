import {
  Accordion,
  Container,
  Nav,
  Navbar,
  Offcanvas,
  Spinner,
} from "react-bootstrap";
import { Link } from "react-router-dom";
import {
  accountLinks,
  getCategoryLink,
  normalUserLinks,
  offcanvasAccordion,
  sellerUserLinks,
} from "../../utils/constants";
import "./navbar.css";
import { useEffect, useState } from "react";
import SearchBar from "../SeachBar/SearchBar";
import { useDispatch, useSelector } from "react-redux";
import UserAvatar from "../UserAvatar/UserAvatar";
import {
  setCategories,
  setSelectedCategory,
  setUserTotalInfo,
} from "../../Store/homeServiceSlice";
import { fetchFromAPI } from "../../api/FetchFromAPI";
import Cookies from "js-cookie";

const NavBar = () => {
  const { userTotalInfo, categories, flagToClose } = useSelector(
    (state) => state.homeService
  );
  const [show, setShow] = useState(false);
  const dispatch = useDispatch();
  useEffect(() => {
    const storedUser = Cookies.get("userTotalInfo");
    storedUser !== undefined &&
      dispatch(setUserTotalInfo(JSON.parse(storedUser)));
    const storedCategories = Cookies.get("categories");
    if (storedCategories) {
      dispatch(setCategories(JSON.parse(storedCategories)));
    } else {
      fetchFromAPI("services/categories").then((res) => {
        dispatch(setCategories(res));
        Cookies.set("categories", JSON.stringify(res), { expires: 30 });
      });
    }
  }, [dispatch]);
  useEffect(() => {
    if (flagToClose) setShow(false);
  }, [flagToClose]);
  const handleCategClick = (name) => {
    dispatch(setSelectedCategory(name));
    Cookies.set("selectedCategory", name, { expires: 30 });
  };
  return (
    <Navbar fixed="top" expand="md" className="fixed left-0 top-0 w-screen">
      <Container className="d-flex justify-content-between">
        <Navbar.Brand className="d-flex gap-3" to="/">
          <ion-icon
            onClick={() => setShow(true)}
            className="menu-icon"
            name="menu"
          ></ion-icon>
          <h1 className="m-0 fs-4 text-white">منزلي</h1>
        </Navbar.Brand>
        <ul className="m-0 d-flex gap-3 align-items-center pe-3">
          {userTotalInfo ? (
            <UserAvatar />
          ) : (
            accountLinks.map((navItem, index) => (
              <Nav.Item key={index}>
                <Link
                  className="text-decoration-none text-black"
                  onClick={() => setShow(false)}
                  to={navItem.link}
                >
                  <button className="d-flex gap-2 align-items-center">
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
        <div className="head d-flex gap-3">
          <ion-icon
            onClick={() => setShow(false)}
            className="menu-icon"
            name="menu"
          ></ion-icon>
          <h1 className="m-0 fs-4">منزلي</h1>
        </div>
        <hr />
        <Offcanvas.Body>
          <SearchBar type="outlined" goto="page" />
          <hr />
          <ul className="mt-2 px-4 d-flex flex-column gap-3">
            {userTotalInfo
              ? userTotalInfo.mode === "client"
                ? normalUserLinks.map((canvasItem, index) => (
                    <Link
                      className="text-decoration-none text-black d-flex gap-2 align-items-center"
                      key={index}
                      onClick={() => setShow(false)}
                      to={canvasItem.link}
                    >
                      {canvasItem.icon}
                      <span>{canvasItem.label}</span>
                    </Link>
                  ))
                : sellerUserLinks.map((canvasItem, index) => (
                    <Link
                      className="text-decoration-none text-black d-flex gap-2 align-items-center"
                      key={index}
                      onClick={() => setShow(false)}
                      to={canvasItem.link}
                    >
                      {canvasItem.icon}
                      <span>{canvasItem.label}</span>
                    </Link>
                  ))
              : accountLinks.map((canvasItem, index) => (
                  <Link
                    className="text-decoration-none text-black d-flex gap-2 align-items-center"
                    onClick={() => setShow(false)}
                    key={index}
                    to={canvasItem.link}
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
                    {categories ? (
                      categories.map((cate) => (
                        <Link
                          className="mb-2 text-decoration-none text-black d-flex gap-2 align-items-center"
                          key={cate.id}
                          onClick={() => {
                            handleCategClick(cate.name);
                            setShow(false);
                          }}
                          to={`/services/${getCategoryLink(cate.name)}`}
                        >
                          <span>{cate.name}</span>
                        </Link>
                      ))
                    ) : (
                      <div className="d-flex align-items-center justify-content-center mt-2">
                        <Spinner
                          size="sm"
                          as="span"
                          animation="border"
                          role="status"
                          aria-hidden="true"
                        />
                      </div>
                    )}
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
