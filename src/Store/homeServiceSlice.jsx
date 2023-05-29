import { fetchFromAPI } from "../api/FetchFromAPI";

const { createSlice, createAsyncThunk } = require("@reduxjs/toolkit");

const initialState = {
  isRegistered: false,
  userInputValue: { email: "", password: "" },
  isSelected: 1,
  userTotalInfo: null,
  // userTotalInfo: {
  //   first_name: "عمر",
  //   last_name: "هلال",
  //   gender: "Male",
  //   username: "omarhlal00",
  //   mode: "seller",
  //   date_joined: "2019-08-24T14:15:22Z",
  //   area: "اللاذقية",
  //   bio: "أنا مطور React وproblem solver لدي شغف لتزويد عملائي بمواقع حديثة ونظيفة ومعتمدة بالكامل. من خلال خبرتي في تحليل التطبيقات المعقدة ، قمت ببناء تطبيقات ويب تتوافق مع احتياجات العملاء منlashy portfolio sites إلى single-page applications باستخدام أفضل الممارسات الحالية لتطوير الواجهة الأمامية. تسلط مجموعة المهارات القوية الخاصة بي الضوء على استجابة React.js و Tailwindcss و Bootstrap وReact responsivity مع الخبرة المتزايدة في إنشاء تطبيقات مرنة وتفاعل",
  //   clients_number: 2,
  //   services_number: 3,
  // },
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
    setUserTotalInfo: (state, action) => {
      state.userToken = action.payload;
    },
    setIsSelected: (state, action) => {
      state.isSelected = action.payload;
    },
  },
});

export const {
  setIsRegistered,
  setUserInputValue,
  setIsSelected,
  setUserTotalInfo,
} = homeServiceSlice.actions;
export default homeServiceSlice.reducer;
