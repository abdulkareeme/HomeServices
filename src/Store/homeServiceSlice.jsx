import { fetchFromAPI } from "../api/FetchFromAPI";

const { createSlice, createAsyncThunk } = require("@reduxjs/toolkit");

const initialState = {
  isRegistered: false,
  userLoginValues: { email: "", password: "" },
  userTotalInfo: null,
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
    setUserLoginValues: (state, action) => {
      state.userLoginValues = action.payload;
    },
    setUserTotalInfo: (state, action) => {
      state.userToken = action.payload;
    },
  },
});

export const { setIsRegistered, setUserLoginValues, setUserTotalInfo } =
  homeServiceSlice.actions;
export default homeServiceSlice.reducer;
