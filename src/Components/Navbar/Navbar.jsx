import Male from "../../Images/Male.jpg";
import Female from "../../Images/Female.jpg";
import { Accordion, Container, Nav, Navbar, Offcanvas } from "react-bootstrap";
import { Link, useNavigate } from "react-router-dom";
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

const NavBar = () => {
  const { userTotalInfo, categories } = useSelector(
    (state) => state.homeService
  );
  const [show, setShow] = useState(false);
  const dispatch = useDispatch();
  // const history = useNavigate();
  const handleToggle = () => setShow(!show);
  useEffect(() => {
    const storedUser = localStorage.getItem("userTotalInfo");
    dispatch(setUserTotalInfo(JSON.parse(storedUser)));
    const storedCategories = localStorage.getItem("categories");
    if (storedCategories) {
      dispatch(setCategories(JSON.parse(storedCategories)));
    } else {
      fetchFromAPI("services/categories").then((res) => {
        dispatch(setCategories(res));
        localStorage.setItem("categories", JSON.stringify(res));
      });
    }
  }, [dispatch]);
  const handleCategClick = (name) => {
    console.log("ss");
    dispatch(setSelectedCategory(name));
    localStorage.setItem("selectedCategory", name);
    // const link = getCategoryLink(name);
    // console.log(link);
    // history(`/services/${link}`);
  };
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
            <UserAvatar />
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
              ? userTotalInfo.mode === "client"
                ? normalUserLinks.map((canvasItem, index) => (
                    <Link
                      className="text-decoration-none text-black d-flex gap-2 align-items-center"
                      key={index}
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
                      to={canvasItem.link}
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
                    {categories?.map((cate) => (
                      <Link
                        className="mb-2 text-decoration-none text-black d-flex gap-2 align-items-center"
                        key={cate.id}
                        onClick={() => handleCategClick(cate.name)}
                        to={`/services/${getCategoryLink(cate.name)}`}
                      >
                        <span>{cate.name}</span>
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
