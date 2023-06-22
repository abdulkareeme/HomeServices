import { fetchFromAPI } from "../api/FetchFromAPI";

const { createSlice, createAsyncThunk } = require("@reduxjs/toolkit");

const initialState = {
  isRegistered: true,
  userInputValue: { email: "", password: "" },
  isSelected: 1,
  areasList: null,
  userTotalInfo: null,
  userToken: null,
  categories: null,
  selectedServiceToUpdate: null,
  selectedCategory: null,
};

export const getNewRelease = createAsyncThunk(
  "homeService/getNewRelease",
  async (args) => {
    try {
      const response = fetchFromAPI(
        `discover/${args}?sort_by=release_date.desc`
      );
      return response;
    } catch (error) {
      console.log(error);
    }
  }
);

const homeServiceSlice = createSlice({
  name: "homeService",
  initialState,
  reducers: {
    setIsRegistered: (state, action) => {
      state.isRegistered = action.payload;
    },
    setUserInputValue: (state, action) => {
      state.userInputValue = action.payload;
    },
    setCategories: (state, action) => {
      state.categories = action.payload;
    },
    setUserTotalInfo: (state, action) => {
      state.userTotalInfo = action.payload;
    },
    setUserToken: (state, action) => {
      state.userToken = action.payload;
    },
    setIsSelected: (state, action) => {
      state.isSelected = action.payload;
    },
    setAreasList: (state, action) => {
      state.areasList = action.payload;
    },
    setSelectedServiceToUpdate: (state, action) => {
      state.selectedServiceToUpdate = action.payload;
    },
    setSelectedCategory: (state, action) => {
      state.selectedCategory = action.payload;
    },
  },
});

export const {
  setIsRegistered,
  setUserInputValue,
  setIsSelected,
  setUserTotalInfo,
  setUserToken,
  setCategories,
  setAreasList,
  setSelectedServiceToUpdate,
  setSelectedCategory,
} = homeServiceSlice.actions;
export default homeServiceSlice.reducer;
