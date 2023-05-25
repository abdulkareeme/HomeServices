import show from "../Images/show-service.png";
import order from "../Images/order-service.png";
import recieve from "../Images/recieve-service.png";

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
    label: "المشتريات",
    icon: <ion-icon name="cart-outline"></ion-icon>,
    link: "/",
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
    link: "/",
  },
  {
    label: "نقل أثاث منزل",
    link: "/",
  },
  {
    label: "صيانة",
    link: "/",
  },
];

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
