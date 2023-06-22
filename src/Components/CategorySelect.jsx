import { useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import Select from "react-select";
import { fetchFromAPI } from "../api/FetchFromAPI";
import { setCategories } from "../Store/homeServiceSlice";

const customStyles = {
  control: (provided) => ({
    ...provided,
    backgroundColor: "#f7f9fc",
    color: "black",
    borderRadius: "5px",
    border: "none",
    boxShadow: "none",
    width: "100%",
    height: "40px",
  }),
  option: (provided, state) => ({
    ...provided,
    backgroundColor: state.isSelected ? "#0f3460" : "#f7f9fc",
    color: state.isSelected ? "#f7f9fc" : "#0f3460",
    "&:hover": {
      backgroundColor: "#0f3460",
      color: "#f7f9fc",
    },
  }),
  singleValue: (provided) => ({
    ...provided,
    color: "black",
  }),
};

const CategorySelect = ({ read = false, value = null, setCategoryService }) => {
  const { categories } = useSelector((state) => state.homeService);
  const dispatch = useDispatch();
  if (!categories) {
    const storedCategories = localStorage.getItem("categories");
    if (!storedCategories) {
      fetchFromAPI("services/categories").then((res) => {
        dispatch(setCategories(res));
        localStorage.setItem("categories", JSON.stringify(res));
      });
    } else dispatch(setCategories(JSON.parse(storedCategories)));
  }
  const handleChange = (selectedOption) => {
    setCategoryService(selectedOption.value);
  };
  let options = [];
  options = categories?.map((area) => {
    return { value: area.id, label: area.name };
  });
  let defaultValue = { value: value?.id, label: value?.name };
  return (
    <Select
      isDisabled={read}
      value={defaultValue}
      options={options}
      placeholder="اختر تصنيف"
      styles={customStyles}
      onChange={handleChange}
    />
  );
};

export default CategorySelect;
