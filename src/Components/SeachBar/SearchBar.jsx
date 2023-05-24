import { useState } from "react";
import "./searchbar.css";
const SearchBar = ({ type, setFilterList }) => {
  const [inputValue, setInputValue] = useState("");
  const handelChange = (input) => {
    setInputValue(input.target.value);
    // setFilterList(
    //   products.filter((item) =>
    //     item.productName?.toLowerCase().includes(inputValue?.toLowerCase())
    //   )
    // );
  };
  return (
    <div
      className={type === "filled" ? "filled-container" : "outlined-container"}
    >
      <input
        type="text"
        placeholder="ابحث عن"
        value={inputValue}
        onChange={handelChange}
      />
      <ion-icon name="search-outline" className="search-icon"></ion-icon>
    </div>
  );
};

export default SearchBar;
