import Select from "react-select";

const customStyles = {
  control: (provided) => ({
    ...provided,
    backgroundColor: "white",
    color: "black",
    borderRadius: "5px",
    border: "none",
    boxShadow: "none",
    width: "200px",
    height: "40px",
  }),
  option: (provided, state) => ({
    ...provided,
    backgroundColor: state.isSelected ? "#0f3460" : "white",
    color: state.isSelected ? "white" : "#0f3460",
    "&:hover": {
      backgroundColor: "#0f3460",
      color: "white",
    },
  }),
  singleValue: (provided) => ({
    ...provided,
    color: "black",
  }),
};

const AreaSelect = ({ listOfAreas, setAreaSelected }) => {
  const handleChange = (selectedOption) => {
    console.log(selectedOption.value);
    setAreaSelected(
      listOfAreas.filter((item) => item.name === selectedOption.value)[0].id
    );
  };
  let options = [];
  options = listOfAreas?.map((area) => {
    return { value: area.name, label: area.name };
  });

  return (
    <Select
      options={options}
      defaultValue={{ value: "", label: "اختر المدينة" }}
      styles={customStyles}
      onChange={handleChange}
    />
  );
};

export default AreaSelect;
