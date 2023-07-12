import { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import Select from "react-select";
import { fetchFromAPI } from "../api/FetchFromAPI";
import { setAreasList } from "../Store/homeServiceSlice";
import Cookies from "js-cookie";

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

const MultiAreaSelect = ({ value = null, setAreasServiceList }) => {
  const { areasList } = useSelector((state) => state.homeService);
  const [defaultValue, setDefaultValue] = useState(
    value?.map((item) => {
      return { value: item.id, label: item.name };
    })
  );
  const dispatch = useDispatch();
  if (!areasList) {
    const storedAreas = Cookies.get("areasList");
    if (!storedAreas) {
      fetchFromAPI("api/register/").then((res) => {
        dispatch(setAreasList(res));
        Cookies.set("areasList", JSON.stringify(res), { expires: 10 });
      });
    } else dispatch(setAreasList(JSON.parse(storedAreas)));
  }
  const handleChange = (selectedOption) => {
    let list = [];
    console.log(selectedOption);
    setDefaultValue(selectedOption);
    for (let i = 0; i < selectedOption.length; ++i) {
      list = [
        ...list,
        // areasList.filter((item) => item.name === selectedOption[i].value)[0].id,
        selectedOption[i].value,
      ];
    }
    console.log(list);
    setAreasServiceList(list);
  };
  let options = [];
  options = areasList?.map((area) => {
    return { value: area.id, label: area.name };
  });

  return (
    <Select
      value={defaultValue}
      options={options}
      isMulti={true}
      placeholder="اختر المدن"
      styles={customStyles}
      onChange={handleChange}
    />
  );
};

export default MultiAreaSelect;
