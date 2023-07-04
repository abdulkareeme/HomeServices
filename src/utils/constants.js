import show from "../Images/show-service.png";
import order from "../Images/order-service.png";
import recieve from "../Images/recieve-service.png";
import { fetchFromAPI } from "../api/FetchFromAPI";
import Male from "../Images/Male.jpg";
import Female from "../Images/Female.jpg";

export const BASE_API_URL = "http://abdulkareemedres.pythonanywhere.com";
export const navbarLinks = [
  {
    label: "الصفحة الرئيسية",
    link: "/الرئيسية",
  },
  {
    label: "من نحن",
    link: "/من نحن",
  },
];

export const accountLinks = [
  {
    label: "حساب جديد",
    icon: <ion-icon name="person-add-outline"></ion-icon>,
    link: "/register",
  },
  {
    label: "دخول",
    icon: <ion-icon name="log-in-outline"></ion-icon>,
    link: "/login",
  },
];
export const normalUserLinks = [
  {
    label: "الطلبات المرسلة",
    icon: <ion-icon name="cart-outline"></ion-icon>,
    link: "/my_order",
  },
];
export const sellerUserLinks = [
  {
    label: "أضف خدمة",
    icon: <ion-icon name="add-circle-outline"></ion-icon>,
    link: "/service/new",
  },
  ...normalUserLinks,
  {
    label: "الطلبات الواردة",
    icon: <ion-icon name="arrow-undo-circle-outline"></ion-icon>,
    link: "/my_recieve_order",
  },
];

export const offcanvasAccordion = [
  {
    label: "التصنيفات",
    icon: <ion-icon name="cube-outline"></ion-icon>,
  },
];

export const categories = [
  {
    label: "تنظيف",
    link: "/services/Cleaning",
  },
  {
    label: "نقل أثاث منزل",
    link: "/services/Home_Furniture_Move",
  },
  {
    label: "صيانة",
    link: "/services/Maintenance",
  },
];
export const getCategoryLink = (cate) => {
  if (cate === "صيانة") return "Maintenance";
  else if (cate === "تنظيف") return "Cleaning";
  else return "Home_Furniture_Move";
};
export const howItWorksBoxes = [
  {
    icon: show,
    head: "استعرض الخدمات",
    text: "ابحث عن الخدمة التي تحتاجها باستخدام مربع البحث في الأعلى أو عبر التصنيفات.",
  },
  {
    icon: order,
    head: "اطلب الخدمة",
    text: "راجع وصف الخدمة وتقييمات المشترين ثم اطلبها لفتح تواصل مع البائع.",
  },
  {
    icon: recieve,
    head: "اطلب الخدمة",
    text: "راجع وصف الخدمة وتقييمات المشترين ثم اطلبها لفتح تواصل مع البائع.",
  },
];

export const commonQuetionsData = [
  {
    id: "0",
    head: "ما هو منزلي؟",
    text: "منزلي هو موقع عربي لبيع وشراء الخدمات المنزلية.يؤمن سهولة الوصول لمزودي الخدمات المناسبين الخاصة بالمنزل، ويساعد مزودي الخدمة على تنمية وتطوير أعمالهم كما يعتبر الموقع حلاً مريحاً وسهلاً للأشخاص الذين يحتاجون إلى خدمات منزلية بسرعة وكفاءة",
  },
  {
    id: "1",
    head: "كيف يمكنني حجز خدمة على الموقع؟",
    text: "يمكن حجز الخدمة عن طريق زيارة الموقع واختيار الخدمة المطلوبة وتعبئة النموذج الخاص بالحجز",
  },
  {
    id: "2",
    head: "هل يمكن للمستخدمين تحديد نوع من العمال المناسب لتنفيذ الخدمة؟",
    text: "نعم، يمكن للمستخدمين تحديد نوع العمال المطلوبة لتقديم الخدمة المطلوبة، مثل العمالة المنزلية أو الفنيين المتخصصين في الصيانة. يمكن للمستخدمين الاطلاع على ملفات العمال المتاحين على الموقع وقراءة تقييماتهم وتقييمات المستخدمين الآخرين للمساعدة في اختيار العامل المناسب لتقديم الخدمة",
  },
  {
    id: "3",
    head: "هل يتم تقديم خدمات التنظيف للمنازل فقط أم يشمل ذلك المكاتب والمحلات التجارية أيضًا؟",
    text: "يتم تقديم خدمات التنظيف لجميع الأماكن، بما في ذلك المنازل والمكاتب والمحلات التجارية. يمكن للمستخدمين تحديد نوع الخدمة التي يرغبون في الحصول عليها وتحديد الموقع المطلوب للتنظيف",
  },
];
const statusObj = {
  Pending: { label: "جاري الطلب", color: "yellow" },
  Rejected: { label: "مرفوض", color: "#e20e0e" },
  Underway: { label: "جاري التنفيذ", color: "#ffaf1d" },
};

export const handleRateStars = (avg) => {
  const value = Math.round(avg);
  let stars = [];
  for (let i = 0; i < value; ++i) {
    stars.push(<ion-icon name="star"></ion-icon>);
  }
  for (let i = 0; i < 5 - value; ++i) {
    stars.push(<ion-icon name="star-outline"></ion-icon>);
  }
  return stars;
};

export const updateUserTotalInfo = async (
  dispatch,
  userTotalInfo,
  setUserTotalInfo
) => {
  try {
    const userUpdateInfo = await fetchFromAPI(
      `api/user/${userTotalInfo?.username}`
    );
    localStorage.setItem("userTotalInfo", JSON.stringify(userUpdateInfo));
    dispatch(setUserTotalInfo(userUpdateInfo));
  } catch (err) {
    console.log(err);
  }
};
export const getUserPhoto = (photo, gender) => {
  if (photo === null) {
    return gender === "Male" ? Male : Female;
  } else return photo;
};
export const isString = (value) => {
  return typeof value === "string" || value instanceof String;
};
export const getStatus = (
  id,
  status,
  is_rateable,
  setSelectedRate,
  setShowRateModal
) => {
  if (status === "Expire" && is_rateable) {
    return (
      <button
        onClick={() => {
          setSelectedRate(id);
          setShowRateModal(true);
        }}
        className="have-to-rate"
      >
        بحاجة إلى تقييم
        <ion-icon name="star"></ion-icon>
      </button>
    );
  } else if (status === "Underway" && is_rateable) {
    return (
      <button
        onClick={() => {
          setSelectedRate(id);
          setShowRateModal(true);
        }}
        className="have-to-rate"
      >
        تقييم وانهاء
        <ion-icon name="star"></ion-icon>
      </button>
    );
  } else if (status === "Expire" && !is_rateable) {
    return (
      <div className="d-flex gap-2 align-items-center">
        <span style={{ backgroundColor: "green" }} className="circle"></span>
        <span>تم الانتهاء</span>
      </div>
    );
  } else {
    return (
      <div className="d-flex gap-2 align-items-center">
        <span
          style={{ backgroundColor: statusObj[status].color }}
          className="circle"
        ></span>
        <span>{statusObj[status].label}</span>
      </div>
    );
  }
};
export const shortInfo = {
  "نقل أثاث منزل":
    "نضمن لك نقل أثاث منزلك بأمان وجودة عالية وفي الوقت المحدد، بفريق عمل مدرب ومجهز بأحدث الأدوات والمعدات لتلبية جميع احتياجاتك",
  صيانة:
    "توفر خدمات الصيانة لجميع أنواع الأجهزة الإلكترونية والكهربائية، بفريق فنيين محترفين وخبرة واسعة، لتضمن لك أعلى مستويات الأداء والجودة",
  تنظيف:
    "نوفر لك خدمات تنظيف شاملة لمنزلك أو مكتبك بأعلى مستويات الجودة، بفريق عمل مدرب ومجهز بأحدث المعدات والمنظفات الآمنة، لتحصل على نتائج مثالية وتلبية جميع متطلباتك واحتياجاتك",
};

export const rates = [
  {
    id: 0,
    quality_of_service: 3,
    commitment_to_deadline: 4,
    work_ethics: 5,
    client_comment: "شكرا على الخدمة",
    seller_comment: null,
    rating_time: "2019-08-24T14:15:22Z",
    service_name: "صيانة منزل",
    category: "صيانة",
    client: {
      first_name: "عبد الكريم",
      last_name: "ادريس",
      username: "abd01",
      photo: Male,
    },
  },
  {
    id: 1,
    quality_of_service: 3,
    commitment_to_deadline: 4,
    work_ethics: 5,
    client_comment: "شكرا على",
    seller_comment: null,
    rating_time: "2019-08-24T14:15:22Z",
    service_name: "صيانة منزل",
    category: "صيانة",
    client: {
      first_name: "عبد الكريم",
      last_name: "ادريس",
      username: "abd01",
      photo: Male,
    },
  },
  {
    id: 2,
    quality_of_service: 3,
    commitment_to_deadline: 4,
    work_ethics: 5,
    client_comment: "على الخدمة",
    seller_comment: null,
    rating_time: "2019-08-24T14:15:22Z",
    service_name: "صيانة منزل",
    category: "صيانة",
    client: {
      first_name: "عبد الكريم",
      last_name: "ادريس",
      username: "abd01",
      photo: Female,
    },
  },
];
