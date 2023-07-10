import Male from "../../Images/Male.jpg";
import Female from "../../Images/Female.jpg";
import { ErrorMessage, Formik } from "formik";
import DatePicker from "react-date-picker";
import * as Yup from "yup";
import AreaSelect from "../../Components/AreaSelect";
import { useRef, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import "./update-profile.css";
import { format } from "date-fns";
import { Container, ListGroup } from "react-bootstrap";
import { putToAPI } from "../../api/FetchFromAPI";
import { Toaster, toast } from "react-hot-toast";
import { setUserToken, setUserTotalInfo } from "../../Store/homeServiceSlice";
import {
  isString,
  updateUserTotalInfo,
} from "../../utils/constants";
import { useNavigate, useParams } from "react-router-dom";
import LoaderButton from "../../Components/LoaderButton";

const SignInSchema = Yup.object().shape({
  first_name: Yup.string()
    .required("لم تدخل اسمك بعد")
    .min(3, "الاسم الذي أدخلته قصير جداً. 3 أحرف هو الحد الأدنى")
    .max(15, "الاسم الذي أدخلته كبير جداً. 15 أحرف هو الحد الأقصى"),
  last_name: Yup.string()
    .required("لم تدخل اسم العائلة بعد")
    .min(3, "اسم العائلة الذي أدخلته قصير جداً. 3 أحرف هو الحد الأدنى")
    .max(15, "اسم العائلة الذي أدخلته كبير جداً. 15 أحرف هو الحد الأقصى"),
});
const UpdateProfile = () => {
  const { userTotalInfo, userToken } = useSelector(
    (state) => state.homeService
  );
  const dispatch = useDispatch();
  const history = useNavigate();
  const { username } = useParams();
  if (userTotalInfo === null) {
    const storedUser = localStorage.getItem("userTotalInfo");
    dispatch(setUserTotalInfo(JSON.parse(storedUser)));
  }
  if (userToken === null) {
    const storedToken = localStorage.getItem("userToken");
    dispatch(setUserToken(JSON.parse(storedToken)));
  }
  const [dateValue, setDateValue] = useState(userTotalInfo?.birth_date);
  const [bioValue, setBioValue] = useState(userTotalInfo?.bio);
  const [areaSelected, setAreaSelected] = useState(userTotalInfo?.area_name);
  const [showList, setShowList] = useState(false);
  const [file, setFile] = useState(null);
  const [imageUrl, setImageUrl] = useState(null);
  const [imageFile, setImageFile] = useState(null);
  const [isSubmitting, setIsSubmitting] = useState(0);
  const fileInputRef = useRef(null);
  const initialValues = {
    first_name: userTotalInfo?.first_name,
    last_name: userTotalInfo?.last_name,
  };
  const handleSubmit = (values) => {
    const imageData = new FormData();
    imageData.append("file", file);
    // const fileData = new FormData();
    // fileData.append("file", imageData);
    for (const pair of imageData.entries()) {
      setImageFile(pair[1]);
    }
    let bearer = `token ${userToken}`;
    console.log("submit");
    const user = {
      bio: bioValue,
      user: {
        first_name: values.first_name,
        last_name: values.last_name,
        birth_date: isString(dateValue)
          ? dateValue
          : format(dateValue, "yyyy-MM-dd"),
        area: isString(areaSelected) ? userTotalInfo?.area_id : areaSelected,
      },
    };
    console.log(user);
    setIsSubmitting(1);
    toast("يتم الآن تحديث المعلومات", {
      duration: 3000,
      position: "top-center",
      ariaProps: {
        role: "status",
        "aria-live": "polite",
      },
    });
    putToAPI("api/update_profile", user, {
      headers: {
        Authorization: bearer,
      },
    })
      .then(async (res) => {
        await updateUserTotalInfo(dispatch, userTotalInfo, setUserTotalInfo);
        toast.success("تم تحديث المعلومات بنجاح", {
          duration: 3000,
          position: "top-center",
          ariaProps: {
            role: "status",
            "aria-live": "polite",
          },
        });
        setIsSubmitting(0);
        setTimeout(() => {
          history(`/user/${username}`);
        }, 3000);
      })
      .catch((err) => {
        setIsSubmitting(0);
        console.log(err);
      });
  };
  const handleFileInputChange = (e) => {
    console.log(e.target.files[0]);
    setFile(e.target.files[0]);
    const reader = new FileReader();
    reader.onload = (event) => {
      setImageUrl(event.target.result);
      console.log(event.target.result);
    };
    reader.readAsDataURL(e.target.files[0]);
  };
  const handleButtonClick = () => {
    fileInputRef.current.click();
  };
  return (
    <section className="update-profile d-flex justify-content-center align-items-center">
      <Toaster />
      <Formik initialValues={initialValues} validationSchema={SignInSchema}>
        {({ values, handleChange, handleBlur, errors, touched }) => (
          <Container className="d-flex justify-content-center align-items-center">
            <form
              onSubmit={(e) => e.preventDefault()}
              action=""
              encType="multipart/form-data"
            >
              <h3>المعلومات الشخصية</h3>
              <div className="image-holder">
                <img src={userTotalInfo?.photo} alt="profile" />
                <div className="overlay">
                  <ion-icon
                    name="camera"
                    onClick={() => setShowList(!showList)}
                  ></ion-icon>
                </div>
                <ListGroup hidden={!showList}>
                  <ListGroup.Item
                    action
                    onClick={() => {
                      handleButtonClick();
                      setShowList(0);
                    }}
                  >
                    <span className="w-max">رفع صورة جديدة</span>
                    <input
                      id="file-upload"
                      ref={fileInputRef}
                      type="file"
                      accept="image/*"
                      onChange={handleFileInputChange}
                      style={{
                        display: "none",
                      }}
                    />
                  </ListGroup.Item>
                  <ListGroup.Item
                    action
                    onClick={() => {
                      fileInputRef.current.value = "";
                      setFile(null);
                      setImageUrl(null);
                      setShowList(0);
                    }}
                  >
                    <span className="w-max">حذف</span>
                  </ListGroup.Item>
                </ListGroup>
              </div>
              <div className="d-flex gap-5">
                <div className="first-name">
                  <label>
                    الاسم
                    <span>*</span>
                  </label>
                  <input
                    className={`${
                      touched.first_name && errors.first_name ? "error " : null
                    }`}
                    id="first_name"
                    name="first_name"
                    type="text"
                    placeholder="أدخل اسمك باللغةالعربية"
                    onChange={handleChange}
                    onBlur={handleBlur}
                    value={values.first_name}
                  />
                  <p>
                    <ErrorMessage name="first_name" />
                  </p>
                </div>
                <div className="last-name">
                  <label>
                    اسم العائلة
                    <span>*</span>
                  </label>
                  <input
                    className={`${
                      touched.last_name && errors.last_name ? "error " : null
                    }`}
                    id="last_name"
                    name="last_name"
                    type="text"
                    placeholder="أدخل اسم العائلة باللغةالعربية"
                    onChange={handleChange}
                    onBlur={handleBlur}
                    value={values.last_name}
                  />
                  <p>
                    <ErrorMessage name="last_name" />
                  </p>
                </div>
              </div>
              <div className="birthdate">
                <label>
                  عيد ميلادك
                  <span>*</span>
                </label>
                <div>
                  <DatePicker
                    format="d/M/yyyy"
                    onChange={setDateValue}
                    value={dateValue}
                  />
                </div>
              </div>
              <div className="area">
                <label>
                  مدينتك
                  <span>*</span>
                </label>
                <AreaSelect
                  areaSelected={areaSelected}
                  setAreaSelected={setAreaSelected}
                />
              </div>
              {userTotalInfo?.mode === "seller" ? (
                <div className="bio">
                  <label>
                    النبذة التعريفية
                    <span>*</span>
                  </label>
                  <textarea
                    onChange={(e) => setBioValue(e.target.value)}
                    name="bio"
                    id=""
                    rows="9"
                  >
                    {bioValue}
                  </textarea>
                </div>
              ) : null}
              <button
                className="my-btn"
                hidden={isSubmitting}
                onClick={() => handleSubmit(values)}
              >
                حفظ التعديلات
              </button>
              <LoaderButton isSubmitting={isSubmitting} color="my-btn" />
            </form>
          </Container>
        )}
      </Formik>
    </section>
  );
};

export default UpdateProfile;
