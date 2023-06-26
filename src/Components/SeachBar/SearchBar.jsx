import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { setClearResults, setFlagToClose } from "../../Store/homeServiceSlice";
import { useDispatch } from "react-redux";
import "./searchbar.css";
const SearchBar = ({ type, goto }) => {
  const [inputValue, setInputValue] = useState("");
  const history = useNavigate();
  const dispatch = useDispatch();
  const handelSubmit = () => {
    if (goto === "page") {
      dispatch(setFlagToClose(true));
      history(`/search/${inputValue}`);
    } else dispatch(setClearResults(true));
    localStorage.setItem("searchWord", inputValue);
  };
  return (
    <div
      className={type === "filled" ? "filled-container" : "outlined-container"}
    >
      <input
        type="text"
        placeholder="ابحث عن"
        value={inputValue}
        onChange={(e) => setInputValue(e.target.value)}
      />
      <ion-icon
        onClick={() => inputValue.length > 0 && handelSubmit()}
        name="search-outline"
        className="search-icon"
      ></ion-icon>
    </div>
  );
};

export default SearchBar;
