import { Fragment, useEffect, useState } from "react";
import "./earning.css";
import { Container, Table } from "react-bootstrap";
import { fetchFromAPI } from "../../api/FetchFromAPI";
import Cookies from "js-cookie";
import LoaderContent from "../../Components/LoaderContent/LoaderContent";

const Earnings = () => {
  const [allEarnings, setAllEarnings] = useState(null);
  const storedproviderToken = Cookies.get("providerToken");
  const getAllEarnings = async () => {
    let bearer = `token ${storedproviderToken}`;
    try {
      const res = await fetchFromAPI("services/earnings", {
        headers: {
          Authorization: bearer,
        },
      });
      setAllEarnings(res);
    } catch (err) {
      console.log(err);
    }
  };
  useEffect(() => {
    getAllEarnings();
  }, []);
  return (
    <div className="earnings">
      {allEarnings ? (
        <Fragment>
          <Container>
            <h2 className="mb-5">الأرباح</h2>
          </Container>
          <Table striped bordered hover responsive>
            <thead>
              <tr>
                <th>معرف الخدمة</th>
                <th>اسم الخدمة</th>
                <th>اسم البائع</th>
                <th>قيمة الربح</th>
                <th>الجهة المستفيدة</th>
                <th>تاريخ الربح</th>
              </tr>
            </thead>
            <tbody>
              {allEarnings.map((item) => (
                <tr>
                  <td>{item.home_service.service_id}</td>
                  <td>{item.home_service.title}</td>
                  <td>{item.home_service.full_name}</td>
                  <td>{item.earnings}</td>
                  <td>{item.beneficiary.beneficiary_name}</td>
                  <td>{item.create_date}</td>
                </tr>
              ))}
            </tbody>
          </Table>
        </Fragment>
      ) : (
        <LoaderContent />
      )}
    </div>
  );
};

export default Earnings;
