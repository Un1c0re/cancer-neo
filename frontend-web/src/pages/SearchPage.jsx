import React, {useEffect, useState} from 'react';
import Search from "../assets/Search.jsx";
import PatientCard from "../components/PatientCard.jsx";
import {Link, useNavigate} from "react-router-dom";
import {useDispatch, useSelector} from "react-redux";
const SearchPage = () => {
    const doctorId = useSelector(state => state.doctorId.doctorId)
    const navigate = useNavigate()
    const BACKEND_URL = import.meta.env.VITE_BACKEND_URL
    const [patients, setPatients] = useState([{}])
    const [querry, setQuerry] = useState('')
    useEffect(() => {
        if(doctorId.length === 0){
            navigate("/")
        }else {
            fetch(BACKEND_URL + "/patients/")
                .then(response => response.json())
                .then(data => {
                    setPatients(data)
                })
        }
    }, []);

    return (
        <div className="w-screen min-h-screen">
            <div className="w-full h-full self-strech pt-[73px] pb-[181px] bg-sky-100 flex-col justify-start items-center gap-[90px] inline-flex">
                <div className="self-stretch flex-col justify-center items-center inline-flex">
                    <div className="text-center text-[#6B9CD6] text-[84.46px] font-bold text_Jost">NeoCancer</div>
                    <div className="text-center text-[#6B9CD6] text-[40px] font-normal text_Jost">для врачей</div>
                </div>
                <div className="self-stretch flex-col justify-center items-center gap-5 inline-flex">
                    <div className="text-center text-[#6B9CD6] text-[28.88px] font-normal text_Jost">Поиск пациента</div>
                    <div className="flex-col justify-center items-center gap-5 flex">
                        <div className="w-[525.25px] justify-start items-end inline-flex">
                            <div className="grow shrink basis-0 h-[74px] bg-white rounded-tl-[18.05px] rounded-bl-[18.05px] shadow justify-start items-center flex">
                                <input onChange={(e) => setQuerry(e.target.value)} type="search" name="search" className="bg-white w-full h-full rounded-tl-[18.05px] rounded-bl-[18.05px] px-8 py-5 text-black text_Jost text-[24px]"/>
                            </div>
                            <div className="w-[90.25px] h-[74px] p-5 bg-[#6B9CD6] cursor-pointer rounded-tr-[18.05px] rounded-br-[18.05px] shadow justify-center items-center gap-2.5 flex">
                                <Search/>
                            </div>
                        </div>
                        <div className="w-full pb-16 self-stretch bg-white rounded-[18.05px] shadow flex-col flex">
                            {patients.length !== 0 ?
                            patients.map((patient, index) =>
                            ((doctorId === patient?.doctor_id?.id || patient?.doctor_id?.id === 0 ) && (patient.name.toLowerCase().includes(querry.toLowerCase()) || querry === '') ) ?
                                <PatientCard name={patient.name} date={patient.birthdate} id={patient.id} attached={patient.doctor_id.id} key={index} /> : <></>
                            ) : <></>}
                        </div>
                    </div>
                    <Link to={"/"}>
                        <div className="text-center text-[#6B9CD6] text-[28.88px] font-normal text_Jost underline">Выйти</div>
                    </Link>
                </div>
            </div>
        </div>
    );
};

export default SearchPage;